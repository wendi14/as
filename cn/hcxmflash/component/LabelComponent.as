package cn.hcxmflash.component 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class LabelComponent extends Sprite
	{
		private var _tf:TextFormat;
		private var _txt:TextField;
		private var _text:String;
		
		public function LabelComponent(txt:String, font:String = '_sans', size:int = 12, color:uint = 0x000000, bold:Boolean = false,icon:*=null)
		{
			if (font == '') font = "_sans";
			//if (color == null) color = 0x000000;
			_tf = new TextFormat(font, size, color, bold)
			_txt = new TextField()
			_txt.selectable = false;
			_txt.autoSize = "left";
			_txt.defaultTextFormat = _tf;;
			addChild(_txt)
			_text = txt;
			text = txt;
			
			if (icon) 
			{
				addChild(icon);
				icon.x=icon.y=0
				_txt.x = icon.width + 6;
				var maxH:Number = Math.max(icon.height, _txt.height)
				
				icon.y = maxH / 2 - icon.height / 2;
				_txt.y = maxH / 2 - _txt.height / 2;
				
			}
			this.mouseChildren = this.mouseEnabled = false;
		}
		public function get text():String { return _text; }
		
		public function set text(value:String):void 
		{
			_txt.htmlText = _text=value;
			
		}
		public function get txt():TextField { return _txt; }
		
		public function get textFormat():TextFormat 
		{
			return _textFormat;
		}
		
		public function set textFormat(value:TextFormat):void 
		{
			_textFormat = value;
			if (_txt)
			{
				_txt.setTextFormat(_textFormat);
			}
		}
		
		private var _textFormat:TextFormat;
		
	}

}