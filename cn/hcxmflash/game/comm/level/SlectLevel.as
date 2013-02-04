package  cn.hcxmflash.game.comm.level 
{
	import cn.hcxmflash.component.LabelComponent;
	import cn.hcxmflash.container.HcxmSprite;
	import cn.hcxmflash.game.comm.component.Viewer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.SharedObject;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class SlectLevel extends Viewer
	{
		[Event(name="select", type="flash.events.Event")] 

		
		private var _levelArr:Array=[];
		protected var _holdSprite:Sprite
		public static var SELECT:String = "select";
		public var selectedLevel
		private var _shareObject:SharedObject;
		private var _itemUI:*;
		private var sp:Sprite;
		public function SlectLevel(shareObjectName:String,totalLevel:int,ItemUI:*) 
		{
			super(null);
			_shareObject = SharedObject.getLocal(shareObjectName);
			
			_itemUI = ItemUI;
			var da:Array;
			var it:Object 
				trace("_shareObject.data.level: " + _shareObject.data.level);
			if (!_shareObject.data.level) 
			{
				
				_shareObject.data.level = []

				da=[]
				for (var i:int = 1; i <= totalLevel; i++) 
				{
					it= new Object()
					it.levell = i;
					it.lock = true;
					if (i == 1) it.lock = false;
					da[i]=(it)
				}
				_shareObject.data.level = da;;
			}else
			{
				 if (totalLevel != _shareObject.data.level.length-1)
				 {
					
					 
					 da=[]
					 for (var j:int = 1; j <= totalLevel; j++) 
					{
						it = _shareObject.data.level[j];
						if (it)
						{
							
						}else 
						{
							it = new Object()
							it.levell = j;
							it.lock = true;
						}
						da[j]=(it)
					}
					 _shareObject.data.level = da;;
					
				 }
			}
			
		}
		override protected function init():void 
		{
			_holdSprite = new Sprite()
			addChild(_holdSprite)
			this.graphics.clear();
			this.graphics.beginFill(0)
			this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight)
			this.graphics.endFill()
			create()
			
			//var la:LabelComponent = new LabelComponent("Level will continue to increase,to be my fans, you will receive this game's update msg.", "_sans", 12, 0xffffff);
			//la.y = stage.stageHeight - la.height;
			//addChild(la);
		}
		 public function create():void 
		{
			
			getSaveData();
			sp = new Sprite()
			_holdSprite.addChild(sp)
			//_holdSprite.addEventListener(MouseEvent.CLICK, __CLICK);
			var col=0
			var row=0
			for (var i:int = 1; i <_levelArr.length; i++) 
			{
				var ite:LevelItem = drawItem(i);
				
				sp.addChild(ite);
				ite.addEventListener(MouseEvent.CLICK, __CLICK);
								ite.level = i
			ite.x = (ite.width + 10) * row;
				ite.y = (ite.height + 10) * col;
				ite.name = "item" +ite.level;
				resPositionItemXY(ite,i)
				ite.lock = _levelArr[i].lock;
				
				ite.level = i 
				ite.update()
				row++
				if (row >= 10)
				{
					col++;
					row=0
				}
				
			}
			

			_holdSprite.x = this.width / 2 - _holdSprite.width  / 2;
			_holdSprite.y = this.height / 2 - _holdSprite.height / 2;
			
			
		}
		
		protected function resPositionItemXY(ite:LevelItem,i:int):void 
		{
			
		}
		protected function drawItem(i:int):LevelItem
		{
			var ite:LevelItem = new LevelItem(_itemUI);

				
				
				return ite;
		}
		public function update(levelNum:int):void
		{
			trace("levelNum: " + levelNum);
			
			trace("_shareObject.data.level[levelNum]: " + _shareObject.data.level[levelNum]);
			_shareObject.data.level[levelNum].lock = false;
			
			_shareObject.flush();
			
			var ite:LevelItem = getLevelItem(levelNum);
			if (ite)
			{
				ite.lock = false;
				ite.update();
			}
		}
		public function getLevelItem(lev:int):LevelItem
		{
			var item:LevelItem = sp.getChildByName("item" + lev) as LevelItem;
			return item;
		}
		
		private function __CLICK(e:MouseEvent):void 
		{
			
			
			if (e.currentTarget is LevelItem)
			{
				selectedLevel = LevelItem(e.currentTarget).level;
				trace("selectedLevel: " + selectedLevel);
				
				dispatchEvent(new Event(SELECT));
				//destory()
			}
			
			
		}
		
		override public function destory():void 
		{
			super.destory();
			_holdSprite.removeEventListener(MouseEvent.CLICK, __CLICK);
			_holdSprite.removeChildAt(0);
		}
		
		private function getSaveData():void
		{
			
			for (var i:int = 0; i < _shareObject.data.level.length; i++) 
			{
				var it = _shareObject.data.level[i];
				
				
				_levelArr.push(it)
			
			}
			//_levelArr = s.read("tank");
			
		}
		public static function clear(shareObjectName):void
		{
			var _shareObject:SharedObject = SharedObject.getLocal(shareObjectName);
			_shareObject.clear();
		}
		private function closeMainMenu():void
		{
			
		}
		
		private function showHelp():void
		{
			
		}
		
		private function showHightScore():void
		{
			
		}
		
		private function __disposeMainMenu(e:Event):void 
		{
			
		}
	}

}