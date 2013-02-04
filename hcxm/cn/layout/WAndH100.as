package hcxm.cn.layout {
	import flash.display.Sprite;
	
	/**
	* ...
	* @author 小火柴(http://www.hcxm.cn)
	*/
	public class WAndH100 extends Base {
		
		public function WAndH100(mc) {
			super(mc)
		}
		override public function layout(mc:Sprite) {
			mc.width = mc.stage.stageWidth
			mc.height = mc.stage.stageHeight;
		}
		
		
	}
	
}