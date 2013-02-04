package com.xmaser.display.component.butotn
{
	//import cn.hcxmflash.assets.asset_button_disabled;
	//import cn.hcxmflash.assets.asset_button_down;
	//import cn.hcxmflash.assets.asset_button_normal;
	//import cn.hcxmflash.assets.asset_button_over;
	//import cn.hcxmflash.assets.asset_button_selected;
	import com.xmaser.display.component.butotn.ButtonContainer;
	import com.xmaser.display.component.ComponentBasic;
	import com.xmaser.display.component.IComponent;
	import com.xmaser.display.component.skin.Skin_Button;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;


	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class ButtonComponent extends ComponentBasic implements IComponent
	{
		protected var _skinSkin:Skin_Button;
		public static const SKIN_NORMAL:String = "normal";
		public static const SKIN_OVER :String = "over";
		public static const SKIN_DOWN:String = "down";
		public static const SKIN_SELECTED:String = "selected";
		public static const SKIN_DISABLED:String = "disabled";
		
		public static const SKIN_SELECTED_NORMAL:String = "selected_normal";
		public static const SKIN_SELECTED_OVER :String = "selected_over";
		public static const SKIN_SELECTED_DOWN:String = "selected_down";
		public static const SKIN_SELECTED_SELECTED:String = "selected_selected";
		public static const SKIN_SELECTED_DISABLED:String = "selected_disabled";
		
		
		private static const STATE_NORMAL:int = 0;
		private static const STATE_OVER:int = 1;
		private static const STATE_DOWN:int = 2;
		private static const STATE_SELECTED:int = 3;
		private static const STATE_DISABLED:int = 4;
		private static const STATE_UP:int = 5;
		
		
/*		public var normal:Class
		public var over:Class
		public var down:Class
		public var selected:Class
		public var disabled:Class*/
		
		protected var _holdSkinSp:ButtonContainer;
		protected var _mouseState:int = 0;
		protected var _label:String;
		protected var _txt:TextField;
		protected var _lrGap:int = 8;
		protected var _leftGap:int = 4;
		protected var _rightGap:int = 4;
		protected var _tbGap:int = 4;
		protected var _selected:Boolean = false;
		protected var _disabled:Boolean = false;
		protected var _autoSize:Boolean = true;
		
		protected var _toggle:Boolean = false;
		
		protected var _textFormat:TextFormat=new TextFormat("_snas",12);;
		protected var _overTextFormat:TextFormat=new TextFormat("_snas",12);;
		private var _disabledTextFormat:TextFormat=new TextFormat("_snas",12,0xcccccc);
		private var _embedFont:Boolean;
		private var _selectedTextFormat:TextFormat=_textFormat;
		
		public function ButtonComponent() 
		{
			_holdSkinSp = new ButtonContainer()
			addChild(_holdSkinSp);
			this.buttonMode = true;
			initSkin();
			super()
		}
		protected function initSkin():void
		{
			_skinSkin = new Skin_Button();
			_skinSkin.normal = asset_button_normal;
			_skinSkin.over = asset_button_over;
			_skinSkin.down = asset_button_down;
			_skinSkin.selected = asset_button_selected;
			_skinSkin.disabled = asset_button_disabled;
		}
		override protected function drawUI():void 
		{
			super.drawUI();
			_holdSkinSp.destory();
			_holdSkinSp.addFrame(SKIN_NORMAL, new _skinSkin.normal());
			_holdSkinSp.addFrame(SKIN_OVER, new _skinSkin.over);
			_holdSkinSp.addFrame(SKIN_DOWN,  new _skinSkin.down);
			_holdSkinSp.addFrame(SKIN_SELECTED,  new _skinSkin.selected);
			_holdSkinSp.addFrame(SKIN_DISABLED,  new _skinSkin.disabled);
			
			if (_toggle)
			{
				_holdSkinSp.addFrame(SKIN_SELECTED_NORMAL, _skinSkin.selected_normal?new _skinSkin.selected_normal():new _skinSkin.selected());
				_holdSkinSp.addFrame(SKIN_SELECTED_OVER, _skinSkin.selected_over?new _skinSkin.selected_over:new _skinSkin.selected());
				_holdSkinSp.addFrame(SKIN_SELECTED_DOWN,  _skinSkin.selected_down?new _skinSkin.selected_down:new _skinSkin.selected());
				_holdSkinSp.addFrame(SKIN_SELECTED_SELECTED, _skinSkin.selected_selected? new _skinSkin.selected_selected:new _skinSkin.selected());
				_holdSkinSp.addFrame(SKIN_SELECTED_DISABLED,  _skinSkin.selected_disabled?new _skinSkin.selected_disabled:new _skinSkin.selected());
			}
			
			_holdSkinSp.addEventListener(MouseEvent.MOUSE_OVER, __MOUSE_OVER);
			_holdSkinSp.addEventListener(MouseEvent.MOUSE_OUT, __MOUSE_OUT);
			_holdSkinSp.addEventListener(MouseEvent.MOUSE_DOWN, __MOUSE_DOWN);
			_holdSkinSp.addEventListener(MouseEvent.CLICK, __CLICK);
			
			_holdSkinSp.goto(SKIN_NORMAL);
			
			
			_holdSkinSp.mouseChildren = false;
			
		}
		
		private function __CLICK(e:MouseEvent):void 
		{
			if (_toggle)
			{
				_selected = !_selected;
				if (_selected)
				{
					_mouseState = STATE_SELECTED;
					_holdSkinSp.goto(SKIN_SELECTED);
				}else
				{
					_mouseState = STATE_NORMAL;
					_holdSkinSp.goto(SKIN_NORMAL);
				}
				
				
			}
			clickHandler()
		}
		
		protected function clickHandler():void 
		{
			
		}
		override protected function init():void 
		{
			super.init();
			stage.addEventListener(MouseEvent.MOUSE_UP, __MOUSE_UP);
		}
		
		private function __MOUSE_UP(e:MouseEvent):void 
		{
			//trace( "__MOUSE_UP : " + __MOUSE_UP );
			if (_disabled)
			{
				
				return;
			}
			if (_toggle&&_selected)
			{
				
				_holdSkinSp.goto(SKIN_SELECTED_NORMAL);
				return;
			}
			
			_mouseState = STATE_NORMAL;
			_holdSkinSp.goto(SKIN_NORMAL);
		
			
			
		}
		
		
		private function __MOUSE_DOWN(e:MouseEvent):void 
		{
			
			if (_toggle&&_selected)
			{
				
				_holdSkinSp.goto(SKIN_SELECTED_DOWN);
				return;
			}
			_mouseState = STATE_DOWN;
			_holdSkinSp.goto(SKIN_DOWN);
		}
		
		private function __MOUSE_OVER(e:MouseEvent):void 
		{
			//trace( "__MOUSE_OVER : " + __MOUSE_OVER, name );
			if (_disabled)
			{
				if (_skinSkin.selected_over)
				{
					_holdSkinSp.goto(SKIN_SELECTED_OVER);
				}
				return;
			}
			if (_toggle&&_selected)
			{
				
				_holdSkinSp.goto(SKIN_SELECTED_OVER);
				return;
			}
			
			
			
			_mouseState = STATE_OVER;
			_holdSkinSp.goto(SKIN_OVER);
			
			setTextFormat()
			
			
		}
		
		private function setTextFormat():void 
		{
			if (_txt)
			{
				switch (_mouseState) 
				{
					case STATE_NORMAL:
						_txt.setTextFormat(_textFormat);
					break;
					case STATE_OVER:
						_txt.setTextFormat(_overTextFormat);
					break;
					default:
						_txt.setTextFormat(_textFormat);
					break;
				}
				
			}
		}
		
		protected function __MOUSE_OUT(e:MouseEvent):void 
		{
			//trace( "__MOUSE_OUT : " + __MOUSE_OUT, name );
			if (_disabled)
			{
				if (_skinSkin.selected_normal)
				{
					_holdSkinSp.goto(SKIN_SELECTED_NORMAL);
				}
				return;
			}
			if (_toggle&&_selected)
			{
				
				_holdSkinSp.goto(SKIN_SELECTED_NORMAL);
				return;
			}
			_mouseState = STATE_NORMAL;
			_holdSkinSp.goto(SKIN_NORMAL);
			
			setTextFormat()
		}
		
		
		
		
		
		public function get skinSkin():Skin_Button 
		{
			return _skinSkin;
		}
		
		public function set skinSkin(value:Skin_Button):void 
		{
			_skinSkin = value;
			_holdSkinSp.reSet();
			drawUI();
			align();
		}
		
		public function get label():String 
		{
			return _label;
		}
		
		public function set label(value:String):void 
		{
			_label = value;
			setLabel()
		}
		public function set embedFont (value:Boolean):void 
		{
			_embedFont = value;
			//setLabel()
		}
		
		public function get selected():Boolean 
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void 
		{
			_selected = value;
			reDraw();
		}
		
		public function get disabled():Boolean 
		{
			return _disabled;
		}
		
		public function set disabled(value:Boolean):void 
		{
			_disabled = value;
			reDraw()
		}
		
		public function get autoSize():Boolean 
		{
			return _autoSize;
		}
		
		public function set autoSize(value:Boolean):void 
		{
			_autoSize = value;
		}
		
		private function reDraw():void 
		{
			//trace( "reDraw : " + reDraw,_disabled,name );
			_mouseState = STATE_NORMAL;
			_holdSkinSp.goto(SKIN_NORMAL);
			_holdSkinSp.mouseEnabled = true;
			this.mouseEnabled = true;
			//if(stage)stage.addEventListener(MouseEvent.MOUSE_UP, __MOUSE_UP);
			if (_selected)
			{
				_mouseState = STATE_NORMAL;
				_holdSkinSp.goto(SKIN_SELECTED);
				this.mouseEnabled = false;
				_holdSkinSp.mouseEnabled = false;
			}
			if (_disabled)
			{
				this.mouseEnabled = false;
				_mouseState = STATE_NORMAL;
				_holdSkinSp.goto(SKIN_DISABLED);
				_holdSkinSp.mouseEnabled = false;
				//if(stage)stage.removeEventListener(MouseEvent.MOUSE_UP, __MOUSE_UP);
			}
			if (_txt) 
			{
				_txt.setTextFormat(_textFormat);
			}
			if (_disabled && _skinSkin.selected_normal)
			{
				//_holdSkinSp.mouseEnabled = true;
			}
			if (_txt&&_disabled)
			{
				_txt.setTextFormat(_disabledTextFormat);
			}
			if (_txt&&_selected) 
			{
				_txt.setTextFormat(_selectedTextFormat);
			}
			
		}
		protected function createLabel():void 
		{
			if (!_txt)
			{
				_txt = new TextField();
				
				_txt.selectable = false;
				addChild(_txt);
				_txt.autoSize = "left";
				_txt.defaultTextFormat = _textFormat;
				_txt.mouseEnabled = false;
			}
			_txt.embedFonts = _embedFont;
			
		}
		protected function setLabel():void 
		{
			createLabel();
			if(_label)_txt.text = _label;
			align()
		}
		
		
		protected function align():void 
		{
			
				
			if (_textFormat&&_txt)
			{
				_txt.setTextFormat(_textFormat);
			}
			if (_autoSize)
			{
				resizeHoldSkinSp();
			}
			alignText();
			
			
		}
		protected function resizeHoldSkinSp():void
		{
			if (!_txt) return;
			_holdSkinSp.width = _leftGap + _rightGap + _txt.width
			
			
			_holdSkinSp.height = _tbGap * 2 + _txt.height;
			
			
			
				
			
			
		}
		protected function alignText():void 
		{
			if (_txt)
			{
				
			
			
			_txt.x = _holdSkinSp.width / 2 - _txt.width / 2;
			
			_txt.y = _holdSkinSp.height / 2 - _txt.height / 2;
			
			}
		}
		override public function get height():Number 
		{
			return super.height;
		}
		
		override public function set height(value:Number):void 
		{
			//super.height = value;
			_holdSkinSp.height = value;
			align()
		}
		override public function get width():Number 
		{
			return super.width;
		}
		
		override public function set width(value:Number):void 
		{
			//super.width = value;
			_holdSkinSp.width = value;
			align()
			
		}
		
		public function get toggle():Boolean 
		{
			return _toggle;
		}
		
		public function set toggle(value:Boolean):void 
		{
			_toggle = value;
			drawUI()
		}
		
		public function get textFormat():TextFormat 
		{
			return _textFormat;
		}
		
		public function set textFormat(value:TextFormat):void 
		{
			_textFormat = value;
			
			setLabel()
		}
		
		public function get overTextFormat():TextFormat 
		{
			return _overTextFormat;
		}
		
		public function set overTextFormat(value:TextFormat):void 
		{
			_overTextFormat = value;
		}
		
		public function get lrGap():int 
		{
			return _lrGap;
		}
		
		public function get tbGap():int 
		{
			return _tbGap;
		}
		
		public function set lrGap(value:int):void 
		{
			_lrGap = value;
		}
		
		public function set tbGap(value:int):void 
		{
			_tbGap = value;
		}
		
		public function get leftGap():int 
		{
			return _leftGap;
		}
		
		public function set leftGap(value:int):void 
		{
			_leftGap = value;
		}
		
		public function get rightGap():int 
		{
			return _rightGap;
		}
		
		public function set rightGap(value:int):void 
		{
			_rightGap = value;
		}
		
		public function get selectedTextFormat():TextFormat 
		{
			return _selectedTextFormat;
		}
		
		public function set selectedTextFormat(value:TextFormat):void 
		{
			_selectedTextFormat = value;
		}
		
		public function get disabledTextFormat():TextFormat 
		{
			return _disabledTextFormat;
		}
		
		public function set disabledTextFormat(value:TextFormat):void 
		{
			_disabledTextFormat = value;
		}
		
		
			
		
	}

}