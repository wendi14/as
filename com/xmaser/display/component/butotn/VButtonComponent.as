package com.xmaser.display.component.butotn 
{
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author 小火柴
	 */
	public class VButtonComponent extends ButtonComponent 
	{
		
		public function VButtonComponent() 
		{
			
		}
		override protected function setLabel():void 
		{
			super.setLabel();
			//_txt.autoSize = TextFieldAutoSize.NONE;
			_txt.width = 22;
			//_txt.border = true;
			_txt.wordWrap = true;
			_txt.multiline = true;
			var tf:TextFormat=_txt.defaultTextFormat
			tf.align="center";
		
			_txt.text = _label;
			_txt.setTextFormat(tf);
			align()
		}
		override protected function align():void 
		{
			super.align();
			
		}
		
		
	}

}