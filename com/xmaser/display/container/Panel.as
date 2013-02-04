package  com.xmaser.display.container
{
	import cn.hcxmflash.assets.panel_bottom;
	import cn.hcxmflash.assets.panel_content;
	import cn.hcxmflash.assets.panel_head;
	import cn.hcxmflash.component.LabelComponent;
	import cn.hcxmflash.component.Scroll;
	import cn.hcxmflash.component.VScroll;
	import cn.hcxmflash.utils.SpriteUtils;
	import com.xmaser.const_.AlginConst;
	import com.xmaser.display.component.butotn.ButtonComponent;
	import com.xmaser.display.component.ComponentBasic;
	import com.xmaser.display.component.skin.Skin_Button;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author 
	 */
	public class Panel extends  ComponentBasic 
	{
		
		
		//------------------UI-------------------
		private var _class_content:Class;
		private var _class_head:Class;
		private var _class_bottom:Class;
		//private var _class_:Class;
		private var _headMc:MovieClip;//头部
		private var _contentMc:MovieClip;//内容
		private var _bottomMc:Sprite;//底部
		private var __bottomMc:MovieClip;
		
		
		
		/**
		 * 放置内容的
		 */
		private var _holdContentSprite:Sprite;
		private var _holdContentMask:Shape=new Shape();
		private var _holdContentMaskWidth:Number;
		private var _holdContentMaskHeight:Number;
		private var _scroll:VScroll;
		private var _scrollX:Number;
		private var _scrollY:Number;
		private var _scrollStep:Number = 70;
		
		/**
		 * 标题
		 */
		private var _title:String;
		
		public function Panel() 
		{
			
			_class_content = panel_content;
			
			_class_head = panel_head
			_class_bottom = panel_bottom
			_holdContentSprite = new Sprite();
			
			super()
			
		}
		
		public function set classArr(value:*):void 
		{
			if (value)
			{
				_class_content = value[1];
				_class_head = value[0];
				/*_class_content = getDefinitionByName("cn.hcxmflash.assets.panel_content") as Class;
			_class_head = getDefinitionByName("cn.hcxmflash.assets.panel_head") as Class;*/
			}
			
			drawUI()
		}
		public function addContent(mc:*,xx:int=0,yy:int=0):void
		{
			
			
			
			//mc.x = xx; 
			//mc.y = yy;
				_holdContentSprite.x = xx + 2;
				_holdContentSprite.y = _contentMc.y +yy
			_holdContentSprite.addChild(mc);
			//_holdContentSprite.x = xx; _holdContentSprite.y = yy+_contentMc.y;
			
			_holdContentMask.x = mc.x;
			_holdContentMask.y = mc.y;
			//_holdContentMask.x = xx;
			//_holdContentMask.y = yy;
			_holdContentSprite.addChild(_holdContentMask);
			_holdContentSprite.mask = _holdContentMask;
			
			
			/*_scroll = new VScroll()
			addChild(_scroll);
			_scroll.target = mc;
			_scroll.maskWidth = _holdContentMask.width;
			_scroll.maskHeight = _holdContentMask.height;
			_scroll.x = _holdContentSprite.x+_holdContentMask.width;
			_scroll.y = _holdContentSprite.y;
			_scroll.scrollStep = _scrollStep;
			_scroll.scrollDuration = _scrollDuration;*/
		}
		public function addToBottom(mc:*,algin:String="left"):void
		{
			if (!_holdBottomMc)
			{
				_holdBottomMc = new Sprite();
				addChild(_holdBottomMc);
				_holdBottomMc.x = _bottomMc.x + 2;
				_holdBottomMc.y = _bottomMc.y +2;
				
			}
			_holdBottomMc.addChild(mc);
			if (algin == AlginConst.RIGHT)
			{
				mc.x =_bottomMc.width- _bottomMc.width - 2;
			}
			
		}
		public function addChldToHoldContent(mc:DisplayObject):void
		{
			addChild(_holdContentSprite);
			_holdContentSprite.x = _contentMc.x;
			_holdContentSprite.y = _contentMc.y;
			_holdContentSprite.addChild(mc);
		}
	
		override protected function drawUI():void 
		{
			_headMc = new _class_head()
			addChild(_headMc);
			
			_contentMc = new _class_content();
			addChild(_contentMc);
			
			__bottomMc = new _class_bottom();
			_bottomMc = new Sprite()
			addChild(_bottomMc)
			_bottomMc.addChild(__bottomMc);
			
			
			initUI()
		}
		
		private function initUI():void 
		{
			addChild(_holdContentSprite);
			
			headWidth = contentWidth = bottomWidth =300
			headHeight = 34;
			contentHeight = 300;
			
			_holdContentMask.graphics.beginFill(0);
			_holdContentMask.graphics.drawRect(0, 0, _contentMc.width, _contentMc.height);
			_holdContentMask.graphics.endFill();
			_holdContentMask.x = _holdContentSprite.x;
			_holdContentMask.y = _holdContentSprite.y;
			
			
		}
		public function get broderThickness():Number { return 2; }
		public function get headHeight():Number { return _headMc.height; }
		public function set headHeight(value:Number):void 
		{
			_headMc.height = value;
			
			
			reDraw()
		}
		public function set headWidth(value:Number):void 
		{
			_headMc.width = value;
			_contentMc.width = value;
			__bottomMc.width = value;
			
			reDraw();
		}
		public function set contentHeight(value:Number):void 
		{
			_contentMc.height = value;
			reDraw();
		}
		public function get contentHeight():Number { return _contentMc.height; }
		public function set contentWidth(value:Number):void 
		{
			_headMc.width = value;
			_contentMc.width = value;
			__bottomMc.width = value;
			reDraw();
		}
		public function get contentWidth():Number 
		{
			
			return _contentMc.width
			
		}
		public function set bottomWidth(value:Number):void 
		{
			_headMc.width = value;
			_contentMc.width = value;
			__bottomMc.width = value;
			reDraw();
		}
		public function set bottomHeight(value:Number):void 
		{
			__bottomMc.height = value;
			reDraw();
		}
		
		public function get scrollX():Number 
		{
			return _scrollX;
		}
		
		public function set scrollX(value:Number):void 
		{
			_scrollX = value;
			_scroll.x = value;
		}
		
		public function get scrollY():Number		
		{
			return _scrollY;
		}
		
		public function set scrollY(value:Number):void 
		{
			_scrollY = value;
			_scroll.y = value;
		}
		
		public function get holdContentMaskHeight():Number 
		{
			return _holdContentMaskHeight;
		}
		
		public function set holdContentMaskHeight(value:Number):void 
		{
			_holdContentMaskHeight = value;
			_holdContentMask.height = value;
		}
		
		public function get holdContentMaskWidth():Number 
		{
			return _holdContentMaskWidth;
		}
		
		public function set holdContentMaskWidth(value:Number):void 
		{
			_holdContentMaskWidth = value;
			_holdContentMask.width = value;
		}
		public function set dragBarPostionPercent(value:Number):void 
		{
			_scroll.dragBarPostionPercent = value;
		}
		
		public function get headMc():MovieClip 
		{
			return _headMc;
		}
		
		public function get bottomMc():Sprite 
		{
			return _bottomMc;
		}
		public function set scrollStep(value:Number):void 
		{
			_scrollStep = value;
		}
		
		public function get scrollStep():Number 
		{
			return _scrollStep;
		}
		
		public function get scrollDuration(): Number
		{
			return _scrollDuration;
		}
		
		public function set scrollDuration(value:Number):void 
		{
			_scrollDuration = value;
		}
		
		public function get title():String 
		{
			return _title;
		}
		
		public function set title(value:String):void 
		{
			_title = value;
			crateTitle();
		}
		public function set titleTextFormat(value:TextFormat):void 
		{
			_titleTextFormat = value;
			_titleChange = true;
			reDraw();
			
		}
		
		public function get showCloseButton():Boolean 
		{
			return _showCloseButton;
		}
		
		public function set showCloseButton(value:Boolean):void 
		{
			_showCloseButton = value;
			
			reDraw()
			
		}
		
		public function set closeButtonSkin(value:Skin_Button):void 
		{
			_closeButton.label = "";
			_closeButton.autoSize = false;
			_closeButton.skinSkin = value;
			
			reDraw()
		}
		public function set closeFunction(value:Function):void 
		{
			_closeFunction = value;
		}
		
		private function crateTitle():void 
		{
			if (!_titleLabel)
			{
				_titleLabel = new LabelComponent(_title,'_sans',12,0,true);
				addChild(_titleLabel);
			}
			_titleLabel.text = _title;
			_titleChange = true;
			reDraw()
		}
		
		private var _scrollDuration:Number;
		private var _titleLabel:LabelComponent;
		private var _titleChange:Boolean;
		private var _titleTextFormat:TextFormat;
		private var _holdBottomMc:Sprite;
		private var _showCloseButton:Boolean;
		private var _closeButton:ButtonComponent;
		private var _closeFunction:Function;
		

		
		private function reDraw():void 
		{

			_holdContentMask.graphics.clear();
			_holdContentMask.graphics.beginFill(0);
			_holdContentMask.graphics.drawRect(0, 0, _contentMc.width, _contentMc.height);
			_holdContentMask.graphics.endFill();
			
			
			_contentMc.y = _headMc.height;
			_bottomMc.y = _contentMc.y + _contentMc.height;
			
			
			
			
			if (_titleChange)
			{
				_titleChange = false;
				
				_titleLabel.x = _headMc.x + 10;
				_titleLabel.y = _headMc.y + _headMc.height / 2 - _titleLabel.height / 2;
				if (_titleTextFormat)
				{
					_titleLabel.textFormat = _titleTextFormat;
				}
			}
			if (_showCloseButton)
			{
				if (!_closeButton)
				{
					_closeButton = new ButtonComponent();
					_closeButton.addEventListener(MouseEvent.CLICK, __closeButtonCLICK);
					addChild(_closeButton);
					_closeButton.label = "X";
					
				}
				_closeButton.x = _headMc.width - _closeButton.width-10;
				_closeButton.y = 2;
			}

			
		}
		
		private function __closeButtonCLICK(e:MouseEvent):void 
		{
			if (_closeFunction!=null) 
			{
				_closeFunction();
			}
		}
		
		
		
		
		
	}

}