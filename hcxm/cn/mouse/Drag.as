package hcxm.cn.mouse {
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	/**
	* ...
	* @author 小火柴(http://www.hcxm.cn)
	* 拖动影片，按住可以拖动影片，放开鼠标停止拖动
	* -用法：new Drag(mc);
	*/
	public class Drag extends EventDispatcher {
		private var _mc:Sprite;
		
		private static var _draging
		var pr:PressRelease
		public function Drag(mc:Sprite) {
			this._mc = mc;
			pr=new PressRelease(mc);
			pr.addEventListener(MouseEvent.MOUSE_DOWN, onStargDrag)
			pr.addEventListener(MouseEvent.MOUSE_UP,onStopDrag)
		}
		private function onStargDrag(e:MouseEvent):void {
			//按住
			_mc.startDrag(false)
			dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN,true))
		}		
		private function onStopDrag(e:MouseEvent):void {
			//放开
			_mc.stopDrag();
			dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP,true))
		}
		//不能拖了
		public function enabledDrag(boo:Boolean):void
		{
			//trace("能拖吗	"+_mc.name+"		"+boo)
			 if(!boo)
			{
				pr.removeEventListener(MouseEvent.MOUSE_DOWN, onStargDrag)
				pr.removeEventListener(MouseEvent.MOUSE_UP,onStopDrag);
				onStopDrag(null)
			}else
			{
				pr.addEventListener(MouseEvent.MOUSE_DOWN, onStargDrag)
				pr.addEventListener(MouseEvent.MOUSE_UP,onStopDrag)
			} 
		}
		public function get MC() { return this._mc; }
		
		/**
		 * 
		 * @param	mc	点住这个mc
		 * @param	dragingMc		被拖的
		 */
		 static var pr:PressRelease
		public static function dragIt(mc:Sprite, dragingMc:Sprite):void {
			pr = new PressRelease(mc);
			_draging=dragingMc
			pr.addEventListener(MouseEvent.MOUSE_DOWN, onStargDrag1)
			pr.addEventListener(MouseEvent.MOUSE_UP,onStopDrag1)			
		}
		
		static private function onStargDrag1(e:MouseEvent):void {
			_draging.startDrag(false)
		}
		
		static private function onStopDrag1(e:MouseEvent):void {
			_draging.stopDrag()
		}
		public static function dragItStop() {
			if(!pr)return;
			pr.removeEventListener(MouseEvent.MOUSE_DOWN, onStargDrag1)
			pr.removeEventListener(MouseEvent.MOUSE_UP,onStopDrag1)			
		}		
		
		
	}
	
}