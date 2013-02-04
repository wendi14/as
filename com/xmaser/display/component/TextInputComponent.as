package  com.xmaser.display.component
{
	import cn.hcxmflash.assets.text_bg;
	import cn.hcxmflash.assets.text_bg_s;
	import com.xmaser.display.container.FrameSprite;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author 
	 */
	public class TextInputComponent extends Sprite 
	{
		
		private var _text:TextField;
		
		public static const TEXT_GAP:int = 4
		
		public static const ENTER:String = "enter";
		
		private var _holdBg:FrameSprite=new FrameSprite()
		private var _height:Number=-1;
		private var _defaultText:String='点击输入';
		private var _displayAsPassword:Boolean;
		public function TextInputComponent() 
		{
			addChild(_holdBg);
			drawUI()
			initUI()
		}
		
		private function drawUI():void 
		{
	
			_holdBg.addFrame("1", new text_bg());
			_holdBg.addFrame("2", new text_bg_s());
			_holdBg.goto("1");
			
			
			_text = new TextField();
			_text.wordWrap = true;
			_text.width = _holdBg.width - TEXT_GAP * 2;
			_text.height = 20;
			_text.defaultTextFormat = new TextFormat("_sans", 12, 0);
			addChild(_text);
			_text.type = TextFieldType.INPUT;
			_text.text = "点击输入";
			//_text.background = true;
			
			_text.x = TEXT_GAP;
			
			_text.y = this.height / 2 - _text.height / 2;
			
			_text.addEventListener(TextEvent.TEXT_INPUT, __TEXT_INPUT);
			_text.addEventListener(KeyboardEvent.KEY_DOWN, __KEY_DOWN);
			_text.addEventListener(FocusEvent.FOCUS_IN, __FOCUS_IN);
			_text.addEventListener(FocusEvent.FOCUS_OUT, __FOCUS_OUT);
		}
		/**
		 * 默认显示的文字
		 */
		public function set defaultText(value:String):void 
		{
			_text.text = value;
			_defaultText = value;
		}
		public function set displayAsPassword(value:Boolean):void 
		{
			_text.displayAsPassword = value;
			_displayAsPassword = true;
			
		}
		private function __FOCUS_IN(e:FocusEvent):void 
		{
			if (_text.text == _defaultText)
			{
				_text.text = '';
			}
			if (_displayAsPassword) 
			{
				_text.displayAsPassword = _displayAsPassword;
			}
			_holdBg.goto("2");
		}
		
		private function __FOCUS_OUT(e:FocusEvent):void 
		{
			if (_text.text == '')
			{
				_text.text = _defaultText;
				if (_displayAsPassword)
				{
					_text.text = '';
				}
			}
			_holdBg.goto("1");
		}
		
		private function __KEY_DOWN(e:KeyboardEvent):void 
		{
			if(e.keyCode == 13)
			{
				dispatchEvent(new Event(ENTER));
			}
		}
		
		private function __TEXT_INPUT(e:TextEvent):void 
		{
			//trace( "e : " + e.text );
			
		}		
		private function initUI():void 
		{
			width=100
		}
		private function reDraw():void
		{
			_text.width = _holdBg.width - TEXT_GAP * 2;	
			_text.y = this.height / 2 - _text.height / 2;
			
		}
		override public function get width():Number 
		{
			return super.width;
		}
		
		override public function set width(value:Number):void 
		{
			//super.width = value;
			
			_holdBg.width = value;
	
			
			reDraw()
		}
		override public function get height():Number 
		{
			return super.height;
		}
		
		override public function set height(value:Number):void 
		{
			_holdBg.height = value;
			//trace("value: " + value);
			
			//_text.height = value-TEXT_GAP * 2;
			_height = value;
			reDraw()
		}
		public function get text():String { return _text.text; }
		public function set text(value:String):void 
		{
			_text.text = value;
		}
		
	}

}