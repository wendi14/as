package hcxm.cn.mouse {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	/**
	* ...
	* @编写者： wendi(小火柴)
						http://www.hcxm.cn
	*－－－
	* 功能：
	* －－－－
	* 让影片具有按住不放和放开的功能，像as2的press  和 reaselease
	*/
						
	public class PressRelease extends EventDispatcher {
		private var draging = false;
		private var mc
		public function PressRelease(mc:Sprite) {
			mc.addEventListener(MouseEvent.MOUSE_DOWN, MOUSE_DOWN)
			mc.addEventListener(MouseEvent.MOUSE_UP, MOUSE_UP);
			this.mc = mc;
			
		}
		
		private function MOUSE_LEAVE(e:Event):void {
			if (draging) {
				draging = false;
				dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP, true, true));				
			}
			

			
			
		}
		private function MOUSE_DOWN(e:MouseEvent):void {
			draging = true;
			e.target.stage.addEventListener(Event.MOUSE_LEAVE, MOUSE_LEAVE)
			dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN, true, true));	
			mc.stage.addEventListener(MouseEvent.MOUSE_UP,MOUSE_UP2)
		}
		private function MOUSE_UP(e:MouseEvent):void {
			draging = false;
			dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP, true, true));
		}		
		private function MOUSE_UP2(e:MouseEvent):void {
			if (draging) {
				draging = false;
				dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP, true, true));				
			}

		}	
	}
	
}