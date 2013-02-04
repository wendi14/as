package hcxm.cn.layout {
		import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	/**
	* ...自动缩放的基类
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class Base {
		private var mc
		public function Base(mc) {

			var sta:Stage = mc.stage;
			sta.align = StageAlign.TOP_LEFT
			sta.scaleMode=StageScaleMode.NO_SCALE
			sta.addEventListener(Event.RESIZE, resize)
			this.mc = mc;
			layout(this.mc)
		}
		 private function resize(e:Event):void {
			layout(this.mc)
		}
		public function layout(mc:Sprite) {

		}
	}
	
}
