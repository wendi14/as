package  cn.hcxmflash.container
{
	import cn.hcxmflash.component.Scroll;
	import cn.hcxmflash.component.VScroll;
	import cn.hcxmflash.utils.SpriteUtils;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author 
	 */
	public class Panel extends Sprite 
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
		private var _scrollStep:Number=70;
		
		public function Panel() 
		{
			
			_class_content = getDefinitionByName("cn.hcxmflash.assets.panel_content") as Class;
			_class_head = getDefinitionByName("cn.hcxmflash.assets.panel_head") as Class;
			_class_bottom = getDefinitionByName("cn.hcxmflash.assets.panel_bottom") as Class;
			_holdContentSprite = new Sprite();
			drawUI()
			
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
			
			addChild(_holdContentSprite);
			
			//mc.x = xx; 
			//mc.y = yy;
			_holdContentSprite.addChild(mc);
			_holdContentSprite.x = xx; _holdContentSprite.y = yy+_contentMc.y;
			
			_holdContentMask.x = 0;
			_holdContentMask.y = 0;
			//_holdContentMask.x = xx;
			//_holdContentMask.y = yy;
			_holdContentSprite.addChild(_holdContentMask);
			mc.mask = _holdContentMask;
			
			
			_scroll = new VScroll()
			addChild(_scroll);
			_scroll.target = mc;
			_scroll.maskWidth = _holdContentMask.width;
			_scroll.maskHeight = _holdContentMask.height;
			_scroll.x = _holdContentSprite.x+_holdContentMask.width;
			_scroll.y = _holdContentSprite.y;
			_scroll.scrollStep = _scrollStep;
			_scroll.scrollDuration = _scrollDuration;
		}
		public function addChldToHoldContent(mc:DisplayObject):void
		{
			addChild(_holdContentSprite);
			_holdContentSprite.x = _contentMc.x;
			_holdContentSprite.y = _contentMc.y;
			_holdContentSprite.addChild(mc);
		}
	
		private function drawUI():void 
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
		private var _scrollDuration:Number;
		

		
		private function reDraw():void 
		{

			_contentMc.y = _headMc.height;
			_bottomMc.y = _contentMc.y + _contentMc.height;
			
			//_holdContentSprite.x = _contentMc.x;
			//_holdContentSprite.y = _contentMc.y;

			
		}
		
		
		
		
	}

}