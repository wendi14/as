package com.xmaser.display.container.list 
{
	/**
	 * ...
	 * @author 小火柴
	 */
	public class List extends ListBasic 
	{
		
		public function List() 
		{
			
		}
		
		override protected function drawBg():void 
		{
			super.drawBg();
			_bgMc.alpha = 0;
			_bgMc.width = 200;
			_bgMc.height = 300;
		}
		override public function get width():Number 
		{
			return super.width;
		}
		
		override public function set width(value:Number):void 
		{
			//super.width = value;
			_bgMc.width = value;
			drawMask();
		}
		override public function get height():Number 
		{
			return super.height;
		}
		
		override public function set height(value:Number):void 
		{

			_bgMc.height = value;
			drawMask();
		}
		
	}

}