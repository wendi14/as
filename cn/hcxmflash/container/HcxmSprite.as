package cn.hcxmflash.container 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class HcxmSprite extends Sprite
	{
		private var _selected:Boolean=false;
		
		public function HcxmSprite() 
		{
			if (stage) 
			{
				init()
			}else
			{
				addEventListener(Event.ADDED_TO_STAGE, __ADDED_TO_STAGE);
			}
		}
		
		private function __ADDED_TO_STAGE(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, __ADDED_TO_STAGE);
			init()
		}
		
		protected function init():void
		{
			
		}
		public function set selected(value:Boolean):void 
		{
			_selected = value;
		}
		public function get selected():Boolean { return _selected; }
	}

}