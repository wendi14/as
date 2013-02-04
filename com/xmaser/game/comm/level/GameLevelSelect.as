package  com.xmaser.game.comm.level 
{

	import cn.hcxmflash.game.sound.GSound;
	import com.xmaser.game.frame.GameViewer;
	import com.xmaser.view.ViewBasic;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.SharedObject;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class GameLevelSelect extends ViewBasic
	{
		[Event(name="select", type="flash.events.Event")] 

		
		private var _levelArr:Array=[];
		protected var _holdSprite:Sprite
		public static var SELECT:String = "select";
		public var selectedLevel:int
		public var game:GameViewer;
		
		private var _shareObject:SharedObject;
		private var _itemUI:*;
		private var sp:Sprite;
		private var _levelData:Array;
		private var _row:int;
		public function GameLevelSelect(uicla:Class,levelData:Array,ItemUI:*,row:int=10) 
		{
			super(uicla);
			_row = row;
			_levelData = levelData;
			
			_itemUI = ItemUI;
		/*	var _da:Array = [];
			var it:LevelVO 
			
			for (var i:int = 1; i <= levelData.length; i++) 
			{
				it= new LevelVO
				it.level = levelData[i].level;
				it.lock = levelData[i].lock;
			}*/
			
		}
		
		override protected function init():void 
		{
			_holdSprite = new Sprite()
			addChild(_holdSprite)
			this.graphics.clear();
			this.graphics.beginFill(0,0)
			this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight)
			this.graphics.endFill()
			create()
			
			//var la:LabelComponent = new LabelComponent("Level will continue to increase,to be my fans, you will receive this game's update msg.", "_sans", 12, 0xffffff);
			//la.y = stage.stageHeight - la.height;
			//addChild(la);
		}
		 private function create():void 
		{
			
			
			sp = new Sprite()
			_holdSprite.addChild(sp)
			//_holdSprite.addEventListener(MouseEvent.CLICK, __CLICK);
			var col:int=0
			var row:int=0
			for (var i:int = 0; i <_levelData.length; i++) 
			{
				var ite:LevelItemBasic = drawItem(i);
				ite.addEventListener(MouseEvent.ROLL_OVER, __iteROLL_OVER);
				sp.addChild(ite);
				ite.addEventListener(MouseEvent.CLICK, __CLICK);
				ite.level = _levelData[i].level;
								
				ite.x = (ite.width + 10) * row;
				//trace( "ite.x : " + ite.x );
				ite.y = (ite.height + 10) * col;
				//trace( "ite.y : " + ite.y );
				ite.name = "item" +ite.level;
				
				ite.lock = _levelData[i].lock;
				resPositionItemXY(ite,i)
				
				ite.update()
				row++
				if (row >=this.row)
				{
					col++;
					row=0
				}	
			}
			
			
			
			
			onCreateAfter();
		}
		
		protected function onCreateAfter():void 
		{
			_holdSprite.x = stage.stageWidth / 2 - _holdSprite.width  / 2;
			_holdSprite.y = stage.stageHeight / 2 - _holdSprite.height / 2;//	 +42;
		}
		
		private function __iteROLL_OVER(e:MouseEvent):void 
		{
			
		}
		
		protected function resPositionItemXY(ite:LevelItemBasic,i:int):void 
		{
			
		}
		protected function drawItem(i:int):LevelItemBasic
		{
			var ite:LevelItemBasic = new _itemUI();

				
				
				return ite;
		}
		public function update(levelNum:int):void
		{
			_shareObject.data.level[levelNum].lock = false;
			_shareObject.flush();
			
			var ite:LevelItemBasic = getLevelItem(levelNum);
			if (ite)
			{
				ite.lock = false;
				ite.update();
			}
		}
		public function getLevelItem(lev:int):LevelItemBasic
		{
			var item:LevelItemBasic = sp.getChildByName("item" + lev) as LevelItemBasic;
			return item;
		}
		
		private function __CLICK(e:MouseEvent):void 
		{
			
			
			if (e.currentTarget is LevelItemBasic)
			{
				selectedLevel = LevelItemBasic(e.currentTarget).level;
				dispatchEvent(new Event(SELECT));
				//destory()
			}
			
			
		}
		
		override public function destroy():void 
		{
			super.destroy();
			_holdSprite.removeEventListener(MouseEvent.CLICK, __CLICK);
			_holdSprite.removeChildAt(0);
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
		
		public function get row():int 
		{
			return _row;
		}
	}

}