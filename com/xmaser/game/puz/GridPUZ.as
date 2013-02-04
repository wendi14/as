package com.xmaser.game.puz 
{
	import com.xmaser.game.puz.GridItemPUZ;
	import com.xmaser.view.ViewBasic;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class GridPUZ extends ViewBasic 
	{
		private var _dirArr:Array=[[1,0],[0,1],[-1,0],[0,-1]];
		protected var _gridArr:Array;
		protected var _gridWidth:Number = 70;
		protected var _gridHeight:Number=70;
		protected var _mapArr:Array;
		protected var _gridItems:Array;
		protected var GridItemPUZClass:Class=GridItemPUZ;
		public function GridPUZ(ca:Class) 
		{
			super(ca);
		}
		override protected function drawUI():void 
		{
			super.drawUI();
			
			
		}
		
		public function createGrid(mapArr:Array):void 
		{
			_mapArr = mapArr;
			
			_gridArr = [];
			_gridItems = [];
			for (var i:int = 0; i <_mapArr.length; i++) 
			{
				_gridItems[i] = [];
				for (var j:int = 0; j < _mapArr[i].length; j++) 
				{
					if (!checkNeedCrateItem(j,i,_mapArr[i][j])) continue;
					createItemBefore(j,i,_mapArr[i][j])
					var item:GridItemPUZ = new GridItemPUZClass();
					item.addEventListener(MouseEvent.MOUSE_DOWN, __gridItemMOUSE_DOWN);
					item.addEventListener(MouseEvent.MOUSE_UP, __gridItemMOUSE_UP);
					item.xx = j;
					item.yy = i;
					item.type = _mapArr[i][j];
					item.ww = _gridWidth;
					item.hh = _gridHeight;
					
					addChild(item);
					item.x = _gridWidth * j;
					item.y = _gridHeight * i;
					_gridItems[i][j] = item
					
					createItemAfter(item)
				}
				
			}
		}
		/**
		 * 检查是否要创建方块
		 * @param	j
		 * @param	i
		 * @param	mdata
		 */
		protected function checkNeedCrateItem(j:int, i:int, mdata:*):Boolean 
		{
			return true;
		}
		
		protected function createItemBefore(j:int, i:int, mdata:*):void 
		{
			
		}
		
		protected function createItemAfter(item:GridItemPUZ):void 
		{
			item.saveOld();
		}
		
		protected function __gridItemMOUSE_DOWN(e:MouseEvent):void 
		{
			
		}
		
		protected function __gridItemMOUSE_UP(e:MouseEvent):void 
		{
			
		}
		protected function search(ar:Array):Array		
		{
			//trace("search: " + ar);
			
			
			
			var sarr:Array = ar.concat();
			var res:Array = []
			
			
			for (var i:int = 0; i < sarr.length; i++) 
			{
				var res1:Array = searchSingleItem(sarr[i]);
				//trace("res1: "+sarr[i]+"___" + res1);
				if (res1.length >= 3)
				{
					res = res.concat(res1);
				}else
				{
					for each (var item:GridItemPUZ in res1) 
					{
						//item.searched = false;
					}
				}
				
			}
			resetAllSearched();
			return res;
		}
		protected function searchSingleItem(item:GridItemPUZ):Array		
		{
		
			
			var sarr:Array = [item]
			var res:Array = [item];
			
			
			while (sarr.length > 0)
			{
				sarr[0].searched = true;
				for each (var dir:Array in _dirArr) 
				{
					if (_gridItems[sarr[0].yy + dir[1]])
					{
					
						var item2:GridItemPUZ = _gridItems[sarr[0].yy + dir[1]][sarr[0].xx + dir[0]];
						//trace("s    item2: " + item2,sarr[0].yy + dir[1],sarr[0].xx + dir[0]);
						
						if (item2&&item2.searched==false&&item2.type==sarr[0].type)
						{
							item2.searched = true;
							sarr.push(item2);
							res.push(item2);
							
						}
					}
					
				}
				
				sarr.shift()
			}
			return res;
		}
		private function searchFromDir(arr:Array,needSameNum:int = 3,dir:Array=null):Array
		{
			var res:Array = [];
			var resObj:Object={}	
			for each (var item:GridItemPUZ in arr) 
			{
				//trace("item:-------- " + item);
				var tempobj:Object = { };
				
				
				var i:int = 0;
				var k:int = 1;
				
				//down
				var len:int = _gridItems[item.yy].length - item.xx;
				//trace("len: " + len);
				//left
				if (dir[0] == 0 && dir[1] == 1)
				{
					len = _gridItems.length - item.yy-1;
				}
				while (i<len)
				{
					var abc:*= _gridItems[item.yy + dir[1]][item.xx + dir[0] + i];
					if (dir[0] == 0 && dir[1] == 1)
					{
						abc= _gridItems[item.yy + dir[1]+i][item.xx + dir[0]];
					}
					if (abc)
					{
						var item2:GridItemPUZ = abc
						//trace("item2: " + item2);
						
						if (item2.type == item.type)
						{
							//trace("	item2: " + item2);
							tempobj[item2.yy + "_" + item2.xx] = item2;
							k++;
						}else
						{
							break;
						}
					}
					i++
				}
				
				if (k>= needSameNum)
				{
					tempobj[item.yy + "_" + item.xx] = item;
					for (var name:String in tempobj) 
					{
						resObj[name] = tempobj[name];
					}
				
				}
			
			}
			for each (var item3:* in resObj) 
					{
						res.push(item3);
					}
			return res;
		}
		
		protected function searchDown(arr:Array,needSameNum:int = 3):Array
		{
			
			return  searchFromDir(arr, needSameNum, [0, 1]);
		}
		protected function searchRight(arr:Array,needSameNum:int = 3):Array
		{
			return searchFromDir(arr,needSameNum,[1,0])
		}
		
		public function getUpItems(itemsArr:Array):Array
		{
			var res:Object = { };
			
			
			for each (var item2:GridItemPUZ in itemsArr) 
				{
					
					
					
						for (var j:int = 0; j < _gridItems.length; j++) 
						{
							var item:GridItemPUZ = _gridItems[j][item2.xx];
							//trace("item: " + item,item2);
							
							
							if (item!=null&&item.yy<item2.yy&&item2.xx==item.xx)
							{
								res[item.yy + "_" + item.xx] = item;
							}
						}
						
					
					
					
					
				}
				
				
				
			
			var resa:Array=[]
			for each (var item3:GridItemPUZ in res ) 
			{
				resa.push(item3);
			}
			return resa;;;;
		}
		
		/**
		 * 从指定的坐标中获取相对应的方块
		 * @param	xx
		 * @param	yy
		 * @return
		 */
		public function getItemFromXY(xx:Number, yy:Number):GridItemPUZ
		{
			//xx = 11
			//yy=11
			xx = Math.round(xx / _gridWidth);

			yy = Math.round(yy / _gridHeight);

			return _gridItems[yy][xx];
		}
		public function getXY(xx:Number, yy:Number):Point
		{
			xx = Math.round(xx / _gridWidth);

			yy = Math.round(yy / _gridHeight);

			return  new Point(xx, yy);
		}
		public function traceGridItemsData():void
		{
			for (var i:int = 0; i < _gridItems.length; i++) 
			{
				for (var j:int = 0; j < _gridItems[i].length; j++) 
				{
					var item:GridItemPUZ = _gridItems[i][j];
					trace(i+"_"+j+"___item: " + item);
					
					
				}
				
			}
		}
		public function resetAllSearched():void
		{
			for (var i:int = 0; i < _gridItems.length; i++) 
			{
				for (var j:int = 0; j < _gridItems[i].length; j++) 
				{
					var item:GridItemPUZ = _gridItems[i][j];
					if (item)
					{
						item.searched = false;
					}
					
					
				}
				
			}
		}
		/**
		 * 获取Ｘ轴相同的方块
		 * @param	xx
		 * @return
		 */
		public function getItemsFromX(xx:int):Array
		{
			var res:Array = [];
			for (var i:int = 0; i < _gridItems.length; i++) 
			{
				
				
				var item:GridItemPUZ = _gridItems[i][xx];
				trace( "item : " + item );
				if (item)
				{
					res.push(item);
				}
				
			}
			return res;
			
		}
		public function getItemsFromY(yy:int):Array
		{
			var res:Array = [];
			for (var i:int = 0; i < _gridItems[yy].length; i++) 
			{
				
				
				var item:GridItemPUZ = _gridItems[yy][i];
				if (item)
				{
					res.push(item);
				}
				
			}
			return res;
			
			
		}
		public function checkEmpty():Boolean
		{
			var res:Boolean = true;
				for (var i:int = 0; i < _gridItems.length; i++) 
			{
				for (var j:int = 0; j < _gridItems[i].length; j++) 
				{
					var item:GridItemPUZ = _gridItems[i][j];
					if (item)
					{
						res = false;
						
						return res;
					}
					
					
				}
				
			}
			return res;
		}
		public function addGridItem(item:GridItemPUZ):void
		{
			if (!_gridItems[item.yy])
			{
				_gridItems[item.yy]=[]
			}
			_gridItems[item.yy][item.xx] = item;
			
		}
		public function removeGridItem(item:GridItemPUZ):void
		{
			
			if(_gridItems[item.yy])_gridItems[item.yy][item.xx] = null;
			
		}
		
		
	}

}