package hcxm.cn.controls {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	import hcxm.cn.mouse.PressRelease;
	import hcxm.cn.MyLoader;
	
	/**
	* ...
	* @编写者： wendi(小火柴)
						http://www.hcxm.cn
	*/
	public class  Head extends MovieClip{
		namespace wendi
		wendi var bg:Btn
		private var _ww
		private var _hh
		private var _title
	
		var tt:TextField
		var textf:TextFormat
		private var dragWho:Sprite;
		
		//-----按纽
		
		private var closeB:Btn
		private var minB:Btn;
		private var maxB:Btn;
		public var newWidth;
		public var newHeight;
		
		//-----------
		public function Head() {
			textf = new TextFormat();
			tt = new TextField();
		}
		
		public function dragIt(mc:Sprite) {
		
			//
			dragWho = mc;
			var press:PressRelease = new PressRelease(bg);
			press.addEventListener(MouseEvent.MOUSE_DOWN, MOUSE_DOWN);//按下拖
			press.addEventListener(MouseEvent.MOUSE_UP, MOUSE_UP);//
		}
	
		public function Stopdrag(mc:Sprite) {
			//mc.startDrag(false)
		}
		
		private function MOUSE_DOWN(e:MouseEvent):void {
			dragWho.startDrag(false)
			//for each( var i:String in this ) trace( "key : " + i + ", value : " + this[ i ] );
		}
		private function MOUSE_UP(e:MouseEvent):void {
			dragWho.stopDrag();
			//checkPosition(dragWho)
		}
		private function checkPosition(mm:Sprite) {
			if (mm.x<0) {
				mm.x=0
			}else if(mm.x+mm.width>stage.stageWidth) {
				mm.x = stage.stageWidth - mm.width;
			}
			if (mm.y<0) {
				mm.y = 0;
			}else if (mm.y+mm.height>stage.stageHeight) {
				mm.y = stage.stageHeight - mm.height;
			}
		}
		private function showTopBtn():void {
			_ww = newWidth;

			_hh = newHeight;
			minB = new minButton();
			maxB = new maxButton();
			closeB = new closeButton();
			
			addChild(minB);
			addChild(maxB);
			addChild(closeB);
			
			var ww = closeB.width;
			var hh = minB.height;
			
			closeB.x = _ww - ww - 2;
			closeB.y = _hh/2-hh/2;
			maxB.x = closeB.x - 2 - ww;
			maxB.y = _hh/2-hh/2;
			minB.x = maxB.x - 2 - ww;
			minB.y = _hh/2-hh/2;
			minB.name = "minButton"
			maxB.name = "maxButton"
			closeB.name="closeButton"
			
		}
		
		
		/**
		 * 最小化
		 * @param	e
		 */
		private function btnClickMin(e):void {
			//trace( "e : " + e );
			
			//dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		}
		/**
		 * 还原
		 */
		private function btnClickMax(e):void {
			
		}
		/**
		 * 关闭
		 * @param	e
		 */
		private function btnClickClo(e):void {
			
		}
		
		public function set titleX(value):void {
			tt.x=value
		}
		public function set title(value:String):void {
		
			tt.autoSize = TextFieldAutoSize.LEFT;
			tt.selectable = false;
			_title = value;
			tt.htmlText = value;
			addChild(tt)
			tt.x = 2;
			tt.y = bg.height/2-tt.height/2;
			tt.setTextFormat(textf);
		}
		public function get title() { return _title; }
		
		/**
		 * 是否显示左上边的按纽
		 */
		public function set showBtn(value):void {
			if (value) {
				showTopBtn()
			}
		}
		/**
		 * 标题的颜色
		 */
		public function set titleColor(value):void {
			textf.color = value;
			tt.setTextFormat(textf)
		}
		/**
		 * 标题为粗体
		 */
		public function set titleBold(value):void {
			textf.bold = true;
			tt.setTextFormat(textf)
		}
		
	}
	
}
