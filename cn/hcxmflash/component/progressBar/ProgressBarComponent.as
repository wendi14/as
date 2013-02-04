package cn.hcxmflash.component.progressBar 
{

	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.utils.getDefinitionByName;
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class ProgressBarComponent extends ProgressBarBasic 
	{
		private var _barBg:MovieClip;
		private var _bar:MovieClip;
		private var _mask:Shape;
		
		public function ProgressBarComponent() 
		{
			drawUI();
		}
		protected function drawUI():void 
		{
			var barBgCla:Class = getDefinitionByName("cn.hcxmflash.assets.progress_bg") as Class;
			_barBg = new barBgCla();
			addChild(_barBg);
			
			var barCla:Class = getDefinitionByName("cn.hcxmflash.assets.progress_bar") as Class;
			_bar = new barCla();
			addChild(_bar);
			
			_mask = new Shape()
			_mask.graphics.beginFill(0)
			_mask.graphics.drawRect(0, 0, _bar.width, _bar.height)
			_bar.mask = _mask;
			addChild(_mask);
			_mask.scaleX = 0;
			
		}
		override public function setProgress(value:Number):void 
		{
			super.setProgress(value);
			
			_mask.scaleX = precent;
			
			
		}
		public function setProgressValue(loaded:Number, total:Number):void
		{
			nowProgress = loaded;
			totalProgress = total;
			
			_mask.scaleX = precent;
		}
		
	}

}