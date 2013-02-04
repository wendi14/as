package com.xmaser.display.container
{
	import assets1.tab_button0_disabled;
	import assets1.tab_button0_normal;
	import assets1.tab_button0_over;
	import assets1.tab_button0_selected;
	import com.xmaser.display.component.butotn.ButtonComponent;
	import com.xmaser.display.component.skin.Skin_Button;
	import com.xmaser.events.HCEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;

	/**
	 * ...如果要设置皮肤的话，要在labs之前
	 * @author 小火柴
	 */
	public class Tab extends Sprite
	{
		[Event(name = "selected", type = "com.xmaser.events.HCEvent")]
		
		
		protected var _buttonArr:Array
		private var _selectedIndex:int = 0;
		protected var _contentArr:Array;
		private var _contentX:Number=0;
		private var _contentY:Number=0;
		private var _tabButtonWidth:Number;
		private var _tabButtonHeight:Number;
		private var _currentContent:*;
		private var _labs:Array;
		private var _skins:Array;
		private var _startx:Number=0;
		private var _starty:Number=0;
		protected var _textFormat:TextFormat=new TextFormat();
		public function get selectedIndex():int { return _selectedIndex; }
		private var _buttonAutoSize:Boolean = true;
		private var _hGap:int=0;
		private var _overTextFormat:TextFormat=new TextFormat();
		private var _selectedTextFormat:TextFormat=new TextFormat();;
		/**
		 * 如果要设置皮肤的话，要在labs之前
		 */

		public function Tab() 
		{
			

		}
		
		
		
		public function set selectedIndex(value:int):void 
		{
			_selectedIndex = value;
			
			for (var i:int = 0; i < _buttonArr.length; i++) 
			{
				ButtonComponent(_buttonArr[i]).selected = false;
				
				if (i == value) 
				{
					ButtonComponent(_buttonArr[i]).selected = true;
				}
				
				
			}
			addNewContent()
		}
		
		public function get contentX():Number 
		{
			return _contentX;
		}
		
		public function set contentX(value:Number):void 
		{
			_contentX = value;
		}
		
		public function get contentY():Number 
		{
			return _contentY;
		}
		
		public function set contentY(value:Number):void 
		{
			_contentY = value;
		}
		
		public function get tabButtonHeight():Number 
		{
			return _tabButtonHeight;
		}
		
		public function get tabButtonWidth():Number 
		{
			return _tabButtonWidth;
		}
		
		public function get contentArr():Array 
		{
			return _contentArr;
		}
		
		public function get currentContent():* 
		{
			return _currentContent;
		}
		
		public function set skins(value:Array):void 
		{
			_skins = value;
		}
		
		
		
		public function get skins():Array 
		{
			return _skins;
		}
		
		public function get labs():Array 
		{
			return _labs;
		}
		public function set labs(value:Array):void 
		{
			_labs = value;
			create()
		}
		public function get starty():Number 
		{
			return _starty;
		}
		
		public function set starty(value:Number):void 
		{
			_starty = value;
		}
		
		public function get startx():Number 
		{
			return _startx;
		}
		
		public function set startx(value:Number):void 
		{
			_startx = value;
		}
		
		private function create():void 
		{
			
			_contentArr = [];
			var ar:Array =labs
			_buttonArr = [];
			var _ww:Number = _startx;
			for (var i:int = 0; i < labs.length; i++) 
			{
				var b1:ButtonComponent = createButton();
				b1.toggle = true;
				b1.label = labs[i];
				//trace( "1---------_tabButtonHeight : " + _tabButtonHeight,b1.height);
				if (skins)
				{
					if (skins.length == 3&&_buttonAutoSize==true)
					{
						switch (i) 
						{
							case 0:
								b1.skinSkin = skins[0];
							break;
							case labs.length-1:
								b1.skinSkin = skins[2];
							break;
							default:
								b1.skinSkin = skins[1];
							break;
						}
						
					}else if (_buttonAutoSize==false) 
					{
						b1.skinSkin = skins[i];
					}
					else
					{
						b1.skinSkin = skins[0];
					}
					
				}else 
				{
					var btnSkin:Skin_Button = new Skin_Button(tab_button0_normal, tab_button0_over, tab_button0_over, tab_button0_selected, tab_button0_disabled);
					b1.skinSkin =btnSkin
				}
				
				b1.addEventListener(MouseEvent.CLICK, __bCLICK);
				//trace( "2---------_tabButtonHeight : " + _tabButtonHeight,b1.height);
				if (i == 0)
				{
					b1.selected = true;
				}
				_tabButtonWidth = b1.width;
				_tabButtonHeight = b1.height;
				//trace( "3---------_tabButtonHeight : " + _tabButtonHeight,b1.height);
				//trace("b1.width : " + b1.width);
				
				addChild(b1);
				
				b1.x = _ww;
				_ww+=(b1.width+_hGap);
				b1.y =starty;
				_buttonArr.push(b1);
				
			}
			rePostion()
		}
	
		
		protected function createButton():ButtonComponent 
		{
			var b1:ButtonComponent = new ButtonComponent();
			b1.autoSize = _buttonAutoSize;
			b1.textFormat = _textFormat;
			b1.overTextFormat = _overTextFormat;;
			b1.selectedTextFormat = _selectedTextFormat;;
			return b1;
		}
		protected function rePostion():void
		{
			
		}
		public function addChildAtIndex(content:*,ind:int):void
		{
			if (!_contentArr[ind])_contentArr[ind] = new Sprite();
			_contentArr[ind].name = "content" + ind;
			_contentArr[ind].addChild(content);
			
			_contentArr[ind].x=contentX
			_contentArr[ind].y=contentY
			if (ind == 0)
			{
				//addChild(_contentArr[ind]);
				
			}
			
		}
		private function __bCLICK(e:MouseEvent):void 
		{
			
			for (var i:int = 0; i < _buttonArr.length; i++) 
			{
				if (ButtonComponent(_buttonArr[i]) == e.currentTarget)
				{
					ButtonComponent(_buttonArr[i]).selected = true
					
					removeOldContent();
					
					_selectedIndex = i;
					
					addNewContent();
					
					dispatchEvent(new HCEvent(HCEvent.SELECTED,_selectedIndex));
				}else
				{
					ButtonComponent(_buttonArr[i]).selected = false;
				}
			}
		}
		protected function removeOldContent():void 
		{
			if (_contentArr[_selectedIndex])
			{
				removeChild(_contentArr[_selectedIndex]);
			}
			
		}
		protected function addNewContent():void 
		{
			if (!_contentArr[_selectedIndex]) return;
			addChild(_contentArr[_selectedIndex]);
			_currentContent = _contentArr[_selectedIndex].getChildAt(0);
		}
		public function set textFormat(value:TextFormat):void 
		{
			_textFormat = value;
		}
		public function set overTextFormat(value:TextFormat):void 
		{
			_overTextFormat = value;
		}
		public function set buttonAutoSize(value:Boolean):void 
		{
			_buttonAutoSize = value;
		}
		
		public function get hGap():int 
		{
			return _hGap;
		}
		
		public function set hGap(value:int):void 
		{
			_hGap = value;
		}
		
		public function set selectedTextFormat(value:TextFormat):void 
		{
			_selectedTextFormat = value;
		}
		
		public function get buttonArr():Array 
		{
			return _buttonArr;
		}
		
	}

}