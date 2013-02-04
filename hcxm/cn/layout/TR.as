package hcxm.cn.layout {
	import flash.display.Sprite
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class TR extends Base {
		
		public function TR(mc) {
			super(mc);
		}
		override public function layout(mc:Sprite) {
			//mc.width = mc.stage.stageWidth;
			mc.x = mc.stage.stageWidth - mc.width;
			//mc.y = mc.stage.stageHeight - mc.height;
		}
		
	}
	
}
