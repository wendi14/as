package  cn.hcxmflash.game.comm.level 
{
	import cn.hcxmflash.component.LabelComponent;
	import cn.hcxmflash.container.HcxmSprite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.SharedObject;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class SlectLevel_ extends  HcxmSprite
	{
		[Event(name="select", type="flash.events.Event")] 

		
		private var _levelArr:Array=[];
		private var _holdSprite:Sprite
		public static var SELECT:String = "select";
		public var selectedLevel
		private var _shareObject;
		private var _itemUI:*;
		public function SlectLevel_(s:SharedObject,totalLevel:int,ItemUI:*) 
		{
			_shareObject = s;
			_itemUI = ItemUI;
			var da:Array;
			var it:Object 
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
					da.push(it)
				}
				_shareObject.data.level = da;;
			}else
			{
				 if (totalLevel != _shareObject.data.level.length)
				 {
					 trace( "totalLevel : " + totalLevel );
					 
					 da=[]
					 for (var j:int = 1; j <= totalLevel; j++) 
					{
						it = _shareObject.data.level[j-1];
						if (it)
						{
							
						}else 
						{
							it = new Object()
							it.levell = j;
							it.lock = true;
						}
						da.push(it)
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
			var sp:Sprite = new Sprite()
			_holdSprite.addChild(sp)
			var col=0
			var row=0
			for (var i:int = 0; i < _levelArr.length; i++) 
			{
				var ite:LevelItem = new LevelItem(_itemUI);
				ite.level = i + 1;
				sp.addChild(ite);
				ite.addEventListener(MouseEvent.CLICK,__CLICK)
				ite.x = (ite.width + 10) * row;
				ite.y = (ite.height + 10) * col;
				
				ite.lock = _levelArr[i].lock;
				
				ite.level = i + 1;
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
		
		private function __CLICK(e:MouseEvent):void 
		{
			selectedLevel= LevelItem(e.currentTarget).level
			dispatchEvent(new Event(SELECT))
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