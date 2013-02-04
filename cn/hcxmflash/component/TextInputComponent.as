package  cn.hcxmflash.component
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
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
		private var _bgMcClass:Class;
		private var _bgMc:MovieClip;
		private var _text:TextField;
		
		public static const TEXT_GAP:int = 4
		
		public static const ENTER:String = "enter";
		public function TextInputComponent() 
		{
			
			drawUI()
			initUI()
		}
		
		private function drawUI():void 
		{
			_bgMcClass = getDefinitionByName("cn.hcxmflash.assets.text_bg") as Class;
			_bgMc = new _bgMcClass();
			addChild(_bgMc);
			
			
			_text = new TextField();
			_text.width = _bgMc.width - TEXT_GAP * 2;
			_text.height = 20;
			_text.defaultTextFormat = new TextFormat("_sans", 12, 0);
			addChild(_text);
			_text.type = TextFieldType.INPUT;
			_text.text = "abc点击输入";
			//_text.background = true;
			
			_text.x = TEXT_GAP;
			
			_text.y = this.height / 2 - _text.height / 2;
			
			_text.addEventListener(TextEvent.TEXT_INPUT, __TEXT_INPUT);
			_text.addEventListener(KeyboardEvent.KEY_DOWN,__KEY_DOWN)
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
			_text.width = _bgMc.width - TEXT_GAP * 2;	
			_text.y = this.height / 2 - _text.height / 2;
		}
		override public function get width():Number 
		{
			return super.width;
		}
		
		override public function set width(value:Number):void 
		{
			//super.width = value;
			
			_bgMc.width = value;
		
			
			reDraw()
		}
		public function get text():String { return _text.text; }
		
	}

}