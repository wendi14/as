package com.xmaser.display.component.scroll 
{
	import com.xmaser.assets.asset_progressbarbg_ui;
	/**
	 * ...
	 * @author 
	 */
	public class ProgressHBar extends HScroll 
	{
		private var _progressBar:asset_progressbarbg_ui;
		
		
		public function ProgressHBar() 
		{
			
		}
		override protected function drawUI():void 
		{
			super.drawUI();
			
			_progressBar = new asset_progressbarbg_ui();
			addChild(_progressBar);
			addChildAt(_barBg, 0)
			addChildAt(_progressBar, 1);
			addChildAt(_dragBarButton,2)
			
			removeChild(_downButton);
			removeChild(_upButton);
			
			_progressBar.width =1
		}
		override protected function initUI():void 
		{
			//_downButton.disabled = _upButton.disabled = _dragBarButton.disabled = fa;
		}
		override protected function dragTarget(per:Number):void 
		{
			super.dragTarget(per);
			
			var ww:Number = _barBg.width * per;
			_progressBar.width = ww;
		}
		
	}

}