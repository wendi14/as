package com.xmaser.display.component 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class ComponentBasic extends Sprite 
	{
		
		public function ComponentBasic() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init1);
			drawUI()
		}
		
		private function init1(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			init()
		}
		
		protected function init():void 
		{
			
		}
		protected function drawUI():void
		{
			
		}
		public function destory():void
		{
			
		}

		
	}

}