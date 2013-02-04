package com.xmaser.display.component.butotn 
{
	import Box2D.Dynamics.Contacts.b2NullContact;
	import com.xmaser.display.component.ImageLoader;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class IconButtonComponent extends ButtonComponent 
	{
		
		protected var _icon:*;
		protected var _iconHGap:int=2;
		protected var _iconVGap:int=0;
		public function IconButtonComponent() 
		{
			
		}
		
		public function get icon():* 
		{
			return _icon;
		}
		
		public function set icon(value:*):void 
		{
			
			if (value is Class)
			{
				_icon = new value();
			}else if (value is BitmapData )
			{
				_icon = new Bitmap(value, "auto", true);
			}
			else if (value is String) 
			{
				_icon = new ImageLoader();
				ImageLoader(_icon).addEventListener(Event.COMPLETE,__iconCOMPLETE)
				ImageLoader(_icon).load(value);
			}else if (value is Shape)
			{
				_icon = value;
			}
			if (_icon is DisplayObjectContainer)
			{
				_icon.mouseChildren = _icon.mouseEnabled = false;
				_icon.cacheAsBitmap = true;
			}
			if (_icon)
			{
				addChild(_icon);
				
				align();
			}
			
			
		}
		
		private function __iconCOMPLETE(e:Event):void 
		{
			align();
			
		}
		override protected function resizeHoldSkinSp():void 
		{
			super.resizeHoldSkinSp();
			if (!_holdSkinSp||!_icon) return;
			var th:Number;
			var tw:Number;
			if (_txt)
			{
				th = _txt.height
				tw = _txt.width;
			}else 
			{
				th = 0;
				tw = 0;
			}
			
			_holdSkinSp.width = _lrGap * 2 + tw + _icon.width + _iconHGap;
			var maxH:Number = Math.max(th, _icon.height);
			
			if (_autoSize)
			{
				_holdSkinSp.height = _tbGap * 2 + maxH + _iconVGap;
			}
			//trace( "_holdSkinSp.height : " + _holdSkinSp.height );
		}
		override protected function alignText():void 
		{
			super.alignText();
			if (!_holdSkinSp||!_icon) return;

			_icon.x = _lrGap;
			_icon.y = _holdSkinSp.height / 2 - _icon.height / 2;
			
			
			
			
			if(_txt)_txt.x = _lrGap  + _icon.width + _iconHGap;
			
			
			
		}
		
	}

}