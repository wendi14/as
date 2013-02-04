package hcxm.cn.tooltip {
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.display.Sprite;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.utils.Timer;

	/**
	 * 提示文本
	 * @author Flying http://www.riafan.com
	 */
	public class AS3ToolTip{
		private static var toolTip : TextField;
		private static var format : TextFormat;
		private static var owner :DisplayObjectContainer;
		//tooltip对象是否可用
		public static var enabled : Boolean = true;
		//目标对象数组
		private static var owners : Array = new  Array();
		//文本对象数组
		private static var texts : Array = new Array();
		
		public function AS3ToolTip() {
			
		}
		
		/**
		 * 获取/设置提示文本的顶级显示对象
		 */
		public static function get root() :DisplayObjectContainer{
			return owner;
		}

		public static function set root(value :DisplayObjectContainer) : void {
			if (owner == null){
				owner = value;
				timer = new Timer(100);
				
				timer.addEventListener(TimerEvent.TIMER,_timerFunc)
			}
		}
		
		static private function _timerFunc(e:TimerEvent):void 
		{
			
			toolTip.x = pa.mouseX + 4;	
			toolTip.y = pa.mouseY - 24;
		}
		
		/**
		 * 新建一个提示文本
		 *
		 * @param   owner  要设置提示文本的目标对象
		 * @param   text  提示文本的内容
		 */
		 
		public static function create(owner:InteractiveObject, text: String,isNoMouseOver:Boolean=true,Even="") : void {
		 	owners.push(owner);		
			texts.push(text);
			if (isNoMouseOver)
			{
				owner.addEventListener(MouseEvent.MOUSE_OVER, AS3ToolTip.showToolTip);
				owner.addEventListener(MouseEvent.MOUSE_OUT, AS3ToolTip.hideToolTip);
			}else {
				owner.addEventListener(Even, AS3ToolTip.showToolTip);
				owner.addEventListener(Even, AS3ToolTip.hideToolTip);
			}

			
		}
		/**
		 * 显示提示文本
		 */
		public static var timer:Timer 
		public static var pa
		public static function showToolTipManul( p,e ) : void {
			//初始化动态文本
			AS3ToolTip.pa = p;
			toolTip = new TextField();
			toolTip.visible = true;
			toolTip.text = e;
			toolTip.background = true;
			toolTip.backgroundColor=  0xe70000;;
			toolTip.border = true;
			toolTip.borderColor = 0x000000;
			toolTip.multiline = false;
			toolTip.wordWrap = false;
			toolTip.autoSize = TextFieldAutoSize.CENTER;
			//timer.start();
			toolTip.x = pa.mouseX + 4;	
			toolTip.y = pa.mouseY - 24;
			//设置动态文本样式
			format = new TextFormat();
			format.font = "_sans";
			format.leftMargin = 4;
			format.rightMargin = 4;
			format.size = 12;
			format.color=0xffffff
			toolTip.setTextFormat(format);
			pa.addChild(toolTip);
			timer.start()
		}		
		public static function hideToolTipManul() : void {
			toolTip.visible = false; 
			timer.stop()
		}
		public static function showToolTip(e ) : void {
			//初始化动态文本
			toolTip = new TextField();
			toolTip.visible = true;
			toolTip.text = findText(InteractiveObject(e.currentTarget));
			toolTip.background = true;
			toolTip.backgroundColor= 0xFFCC66;
			toolTip.border = true;
			toolTip.borderColor = 0x000000;
			toolTip.multiline = false;
			toolTip.wordWrap = false;
			toolTip.autoSize = TextFieldAutoSize.CENTER;
			toolTip.x = owner.mouseX + 16;	
			toolTip.y = owner.mouseY - 24;
			
			//设置动态文本样式
			format = new TextFormat();
			format.font = "_sans";
			format.leftMargin = 4;
			format.rightMargin = 4;
			format.size = 12;
			toolTip.setTextFormat(format);
			owner.addChild(toolTip);
			
		}		
		/**
		 * 隐藏提示文本
		 */

		private static function hideToolTip(e : MouseEvent) : void {
			toolTip.visible = false;  
			owner.removeEventListener(MouseEvent.MOUSE_OVER, showToolTip);
			owner.removeEventListener(MouseEvent.MOUSE_OUT, hideToolTip);  
		}
		
		/**
		 * 返回特定文本
		 * 
		 * @param   target  目标对象
		*/
		
		private static function findText(owner:InteractiveObject) : String {
			var index : int = owners.indexOf(owner);
			return texts[index];
		}
	}
}