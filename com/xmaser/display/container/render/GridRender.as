package com.xmaser.display.container.render 
{
	import assets.itemRender;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class GridRender extends ItemRender
	{
		
		public function GridRender() 
		{
			
		}
		override protected function draw():void 
		{
			this.graphics.lineStyle(0.1, 0,0);
			this.graphics.beginFill(0, 0);
			this.graphics.drawRect(0, 0, data.width, data.height);
			this.graphics.endFill()
		}
	}

}