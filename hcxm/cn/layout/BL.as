package hcxm.cn.layout {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	/**
	 * 对齐底部
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class BL extends Base {

		public function BL(mc)  {
			super(mc)
		}
		override public function layout(mc:Sprite) {
			mc.width = mc.stage.stageWidth;
			mc.x = 0;
			mc.y = mc.stage.stageHeight - mc.height;
		}
		
	}
	
}
