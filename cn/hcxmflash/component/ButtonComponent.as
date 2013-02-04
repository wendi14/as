package cn.hcxmflash.component
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;


	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class ButtonComponent extends Sprite
	{
		public static var HGAP:int=12;
		private var _className:Array;
		private var _stateTotal:int;
		private var _label:String;
		/**
		 * 
		 * @param	className　如果 state=1 ，只需要填前缀
		 * @param	state　
		 */
		protected var _normalButton:*
		protected var _normalButton_oldHeight:Number
		protected var _overButton:*
		private var _selectedButton:*
		private var _disabledButton:*
		private var _labelTxt:TextField;
		private var _isOverZoom:Boolean = true;
		
		private var _selected:Boolean=false;
		private var _disabled:Boolean=false;
		
		private var _holdButtonSprite:Sprite;
		
		private var _buttonMcArrary:Array=[]
		private var _autosize:Boolean = false;
		private var tf:TextFormat;
		private var _textFormat:TextFormat = new TextFormat("_sans", 12,0,false);
		private var _normalWidth:Number;
		private var _embedFonts:Boolean=false;
		private var _thickness:Number=0;
		private var _overTextFormat:TextFormat;
		private var _selectedTextFormat:TextFormat;
		private var _disabledTextFormat:TextFormat;
		private var _state:String = STATE_NORMAL;
		public static const STATE_NORMAL:String = "stateNormal";
		public static const STATE_OVER:String ="stateOver"
		public static const STATE_SELECTED:String = "stateSelected";
		public static const STATE_DISABLED:String = "stateDisabled";
		
		private var _labelTxtArr:Array = [];
		public function set autosize(value:Boolean):void 
		{
			if (value)
			{
				width = _labelTxt.width + 12;
				//trace( "width : " + width );
				
				height = _labelTxt.height + HGAP
				//trace( "height : " + height );
				
			
				drawLabel()
			}
		}
		public function get autosize():Boolean { return _autosize; }
		public function set isOverZoom(value:Boolean):void 
		{
			_isOverZoom = value;
		}
		public function ButtonComponent(className:Array,state:int=1,label:String='',embedFonts:Boolean=false,thickness:Number=0) 
		{
			_embedFonts = embedFonts;
			_thickness=thickness
			_holdButtonSprite = new Sprite()
			addChild(_holdButtonSprite);
			if (className == null)
			{
				className=[getDefinitionByName("button_normal"),getDefinitionByName("button_over"),getDefinitionByName("button_selected"),getDefinitionByName("button_disabled"),]
			}
			_className = className;
			//trace("_className : " + _className);
			_label = label;
			_stateTotal = state;
			this.buttonMode = true;
			init()
		}
		protected function init():void 
		{
			var cl:*;
			var bu:*;
			_buttonMcArrary=[]
			switch (_stateTotal) 
			{
				
				case 1:
					cl = _className[0]
					_normalButton = new cl()
					_holdButtonSprite.addChild(_normalButton)
		
					
					_buttonMcArrary.push(_normalButton)
				break;
				case 2:
					cl =_className[0]
					_normalButton = new cl()

					cl = _className[1]
					_overButton = new cl();

					
					
					
					_holdButtonSprite.addChild(_normalButton)
					_holdButtonSprite.addChild(_overButton)
					
				

					
					
					_overButton.visible = false;
					_buttonMcArrary.push(_normalButton)
					_buttonMcArrary.push(_overButton)
					
				break;
				case 3:
					cl =_className[0]
					_normalButton = new cl()

					cl = _className[1]
					_overButton = new cl();

					cl = _className[2]
					_selectedButton = new cl();
					
				
					
					
					_holdButtonSprite.addChild(_normalButton)
					_holdButtonSprite.addChild(_overButton)
					_holdButtonSprite.addChild(_selectedButton)
					
				

					
					
					_overButton.visible = _selectedButton.visible = false;
					_buttonMcArrary.push(_normalButton);
					_buttonMcArrary.push(_selectedButton);
					_buttonMcArrary.push(_overButton)
					
					break;
				case 4:
						cl =_className[0]
					_normalButton = new cl()

					cl = _className[1]
					_overButton = new cl();

					cl =_className[2]
					_selectedButton = new cl();
					
					cl = _className[3]
					_disabledButton = new cl();
					
					
					_holdButtonSprite.addChild(_normalButton)
					_holdButtonSprite.addChild(_overButton)
					_holdButtonSprite.addChild(_selectedButton)
					_holdButtonSprite.addChild(_disabledButton)
				
					
					_overButton.visible = _selectedButton.visible = _disabledButton.visible = false;
					
					_buttonMcArrary.push(_normalButton)
					_buttonMcArrary.push(_overButton)
					_buttonMcArrary.push(_selectedButton)
					_buttonMcArrary.push(_disabledButton)
			
				break;
			}
			_normalWidth = _normalButton.width;
			_normalButton_oldHeight = _normalButton.height;
			this._holdButtonSprite.setChildIndex(_normalButton, _holdButtonSprite.numChildren - 1)
			
				
			this.addEventListener(MouseEvent.ROLL_OVER,__ROLL_OVER)
			this.addEventListener(MouseEvent.ROLL_OUT, __ROLL_OUT)
	
			
			
			
			if (_label!='') 
			{
				drawLabel();
				
				if (autosize)
				{
					
				}
			}
			
			
		}

		
		protected function __ROLL_OUT(e:MouseEvent):void 
		{
			
			
			if (_disabled) 
			{
				return
			}
			if (_selected) 
			{
				hideExcept(_selectedButton)
				this._holdButtonSprite.setChildIndex(_selectedButton, _holdButtonSprite.numChildren - 1);
				state = STATE_SELECTED;
			}else
			{
				hideExcept(_normalButton)
				this._holdButtonSprite.setChildIndex(_normalButton, _holdButtonSprite.numChildren - 1);
				state = STATE_NORMAL;
			}
			
			
		}
		
		/**
		 * 除了 bu 其它隐藏
		 * @param	bu
		 */
		private function hideExcept(bu:* ):void
		{
			for (var i:int = 0; i < _buttonMcArrary.length; i++) 
			{
				if (bu.name == _buttonMcArrary[i].name)
				{
					_buttonMcArrary[i].visible = true;
					
				}else
				{
					_buttonMcArrary[i].visible = false;
				}
			}
		}
		
		protected function __ROLL_OVER(e:MouseEvent):void 
		{
			
			if (_disabled||_selected) 
			{
				return
			}
			if (_overButton)
			{
				hideExcept(_overButton);
				this._holdButtonSprite.setChildIndex(_overButton, _holdButtonSprite.numChildren - 1);
				state = STATE_OVER;
				
			}
			
			
			
		}
		public function set selected(value:Boolean):void 
		{
			_selected = value;
			if (value)
			{
				hideExcept(_selectedButton)
				this._holdButtonSprite.setChildIndex(_selectedButton, _holdButtonSprite.numChildren - 1);
				state = STATE_SELECTED;
			}else
			{
				hideExcept(_normalButton)
				this._holdButtonSprite.setChildIndex(_normalButton, _holdButtonSprite.numChildren - 1);
				state = STATE_NORMAL;
			}
		}
		public function get selected():Boolean { return _selected; }
		public function set disabled(value:Boolean):void 
		{
			_disabled = value;
			if (_disabled) 
			{				
				hideExcept(_disabledButton);
				
				this._holdButtonSprite.setChildIndex(_disabledButton, _holdButtonSprite.numChildren - 1);
				this.mouseEnabled = false;
				this.mouseChildren = false
				state = STATE_DISABLED;
				/*if (_labelTxt) 
				{
					var tf1:TextFormat = new TextFormat(tf.font, tf.size,0);
					_labelTxt.setTextFormat(tf1);
				}*/
			}else
			{
				
				hideExcept(_normalButton);
				
				this._holdButtonSprite.setChildIndex(_normalButton, _holdButtonSprite.numChildren - 1)
				
				this.mouseEnabled = true;
				this.mouseChildren = true
				state = STATE_NORMAL;
				/*if (_labelTxt) 
				{
					
					_labelTxt.setTextFormat(tf);
				}*/
			}
		}
		public function get disabled():Boolean { return _disabled; }
		
		override public function get height():Number { return super.height; }
		
		override public function set height(value:Number):void 
		{
			var sp:Number = value / _normalButton_oldHeight
			
			
			
			for (var i:int = 0; i < _buttonMcArrary.length; i++) 
			{
				_buttonMcArrary[i].scaleY = sp;
				
			}
			
		}
		override public function get width():Number { return super.width; }
		
		override public function set width(value:Number):void 
		{
			//trace( "value : " + value );
			
			var sp:Number = value / _normalWidth
			//trace( "_normalButton.width : " + _normalButton.width );
			
			//trace( "sp : " + sp );
			
			for (var i:int = 0; i < _buttonMcArrary.length; i++) 
			{
				//trace( "_buttonMcArrary[i].scaleX : " + _buttonMcArrary[i].scaleX );
				_buttonMcArrary[i].scaleX = sp;
				
				//_buttonMcArrary[i].x=-_buttonMcArrary[i].width/2
			}
		}
		
		private function drawLabel():void
		{
			if (_labelTxt)
			{
				
				var tef:TextFormat
				
				if (_state == STATE_NORMAL&&_textFormat) 
				{
					tef = _textFormat;
					_labelTxt.setTextFormat(_textFormat);
				}else if (_state == STATE_OVER&&_overTextFormat)
				{
					tef = _overTextFormat;
					_labelTxt.setTextFormat(_overTextFormat);
					
				}else if (_state == STATE_DISABLED&&_disabledTextFormat) 
				{
					tef = _disabledTextFormat;
					_labelTxt.setTextFormat(_disabledTextFormat);
				}else if (_state == STATE_SELECTED&&_selectedTextFormat) 
				{
					tef = _selectedTextFormat;
					_labelTxt.setTextFormat(_selectedTextFormat);
				}
				if (_autosize)_labelTxt.y = height / 2 - _labelTxt.height / 2;	
				
				for (var i:int = 0; i <_labelTxtArr.length; i++) 
				{
					var item:TextField = _labelTxtArr[i];
					
					if (this.contains(item) == false)
					{
						addChild(item);
					}
					if (item)
					{
						item.setTextFormat(tef);
					}
				}
				return;
			}
			_labelTxt = new TextField();
			_labelTxt.embedFonts = _embedFonts
			if (_embedFonts)
			{
				_labelTxt.antiAliasType = AntiAliasType.ADVANCED
				_labelTxt.thickness=_thickness
			}
			addChild(_labelTxt);
			_labelTxt.autoSize = TextFieldAutoSize.LEFT
			_labelTxt.htmlText = _label;
			
			_labelTxt.selectable = false;
			_labelTxt.x =6
			if(_autosize)_labelTxt.y = _labelTxt.height / 2;
			
			_labelTxt.mouseEnabled = false;
			
			tf = _textFormat;

			
			_labelTxt.setTextFormat(_textFormat);
			_labelTxt.width
			
			
			_labelTxt.textWidth
			
			
			
			if (_autosize) 
			{
				autosize = true;
			}
		}
		public function set textFormat(value:TextFormat):void 
		{
			_textFormat = value;
			_labelTxt.setTextFormat(value);
			//trace( "_labelTxt.width : " + _labelTxt.width );
			//trace( "_labelTxt.textWidth : " + _labelTxt.textWidth );
			
			drawLabel()
		}
		
		public function set overTextFormat(value:TextFormat):void 
		{
			_overTextFormat = value;
			
		}
		
		public function set selectedTextFormat(value:TextFormat):void 
		{
			_selectedTextFormat = value;
		}
		
		public function get state():String 
		{
			return _state;
		}
		
		public function set state(value:String):void 
		{
			_state = value;
			drawLabel();
		}
		
		public function set disabledTextFormat(value:TextFormat):void 
		{
			_disabledTextFormat = value;
		}
		
		public function get label():String 
		{
			return _label;
		}
		
		public function set label(value:String):void 
		{
			_label = value;
			drawLabel()
		}
		
		public function get labelTxtArr():Array 
		{
			return _labelTxtArr;
		}
		
		public function set labelTxtArr(value:Array):void 
		{
			_labelTxtArr = value;
			drawLabel();
		}
		
	}

}