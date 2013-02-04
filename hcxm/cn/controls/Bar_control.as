
package hcxm.cn.controls{
	
	/**
	* ...拖条
	* @author wendi
	* @version 0.1
	* 使用方法
	* bar.addEventListener(Bar_control.change, change1);
		function change1(e) {
		trace(e.value)//值
		var la = int(e.value/100*255);
		//pic.blur(la, la, 1);
	}

	*/
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import hcxm.cn.event.Event_;
	import hcxm.cn.mouse.PressRelease;
	public class Bar_control extends MovieClip {
		//private var jindu:MovieClip;
		//private var btn:MovieClip;
		//private var di:MovieClip;
		private var _minx
		private var _maxx;
		private var _miny
		private var _maxy
		public var DIR = 0;//0为水平,1为垂直
		public static const change:String="change";//定义一个＂改变事件＂,
		public function Bar_control() {
			
			init()	
		}
		private function init() {
			_minx=0;
			_maxx=di.width-btn.width;
			_miny = 0;
			_maxy = di.height - btn.height;
			
			var pre:PressRelease = new PressRelease(btn);
			pre.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown1);
			pre.addEventListener(MouseEvent.MOUSE_UP, onMOUSE_UP)
			btn.addEventListener(MouseEvent.MOUSE_OVER, onMOUSE_OVER)
			btn.addEventListener(MouseEvent.MOUSE_OUT, onMOUSE_OUT)
			
		}
		
		private function onMOUSE_OUT(e:MouseEvent):void {
			btn.gotoAndStop(1);
		}
		
		private function onMOUSE_OVER(e:MouseEvent):void {
			btn.gotoAndStop(2)
		}
		/**
		 * 鼠标放开后，发送最新的数值
		 */
		private function onMOUSE_UP(e:MouseEvent):void {
			btn.gotoAndStop(1)
			btn.removeEventListener(Event.ENTER_FRAME, onENTER_FRAME);
			this.stopDrag();
			getReulst()			
		}
		
		private function getReulst():void {
			var per
			if (!DIR) {
				per=btn.x/_maxx*100;
				per=int(per)/100;
				jindu.scaleX=per;				
			}else {
				per=btn.y/_maxy*100;
				per=int(per)/100;
				jindu.scaleY=per;						
			}

			dispatchEvent(new Event_(change, per, true));				
		}
		private function onMouseDown1(e:MouseEvent):void {
			btn.gotoAndStop(3);

			if (!DIR) {//水平方向拖动
				btn.startDrag(false,new Rectangle(0,btn.y,_maxx-_minx,0));
			}else {//垂直方向拖动
				btn.startDrag(false,new Rectangle(btn.x,0,0,_maxy-_miny));
			}
			
			/**
			 * 在按住拖动的时候，不断的发送新数值
			 */
			btn.addEventListener(Event.ENTER_FRAME, onENTER_FRAME)
		}
		
		private function onENTER_FRAME(e:Event):void {
			getReulst();
		}		
	}
}