package com.xmaser.display.container.image 
{
	import com.greensock.TweenLite;
	import com.xmaser.display.component.butotn.ButtonComponent;
	import com.xmaser.view.ViewBasic;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author 厦门火柴 www.xmaser.com|www.hcxmflash.cn
	 */
	public class VerticalImageThumbnailContainer extends ViewBasic 
	{
		private var _hold:Sprite;
		private var _maskHeight:Number=1;
		private var _maskWidth:Number=1;
		private var _maskShpae:Shape;
		private var _index:Number=0;
		private var _step:Number=50;
		private var _total:int;
		private var _nextButton:ButtonComponent;
		private var _prevButton:ButtonComponent;
		
		public function VerticalImageThumbnailContainer() 
		{
			super(asset_VerticalImageThumbnailContainer);
		}
		override protected function drawUI():void 
		{
			super.drawUI();
			_hold = new Sprite()
			addChild(_hold);
			_maskShpae = new Shape()
			addChild(_maskShpae);
			_hold.mask = _maskShpae;
		}
		override public function get height():Number 
		{
			return super.height;
		}
		
		override public function set height(value:Number):void 
		{
			_maskHeight = value;
			redrawMask()
			super.height = value;
		}
		override public function get width():Number 
		{
			return super.width;
		}
		
		override public function set width(value:Number):void 
		{
			_maskWidth = value;
			redrawMask()
			super.width = value;
		}
		
		private function redrawMask():void 
		{
			_maskShpae.graphics.clear()
			_maskShpae.graphics.beginFill(0)
			_maskShpae.graphics.drawRect(0, 0, _maskWidth, _maskHeight);
			_maskShpae.graphics.endFill();
		}
		public function set data(images:Array):void 
		{
			for (var i:int = 0; i < images.length; i++) 
			{
			
				var img:* = images[i];
				addChild(img);
			}
		}
		
		public function get step():Number 
		{
			return _step;
		}
		
		public function set step(value:Number):void 
		{
			_step = value;
		}
		public function set prevButton(value:ButtonComponent):void 
		{
			_prevButton = value;
			_prevButton.disabled = true;
			_prevButton.addEventListener(MouseEvent.CLICK, __prev);
			
			
		}
		public function set nextButton(value:ButtonComponent):void 
		{
			_nextButton = value;
			
			
			_nextButton.addEventListener(MouseEvent.CLICK, __next);
		}
		private function __prev(e:MouseEvent):void 
		{
			prev()
		}
		
		private function __next(e:MouseEvent):void 
		{
			next()
		}
		
		public function add(mc:*):void
		{
			_hold.addChild(mc);
			_total = Math.floor(_hold.height / _step);
			_total = -_total;
			//trace("_total: " + _total);
			 checkButton()
		}
		
		public function next():void 
		{
			_index--;
			if (_index <= _total)
			{
				_index = _total;
			}
			move()
		}
		
		private function move():void 
		{
			var yy:Number = 0;
			yy = _index * _step;
			
			TweenLite.to(_hold, 0.4, { y:yy } )
			checkButton()
		}
		
		
		public function prev():void 
		{
			_index++;
			if (_index > 0)
			{
				
				_index = 0;
			}
			move()
		}
		private function checkButton():void 
		{
			_prevButton.disabled = _nextButton.disabled = false;
			if (_index == 0)
			{
				_prevButton.disabled = true;
			}
			if (_index<=_total) 
			{
				_nextButton.disabled = true;
			}
		}
	}

}