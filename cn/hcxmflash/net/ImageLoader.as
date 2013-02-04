package cn.hcxmflash.net 
{
	import cn.hcxmflash.event.Event_;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import gs.TweenLite;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	[Event(name = "loaderComplete", type = "cn.hcxmflash.event.Event_")]
	
	
	public class ImageLoader extends Loader
	{
		
		private var _width_img:Number;
		private var _height_img:Number;
		/**
		 * 相对居中的对像
		 */
		private var _centerParent:DisplayObject;
		private var _centerRec:Rectangle;
		private var _bitmapdata:BitmapData;
		
		private var _isLoaded:Boolean = false;
		
		public function ImageLoader() 
		{
			this.alpha = 0;
			contentLoaderInfo.addEventListener(Event.COMPLETE, __contentLoaderInfoCOMPLETE,false,0,true);
		}
		/**
		 * 居中
		 * @param	par　以par 为基准，居中于par;
		 */
		public function setCenter(par:DisplayObject,rec:Rectangle=null):void
		{
			
			if (par) 
			{
				this.x = par.width / 2 - this.width / 2;
				this.y = par.height / 2 - this.height / 2;
			}
			if (rec) 
			{
				this.x = rec.x+rec.width/2 - this.width / 2;
				this.y = rec.y+rec.height / 2 - this.height / 2
			}
			
			
		}
		private function __contentLoaderInfoCOMPLETE(e:Event):void 
		{
			_isLoaded = true;
			//contentLoaderInfo.removeEventListener(Event.COMPLETE, __contentLoaderInfoCOMPLETE);
			//var bit:Bitmap = this.content as Bitmap;
		//	bit.smoothing = true;
			//_bitmapdata = bit.bitmapData;
			if (_width_img) 
			{
				width = _width_img;
			}
			if (_height_img) 
			{
				height = _height_img;
			}
			if (_centerParent) 
			{
				setCenter(_centerParent);
			}
			if (_centerRec) 
			{
				setCenter(null, _centerRec);
			}
			dispatchEvent(new Event_(Event_.LOADER_COMPLETE))
			TweenLite.to(this, 0.3, { alpha:1 } );
		}
		public function destory():void
		{
			contentLoaderInfo.removeEventListener(Event.COMPLETE, __contentLoaderInfoCOMPLETE);
		}
		public function set centerParent(value:DisplayObject):void 
		{
			_centerParent = value;
		}
		public function set width_img(value:Number):void 
		{
			_width_img = value;
		}
		public function set centerRec(value:Rectangle):void 
		{
			_centerRec = value
			setCenter(null, _centerRec);
		}
		public function get width_img():Number { return _width_img; }
		
		public function set height_img(value:Number):void 
		{
			_height_img=value
		}
		public function get height_img():Number { return _height_img; }
		public function get bitmapdata() :BitmapData{ return _bitmapdata; }
		
		public function get isLoaded():Boolean 
		{
			return _isLoaded;
		}
		
		public function set isLoaded(value:Boolean):void 
		{
			_isLoaded = value;
		}
	}

}