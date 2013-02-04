package hcxm.cn.controls {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	
	/**
	* ...
	* @编写者： wendi(小火柴)
						http://www.hcxm.cn
	*内部分为三帧
	* 第一帧为	正常状态＝鼠标离开
	* 第二帧为	鼠标经过状态
	* 第三帧为	鼠标按下状态
	*/
	public class Btn extends MovieClip{
	
		public function Btn() {
			this.addEventListener(MouseEvent.MOUSE_OVER, MOUSE_OVER)
			this.addEventListener(MouseEvent.MOUSE_OUT, MOUSE_OUT)
			this.addEventListener(MouseEvent.MOUSE_DOWN, MOUSE_DOWN)
			this.addEventListener(MouseEvent.MOUSE_UP, MOUSE_UP);
			//this.addEventListener(MouseEvent.CLICK, CLICK);
		}
		
		private function CLICK(e:MouseEvent):void {
			//dispatchEvent(new MouseEvent_(MouseEvent_.CLICK,null,true))
			//dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		}
		
		private function MOUSE_UP(e:MouseEvent):void {
			this.gotoAndStop(1);
		}
		
		private function MOUSE_DOWN(e:MouseEvent):void {
			this.gotoAndStop(3)
		}
		
		private function MOUSE_OUT(e:MouseEvent):void {
			this.gotoAndStop(1)
		}
		
		private function MOUSE_OVER(e:MouseEvent):void {
			this.gotoAndStop(2)
			
		}
		
		
	}
	
}
