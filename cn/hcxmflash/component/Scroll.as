package  cn.hcxmflash.component
{
	import cn.hcxmflash.event.Event_;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	import gs.TweenLite;
	
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class Scroll extends Sprite 
	{
		private var _oldDargBarHeight:int=0;
		public var scrollForwardButton:*;
		public var scrollBackButton:*;
		public var step:int = 0;
		public var position:Number;
		protected var _maskHeight :Number=100;
        protected var _maskWidth:Number=100;
		 
		 protected var _upButton:ButtonComponent;
		 protected var _downButton:ButtonComponent;
		 protected var _barBg:MovieClip;
		 protected var _dragBarButton:ButtonComponent
		 protected var _target:DisplayObject;
		 protected var _targetOldy:Number;
		 
		 protected var _scrollStep:Number = 70;
		 
		 public static const DRAGING_BAR:String = "dragingBar";
		 public static const DRAGING_BAR_END:String = "dragingBarEnd";
		 
		 protected var _dragBarPostionPercent:Number
		public function Scroll() 
		{
			drawUI()
			initUI()
		}
		public function enabled():void
		{
			if (_downButton.disabled == false) return;
			_downButton.disabled = _upButton.disabled = _dragBarButton.disabled = false;
		}
		public function disable():void
		{
			_downButton.disabled = _upButton.disabled = _dragBarButton.disabled = true;
		}
		protected function drawUI():void 
		{
			
			
			var barBgCla:Class = getDefinitionByName("cn.hcxmflash.assets.scroll_bar") as Class;
			_barBg = new barBgCla();
			addChild(_barBg);
			_barBg.addEventListener(MouseEvent.CLICK, __barBgCLICK);
			
			var clarr:Array=[getDefinitionByName("cn.hcxmflash.assets.scroll_b_normal"),getDefinitionByName("cn.hcxmflash.assets.scroll_b_over"),getDefinitionByName("cn.hcxmflash.assets.scroll_b_selected"),getDefinitionByName("cn.hcxmflash.assets.scroll_b_disabled")]
			_upButton = new ButtonComponent(clarr, 4);
			addChild(_upButton);
			_upButton.addEventListener(MouseEvent.CLICK, __upButtonCLICK);
			
			var clarrd:Array=[getDefinitionByName("cn.hcxmflash.assets.scroll_bd_normal"),getDefinitionByName("cn.hcxmflash.assets.scroll_bd_over"),getDefinitionByName("cn.hcxmflash.assets.scroll_bd_selected"),getDefinitionByName("cn.hcxmflash.assets.scroll_bd_disabled")]
			_downButton = new ButtonComponent(clarrd, 4);
			addChild(_downButton);
			_downButton.addEventListener(MouseEvent.CLICK, __downButtonCLICK);
			
			var dragArr:Array=[getDefinitionByName("cn.hcxmflash.assets.scroll_dragbar_normal"),getDefinitionByName("cn.hcxmflash.assets.scroll_dragbar_over"),getDefinitionByName("cn.hcxmflash.assets.scroll_dragbar_selected"),getDefinitionByName("cn.hcxmflash.assets.scroll_dragbar_disabled")]
			_dragBarButton = new ButtonComponent(dragArr, 4);
			_dragBarButton.addEventListener(MouseEvent.MOUSE_DOWN,__dragBarButtonMOUSE_DOWN)
			addChild(_dragBarButton);
		}
		
		private function __barBgCLICK(e:MouseEvent):void 
		{
			var per:Number;
			var totlh:Number = _barBg.height;
			
			per = ( e.localY*_barBg.scaleY) / totlh;
			dragBarPostionPercent = per;
		}
		
		protected function __downButtonCLICK(e:MouseEvent):void 
		{
			var per:Number = (_dragBarButton.y + _scrollStep - _barBg.y) / (_barBg.height - _dragBarButton.height);
			var bary:Number = _dragBarButton.y + _scrollStep
			if (bary > _barBg.y + _barBg.height - _dragBarButton.height)
			{
				bary = _barBg.y + _barBg.height - _dragBarButton.height;
			}
			TweenLite.to(_dragBarButton, 0.2, {y: bary} );
			dragTarget(per)
		}
		
		protected function __upButtonCLICK(e:MouseEvent):void 
		{
			var per:Number = (_dragBarButton.y - _scrollStep - _barBg.y) / (_barBg.height - _dragBarButton.height);
			var bary:Number = _dragBarButton.y - _scrollStep
			if (bary<_barBg.y)
			{
				bary = _barBg.y
			}
			TweenLite.to(_dragBarButton, 0.2, {y: bary} );
			dragTarget(per)
		}
		
		protected function __dragBarButtonMOUSE_DOWN(e:MouseEvent):void 
		{
			var rec:Rectangle = new Rectangle(_dragBarButton.x, _barBg.y, 0, _barBg.height-_dragBarButton.height);
			_dragBarButton.startDrag(false, rec);
			stage.addEventListener(MouseEvent.MOUSE_UP,__dragBarButtonMOUSE_UP)
			stage.addEventListener(MouseEvent.MOUSE_MOVE, __stageMOUSE_MOVE);
		}
		protected function calOnMouseMovePer():Number
		{
			var per:Number = (_dragBarButton.y - _barBg.y) / (_barBg.height - _dragBarButton.height);
			if (per >1) per = 1;
			if (per < 0) per = 0;
			return per;
		}
		protected function __stageMOUSE_MOVE(e:MouseEvent):void 
		{
			var per:Number = calOnMouseMovePer();
			
			dragTarget(per)
			dispatchEvent(new Event_(Scroll.DRAGING_BAR,per))
		}
		
		protected function dragTarget(per:Number):void 
		{
			//trace( "per : " + per );
			if (per >1) per = 1;
			if (per < 0) per = 0;
			var madis:Number = target.height - _maskHeight;
			var targetY:Number=_targetOldy+ -madis * per;
			TweenLite.to(_target, _scrollDuration, { y:targetY } );
		}
		
		protected function __dragBarButtonMOUSE_UP(e:MouseEvent):void 
		{
		
			_dragBarButton.stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_UP, __dragBarButtonMOUSE_UP);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, __stageMOUSE_MOVE);
			dispatchEvent(new Event_(Scroll.DRAGING_BAR_END))
		}
		private function initUI():void 
		{
			_downButton.disabled = _upButton.disabled = _dragBarButton.disabled = true;
		}
		protected function reDraw():void 
		{
			_barBg.height = _maskHeight - _upButton.height * 2;
			
			_barBg.y = _upButton.y+_upButton.height;
			
			_downButton.y = _barBg.y + _barBg.height;
			
			_dragBarButton.y =  _upButton.height + _upButton.y;
			
			
			//设置滚动条的高度;
			if (_target)
			{
				
				if (_target.height == 0)
				{
					_target.addEventListener(Event.RENDER, __targetRENDER)
					return;
				}
				var per1:Number = _maskHeight / _target.height;
				trace( "per1 : " + per1 );
				if (per1 >= 1)
				{
					per1 = 1;
					
				}
				//trace( "_target.height : " + _target.height );
				//trace( "_maskHeight : " + _maskHeight );
				
				if (!_oldDargBarHeight)
				{
					
					_oldDargBarHeight=_dragBarButton.height
				}
				//trace( "_oldDargBarHeight : " + _oldDargBarHeight );
				var scbarHeight:Number = _barBg.height ;
				
				scbarHeight = per1 * scbarHeight;
				
	
				_dragBarButton.height = scbarHeight;
		
				if (per1 >= 1)
				{
					per1 = 1;
					_dragBarButton.visible = false;
					disable()
				}else
				{
					_dragBarButton.visible = true;
					enabled()
				}
				
				
			}
			
			
			
		}
		
		private function __targetRENDER(e:Event):void 
		{
			trace( "__targetRENDER : " + __targetRENDER );
			reDraw();
		}
		
		public function get maskHeight():Number 
		{
			return _maskHeight;
		}
		
		public function set maskHeight(value:Number):void 
		{
			_maskHeight = value;
			
			reDraw()
		}
		
		
		public function get maskWidth():Number 
		{
			return _maskWidth;
		}
		
		public function set maskWidth(value:Number):void 
		{
			_maskWidth = value;
			reDraw()
		}
		
		public function get target():DisplayObject 
		{
			return _target;
		}
		public function set target(value:DisplayObject):void 
		{
			_target = value;
			_targetOldy = _target.y;
			
			reDraw()
		}
		
		public function get upButton():ButtonComponent 
		{
			return _upButton;
		}
		
		public function set upButton(value:ButtonComponent):void 
		{
			_upButton = value;
		}
		
		public function get downButton():ButtonComponent 
		{
			return _downButton;
		}
		
		public function set downButton(value:ButtonComponent):void 
		{
			_downButton = value;
		}
		
		public function get dragBarPostionPercent():Number 
		{
			return _dragBarPostionPercent;
		}
		
		public function set dragBarPostionPercent(value:Number):void 
		{
			_dragBarPostionPercent = value;
			
			
			var bary:Number = (_barBg.y)+ (_barBg.height - _dragBarButton.height)*_dragBarPostionPercent;
			
			
			TweenLite.to(_dragBarButton, 0.2, {y: bary} );
			dragTarget(value)
			
		}
		private var _scrollDuration:Number=0.2;
		public function get scrollStep():Number 
		{
			return _scrollStep;
		}
		
		public function set scrollStep(value:Number):void 
		{
			_scrollStep = value;
		}
		
		public function get scrollDuration():Number 
		{
			return _scrollDuration;
		}
		
		public function set scrollDuration(value:Number):void 
		{
			_scrollDuration = value;
		}
	}

}