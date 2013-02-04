package com.xmaser.game.puzzles 
{
	import com.greensock.easing.Back;
	import com.greensock.easing.Bounce;
	import com.greensock.TweenLite;
	import com.xmaser.game.puzzles.model.BlockVO;
	import com.xmaser.game.puzzles.view.BlockViewer;
	import com.xmaser.utils.ObjectUtil;
	import com.xmaser.utils.TimerFunction;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author wdc
	 */
	public class Puzzle 
	{
		private var _mapArr:Array;
		private var _gridArr:Array;
		protected var _gridItems:Array;
		protected var _gridWidth:Number = 30;
		protected var _gridHeight:Number = 30;
		private var _items:Array = [];
		private var _pause:Boolean;
		/**
		 * 上，下，左，右
		 */
		private var _dirArr:Array = [[1, 0], [0, 1], [ -1, 0], [0, -1]];
		private var _downIngTime:TimerFunction;
		protected var _main:Sprite;
		protected var _downIng:Boolean;
		protected var _uping:Boolean;
		protected var _rowNum:int=0
		
		protected var _deleteTotalNum:int=0;
		public var ItemPUZClass:Class = BlockViewer;
		
		public function Puzzle(main:Sprite) 
		{
			_main = main;
		}
		
		public function createMap(map:Array, blockClass:Class):void 
		{
			_mapArr = map;
			
			_gridArr = [];
			_gridItems = [];
			for (var i:int = 0; i <_mapArr.length; i++) 
			{
				_gridItems[i] = [];
				_items[i] = [];
				for (var j:int = 0; j < _mapArr[i].length; j++) 
				{
					if (!checkNeedCrateItem(j, i, _mapArr[i][j])) 
					{
						_gridItems[i][j] = null;
						continue;
					}
					createItemBefore(j,i,_mapArr[i][j])
					var blockVo:BlockVO = new BlockVO();
					blockVo.type = _mapArr[i][j];
					blockVo.x = j;
					blockVo.y = i;
					
					var item:BlockViewer = new ItemPUZClass();
					//item.addEventListener(MouseEvent.MOUSE_DOWN, __gridItemMOUSE_DOWN);
					//item.addEventListener(MouseEvent.MOUSE_UP, __gridItemMOUSE_UP);
					item.blockWidth = _gridWidth; item.blockHeight = _gridHeight;
					item.vo = blockVo;
					_main.addChild(item);
					item.x = _gridWidth * j;
					item.y = _gridHeight * i;
					_gridItems[i][j] = item
					_items[i][j] = blockVo;
					createItemAfter(item);
				}
				
			}
			_rowNum = _mapArr.length;
		}
		
	
		public function delItem(bv:BlockViewer, len:int=3):void 
		{
		
			_items[bv.vo.y][bv.vo.x] = null;
			_gridItems[bv.vo.y][bv.vo.x] = null;
			
			bv.remove(len);
			
		}
		
		private function down():void 
		{
			
			
			var bv:BlockViewer;
			var next:BlockViewer;
			var num:int = 0;
			var isSameDown:Boolean = false;
			
			
			_downIngTime.rePlay();
			
			_downIng = true;
			
			for (var i:int = _mapArr.length-1; i >=0; i--) 
			{
				for (var j:int = 0; j<_mapArr[i].length ; j++) 
				{
					bv = next = null; 
					num = 0;
					
					bv = _gridItems[i][j];
					if (!bv)
					{
						continue;
					}
					if (_gridItems[i + 1])
					{
						/*next = _gridItems[i + 1][j];
						if (!next)
						{
							num++;
						}else
						{
							continue;
						}*/
						var n:int = i + 1;
						while (_gridItems[n]) 
						{
							next = _gridItems[n][j];
							//trace( "next : " + next );
							if (!next)
							{
								//trace( "空的 : " + next , n + 1, j);
								num++;
							}else
							{
								break;
							}
							n++;
						}
					}else
					{
						
					}
					if (num > 0)
					{
						isSameDown = true;
						dowItem(bv, num);
						
					}
					
				}
			}
			//
			//_downIngTimeOut=setTimeout(function():void { _downIng = false }, 500);
			setTimeout(checkHaveSame,500)
			
				
			
			
			isSameDown = false;
		}
		
		private function downOver():void 
		{
			trace( "downOver : " + downOver );
			_downIng = false;
			checkHaveSame()
		}
		
		private function dowItem(bv:BlockViewer, num:int):void 
		{
			TweenLite.to(bv, 0.2, { y:bv.y + num * _gridHeight,onComplete:onBlockDownComplete,onCompleteParams:[bv,num],ease:Bounce.easeOut  } );
			//TweenLite.to(bv, 0.3, {delay:1, onComplete:checkHaveSame } );
			//TweenLite.to(bv, 0.3, { y:bv.y + num * _gridHeight} );
			
			
			//bv.y += num * _gridHeight;
			
			_gridItems[bv.vo.y ][bv.vo.x] = null;
			var bb:BlockVO = new BlockVO(); 
			bb.type = -1;
			var bb1:BlockViewer = new ItemPUZClass();
			bb1.blockWidth = _gridWidth;
			bb1.blockHeight = _gridHeight;
			bb1.vo = bb;
			_gridItems[bv.vo.y+num ][bv.vo.x]=bb1
		}
		
		private function onBlockDownComplete(bv:BlockViewer,num:int):void 
		{
			
			
			bv.vo.y += num;
			_gridItems[bv.vo.y ][bv.vo.x] = bv;
			bv.updateTest();
			
			
		}
		protected var _lastSpecialType:int;
		public function checkHaveSame():void 
		{
			if (_pause)
			{
				return;
			}
			if (!_downIngTime)
			{
				_downIngTime = new TimerFunction(1000, downOver);
			}else
			{
				
			}
			//trace("checkHaveSame: " + _downIng);
			if (_lastSpecialType == 4)
			{
				//trace("_lastSpecialType: " + _lastSpecialType);
				return;
			}
			var bv:BlockViewer;
			var hasSame:Boolean = false;
			var len:int;
			for (var i:int = _mapArr.length-1; i >=0; i--) 
			{
				for (var j:int = 0; j<_mapArr[i].length ; j++) 
				{
					bv = _gridItems[i][j];
					
					if (bv)//&&i==_mapArr.length-1&&j==0
					{
						var res:Object = getItemSame(bv);
						if (ObjectUtil.getLength(res) >= 3)
						{
							for (var name2:String in res) 
							{
								_lastSpecialType = BlockViewer(res[name2]).deleteBySpecial;
								
								
								break;
							}
							hasSame = true;
							res = changeItems(res);
							var res2:Array = getItemSame2(res);
							for (var name:String in res2) 
							{
								res[name] = res2[name];
							}
							len=ObjectUtil.getLength(res)
							delItems(res);
							
							_downIng = true;
							_deleteTotalNum++;
							afterDelItem(bv,len);
							return;
						}
					}
				}
				
			}
			
			if (hasSame == false&&_downIng==false)
			{
				//trace( "hasSame : " + hasSame );
				//
				onNoHasSame();
			}
			
			
		}
		/**
		 * 
		 * @param	bv
		 * @param	delLen	此次共删除了几个
		 */
		protected function afterDelItem(bv:BlockViewer, delLen:int):void 
		{
			
		}
		
		protected function onNoHasSame():void 
		{
			
		}
		/**
		 * 变身
		 * @param	res
		 */
		protected function changeItems(o:Object):Object		
		{
			var res:Object = { };
			//4 个;
			
			var len:int = ObjectUtil.getLength(o);
			
			
			if (len > 3)
			{
				if (checkHasSpecialIn(o) == false)
				{
					var del:Object=ObjectUtil.removeAtIndex(o, 0);
					BlockViewer(del).change(len);
				}
				
			}
			
			return o
		}
		
		/**
		 * 检查有没有 变身 的在里面
		 * @param	o
		 * @return
		 */
		private function checkHasSpecialIn(o:Object):Boolean 
		{
			for each (var item:BlockViewer in o ) 
			{
				if (item.vo.special != -1)
				{
					return true;
				}
			}
			return false;
		}
		
		
		
		protected function getItemSame(bv:BlockViewer):Array 
		{
			var res:Array = [];
			//if (bv.vo.x == 2 && bv.vo.y == 2)
			//{
				//trace()
			//}
			res = getItemSameDiGui(bv, res);
			
			//if (bv.vo.x == 2 && bv.vo.y == 2)
			//{
				//trace()
			//}
			var len:int = 0;
			var del:int=-1;
			for each (var item3:BlockViewer in res) 
			{
				len++;
				
			
				if (item3&&item3.vo.special!=-1)
				{
					del = item3.vo.special
				}
			}
			for each (var item44:BlockViewer in res) 
			{
	
				item44.deleteBySpecial = del;
			}
			
			bv.updateTest(len)
			if (len>=3) 
			{
				var sa:Array = [];
				for (var name2:String in sa) 
				{
					res[name2] = sa[name2];
				}
				
				for each (var item2:BlockViewer in res) 
				{
					//item2.selected = true;
				}
			}else
			{
				
			}
			for each (var item4:BlockViewer in res) 
			{
				item4.searched = false;
				
			}
			return res;
		}
		
		protected function getItemSame2(res:Object):Array 
		{
			return [];
		}
		private function getItemSameDiGui(bv:BlockViewer,ar:Array):Array
		{
			var res:Array = ar;
			bv.searched = true;
			//trace(bv, "======================");
			var o:Object = { };
				for each (var item:Array in _dirArr) 
				{
					var o2:Object = searchSameFromDir(bv, item);
					o = ObjectUtil.join(o2, o);
				}
				for (var name:String in o) 
				{
					res[name] = o[name];
					
					//trace("res[name]: " + res[name],o[name].searched);
					
					
					if (o[name].searched == false)
					{
						
						
						getItemSameDiGui(o[name], res);
					}
				}
			
			return res;
		}
		
		protected function delItems(res:Object):void 
		{
			for each (var item:BlockViewer in res) 
			{
				
				if (item)
				{
					delItem(item, ObjectUtil.getLength(res) );
				}
			}
			down();
		}
		public function findSame(res:Array, len:int):void 
		{
			
		}
		/**
		 *  找出它上下左右4个方向的格子
		 * @param	rea
		 * @return
		 */
		protected function searchFromDir(rea:Object):* 
		{
			var res:*=[]
			for each (var item:BlockViewer in rea) 
			{
				if (item&&item.vo.special!=-1)
				{
					trace( "item.vo.special : " + item.vo.special );
					var yy:int = item.vo.y; 
					var xx:int =item.vo.x;
					var o:BlockViewer
					if (item.vo.special == 1)
					{
						
						get4DirectionBlocks(item, res,1);
						trace("a")
					}else if (item.vo.special==2) 
					{
						yy++;
						while (_gridItems[yy]&&_gridItems[yy][xx]) 
						{
							o = _gridItems[yy][xx ];
							o.deleteBySpecial = 2;
							res[o.name] = o;
							yy++;
						}
						
					}else if (item.vo.special==3) 
					{
						var resLeft:Object=getLeftDirectionBlocks(item);
						var resRight:Object = getRightDirectionBlocks(item);
						var resTop:Object
						res=ObjectUtil.join(resLeft, resRight, res);
					}
				}
			}
			return res;
		}
		
		private function getRightDirectionBlocks(item:BlockViewer):Object 
		{
			var res:Object = { };
			for (var i:int = 0; i <item.vo.x; i++) 
			{
				var b1:BlockViewer = _gridItems[item.vo.y][i];
				if (!b1) continue;
				res[b1.name] = b1;
			}
			
			return res;
		}
		
		private function getLeftDirectionBlocks(item:BlockViewer):Object 
		{
			var res:Object = { };
			for (var j:int = item.vo.x+1; j <_gridItems[item.vo.y].length; j++) 
			{
				var b2: BlockViewer = _gridItems[item.vo.y][j];
				if (!b2) continue;
				res[b2.name] = b2;
			}
			return res;
		}
		protected function get4DirectionBlocks(item:BlockViewer, res:Object,delBySpecial:int=-1):Object
		{
			//var res:Array = [];
			var yy:int = item.vo.y; 
			var xx:int =item.vo.x;
			var o:BlockViewer
			for (var i:int = 0; i < _dirArr.length; i++) 
			{
				var dir:Array = _dirArr[i];
				if (_gridItems[yy+dir[0]] && _gridItems[yy+dir[0]][xx+dir[1]])
				{
					o = _gridItems[yy + dir[0]][xx + dir[1]];
					o.deleteBySpecial = delBySpecial;
					res[o.name] = o;
				}
			}
						
			return res;
		}
		private function searchSameFromDir(item:BlockViewer,dir:Array,needSameNum:int = 3):Array
		{
			//trace("searchSameFromDir: " + item,dir);
			
			var oyy:int = item.vo.y; 
			var xx:int =item.vo.x;
			var yy:int;
			yy =oyy+ dir[0];
			var a:Array = [];
			while (_gridItems[yy]&&_gridItems[yy][xx]) 
			{
				if (_gridItems[yy][xx].vo.type==item.vo.type) 
				{
					//_gridItems[yy][xx].selected = true;
					a[_gridItems[yy][xx].name] = (_gridItems[yy][xx]);
					//_gridItems[yy][xx].searched = true;
				}else
				{
					break;
				}
				//trace(_gridItems[yy][xx]);
				//if (dir[0] != 0)
				yy += dir[0];
				//if (dir[1] != 0)
				xx += dir[1];
				
			}

			return a;
		}
		private function downUp(bv:BlockViewer):void 
		{
			var dis:int = 1;
			for (var i:int = bv.vo.y-1; i>=0; i--) 
			{
				var item:BlockViewer =_gridItems[i][bv.vo.x] 
				if (!item)
				{
					dis++;
					continue;
				}
				item.y += dis * _gridHeight;
				_gridItems[item.vo.y ][item.vo.x] = null;
				_gridItems[item.vo.y + dis][item.vo.x] = item;
				item.vo.y += dis;
			}
			search()
		///	trace(this)
		}
		
		private function search():void 
		{
			for (var i:int = _mapArr.length-1; i >=0; i--) 
			{
				for (var j:int = 0; j<_mapArr[i].length ; j++) 
				{
					
				}
			}
		}
		public function toString():String
		{
			var res:String = "";
			for (var i:int = 0; i <_mapArr.length; i++) 
			{
				
				for (var j:int = 0; j < _mapArr[i].length; j++) 
				{
					if (!_gridItems[i][j]) 
					{
						res+="|-1"
					}else 
					{
						res += "|"+(_gridItems[i][j].vo.type) ;
					}
					
				}
				res += "\n";
			}
			return res;
		}
		
		public function createTopRowItems():void
		{
			
		}
		public function createBottomRowItems():void
		{
			if (_downIng) {
				
				
				return;
			}
			
			var old:Array = createNewRowItems();
			//trace("old: " + old);
			
			for (var i:int = _gridItems.length-1; i >=0; i--) 
			{ 
				var p:*= _gridItems[i];
				if (i != (_gridItems.length - 1))
				{
					for each (var item:BlockViewer in old) 
					{
						if (item)
						{
							item.vo.y -= 1;
							if (item.vo.y < 0)
							{
								removeTop(item)
							}
							
							item.updateTest();
						}
					}

				}
				if (i == 0)
				{
					for each (var item2:BlockViewer in p) 
					{
						
						if(item2)removeTop(item2)
							
					}
				}
				_gridItems[i] = old;
				old = p;
			}
			//trace(this);
		
			//upRowItems()
		}
		
		protected function removeTop(item:BlockViewer):void 
		{
			_main.removeChild(item);
		}
		
		public function upRowItems():void 
		{
			_uping = true;
			for (var i:int = _gridItems.length-1; i >=0; i--) 
			{ 
				for (var j:int = 0; j < _gridItems[i].length; j++) 
				{
					var item:BlockViewer = _gridItems[i][j];
					if (item)
					{
						//item.y -= 50;
						TweenLite.to(item, 0.3, { y:item.vo.y*50, ease:Back.easeOut,overwrite:0 } );
					}
				}
			}
			//_main.y -= _gridHeight;
			
			
			setTimeout(function():void { _uping = false; }, 400);
			setTimeout(checkHaveSame, 500);
		}
		
		protected function createNewRowItems():Array 
		{
			_rowNum++;
			var res:Array = [];
			for (var j:int = 0; j < _mapArr[0].length; j++) 
			{
				var blockVo:BlockVO = new BlockVO();
				blockVo.type =int(Math.random()*15+1)
				blockVo.x = j;
				blockVo.y = (_mapArr.length - 1);;
				//trace("_mapArr.length: " + _mapArr.length);
				
				
				var item:BlockViewer = new ItemPUZClass();
				res.push(item);
				
				_main.addChild(item);
				item.blockWidth = _gridWidth;
				item.blockHeight = _gridHeight;
				item.vo = blockVo;
				item.x = _gridWidth * j;
				item.y = _gridHeight * (_mapArr.length);
				item.updateTest()
				
			}
			return res;
		}
		protected function createItemAfter(item:BlockViewer):void 
		{
			
		}
		
		/**
		 * 检查是否要创建方块
		 * @param	j
		 * @param	i
		 * @param	mdata
		 */
		protected function checkNeedCrateItem(j:int, i:int, mdata:*):Boolean 
		{
			return mdata!=-1;
		}
		
		protected function createItemBefore(j:int, i:int, mdata:*):void 
		{
			
		}
		public function addBlock(point:Point, type:int):void
		{
			var x:int = point.x / _gridWidth;
			var y:int = point.y / _gridHeight;
			var blockVo:BlockVO = new BlockVO();
			blockVo.type =type
			blockVo.x = x;
			blockVo.y =y;
			
			var item:BlockViewer = new ItemPUZClass();
			
			
			_main.addChild(item);
			item.blockWidth = _gridWidth;
			item.blockHeight = _gridHeight;
			item.vo = blockVo;
			item.x = _gridWidth * x;
			item.y = _gridHeight * (y);
			item.updateTest()
			
			_gridItems[y][x] = item;
			
			
			//checkHaveSame();
			down()
		}
		public function getRowMax(x:int):int
		{
			for (var i:int = _gridItems.length-1; i >=0; i--) 
			{
				var item: BlockViewer = _gridItems[i][x];
				if (!item)
				{
					return i;
				}
				
			}
			return -1;
		}
		
		
		
		
		public function get gridItems():Array 
		{
			return _gridItems;
		}
		
		public function get gridWidth():Number 
		{
			return _gridWidth;
		}
		
		public function get gridHeight():Number 
		{
			return _gridHeight;
		}
		
		public function set downIng(value:Boolean):void 
		{
			_downIng = value;
		}
		
		public function get lastSpecialType():int 
		{
			return _lastSpecialType;
		}
		
		public function set lastSpecialType(value:int):void 
		{
			_lastSpecialType = value;
		}
		
		public function get uping():Boolean 
		{
			return _uping;
		}
		
		public function get pause():Boolean 
		{
			return _pause;
		}
		
		public function set pause(value:Boolean):void 
		{
			_pause = value;
		}
		
		public function get deleteTotalNum():int 
		{
			return _deleteTotalNum;
		}
		
	}

}