package com.xmaser.game.frame 
{
	import com.xmaser.view.ViewBasic;
	
	/**
	 * ...
	 * @author 
	 */
	public class HCLogo extends ViewBasic 
	{
		
		public function HCLogo() 
		{
			super(hcstudio);
		}
		override protected function init():void 
		{
			super.init();
			mc.x = stage.stageWidth / 2;
			mc.y = stage.stageHeight / 2 + 50;
			
			this.graphics.beginFill(0);
			this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			this.graphics.endFill();
		}
		
	}

}