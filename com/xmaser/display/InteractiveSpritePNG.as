package com.xmaser.display 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * 在Sprite或者MovieClip中有透明的东西
	 * 让鼠标不响应透明的部分;
	 * ...
	 * @author wdc
	 */
	public class InteractiveSpritePNG extends Sprite 
	{
		private var _transparentMode:Boolean;
		private var _bitmapForHitDetection:Bitmap;
		protected var _threshold : uint = 255;
		
		protected var _mousePoint : Point;
		public function InteractiveSpritePNG() 
		{
			
		}
		override public function get hitArea():flash.display.Sprite 
		{
			return super.hitArea;
		}
		
		override public function set hitArea(value:flash.display.Sprite):void 
		{
			super.hitArea = value;
			
			
		}
		
		public function enableInteractivePNG():void 
		{
			disableInteractivePNG();
			
			if (hitArea!=null)
				return;
			activateMouseTrap();
			//_interactivePngActive = true;
			
		}
		public function disableInteractivePNG(): void {
			deactivateMouseTrap();
			removeEventListener(Event.ENTER_FRAME, trackMouseWhileInBounds);
			
		}
		
		
		protected function activateMouseTrap() : void {
			addEventListener(MouseEvent.ROLL_OVER, captureMouseEvent, false, 10000, true); //useCapture=true, priority=high, weakRef=true
			addEventListener(MouseEvent.MOUSE_OVER, captureMouseEvent, false, 10000, true);
			addEventListener(MouseEvent.ROLL_OUT, captureMouseEvent, false, 10000, true);  
			addEventListener(MouseEvent.MOUSE_OUT, captureMouseEvent, false, 10000, true);
			addEventListener(MouseEvent.MOUSE_MOVE, captureMouseEvent, false, 10000, true);
		}
		
		/**
		 * @private
		 * Turns off listening for mouse events on this MovieClip.
		 */
		protected function deactivateMouseTrap() : void {
			removeEventListener(MouseEvent.ROLL_OVER, captureMouseEvent);
			removeEventListener(MouseEvent.MOUSE_OVER, captureMouseEvent);
			removeEventListener(MouseEvent.ROLL_OUT, captureMouseEvent);  
			removeEventListener(MouseEvent.MOUSE_OUT, captureMouseEvent);
			removeEventListener(MouseEvent.MOUSE_MOVE, captureMouseEvent);
		}

		protected function captureMouseEvent(event : Event) : void 
		{
			if (!_transparentMode) {
				
				
				if (event.type==MouseEvent.MOUSE_OVER || event.type==MouseEvent.ROLL_OVER) {
					
					setButtonModeCache();
					
					addEventListener(Event.ENTER_FRAME, trackMouseWhileInBounds, false, 10000, true); 
					trackMouseWhileInBounds(); 
				}
			}
			//event.stopImmediatePropagation();
			
		}
		private function trackMouseWhileInBounds(event:Event=null):void 
		{
			//trace( "trackMouseWhileInBounds : " + trackMouseWhileInBounds );
			if (bitmapHitTest())
			{
				//trace('碰到像素');
				this.mouseEnabled = true;
			}else 
			{
				this.mouseEnabled = false;
			}
			
			var localMouse:Point = _bitmapForHitDetection.localToGlobal(_mousePoint);
			if (this.hitTestPoint(localMouse.x, localMouse.y) == false)
			{
				this.removeEventListener(Event.ENTER_FRAME, trackMouseWhileInBounds);
				super.mouseEnabled = true;
			}
			
		}
		private function bitmapHitTest():Boolean
		{
			if (_bitmapForHitDetection==null) 
			{
				drawBitmapHitArea();
			}	
			var mousePo:Point = new Point(_bitmapForHitDetection.mouseX, _bitmapForHitDetection.mouseY);
			_mousePoint = mousePo;
			return _bitmapForHitDetection.bitmapData.hitTest(new Point(),_threshold,mousePo);
		}
		
		protected function drawBitmapHitArea():void 
		{
			
			//this.filters = []; this.alpha = 1;
			var bounds:Rectangle = getBounds(this);
			var left:Number = bounds.left;
			var top:Number = bounds.top;
			var bd:BitmapData = new BitmapData(bounds.width, bounds.height, true, 0);
			var ma:Matrix = new Matrix();
			ma.translate( -left, -top);
			bd.draw(this, ma);
			_bitmapForHitDetection = new Bitmap(bd,"auto",true);
			this.removeChildAt(0);
			addChild(_bitmapForHitDetection);
			_bitmapForHitDetection.x = left;
			_bitmapForHitDetection.y = top;
		}
		
		private function setButtonModeCache():void 
		{
			
		}
		public function get threshold():uint 
		{
			return _threshold;
		}
		
		public function set threshold(value:uint):void 
		{
			_threshold = value;
		}
		
	}

}