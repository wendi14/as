package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import hcxm.cn.event.MouseEvent_;
	import hcxm.cn.system.Mouse_Right_Menu;
	import org.osflash.thunderbolt.Logger;
	import flash.display.MovieClip
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class Test extends Sprite {
		
		public function Test() {
			var m:Mouse_Right_Menu = new Mouse_Right_Menu(this);
			m.addItem("a");
			m.addItem("b");
			var m2:Mouse_Right_Menu = new Mouse_Right_Menu(b);
			m2.addItem("c");
			m2.addItem("d");
			m.addEventListener(MouseEvent_.CLICK, click)
			m2.addEventListener(MouseEvent_.CLICK, click);
			
			b.addEventListener(MouseEvent.CLICK,cli)
		}
		
		private function cli(e:MouseEvent):void {
			trace(e.target)
			trace(e.currentTarget)
		}
		
		private function click(e:MouseEvent_):void {
			trace( "e : " + e.data );
			//Logger.console=false
			Logger.debug("e:" + e.data);
			

		}
		
		
	}
	
}
