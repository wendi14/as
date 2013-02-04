package com.xmaser.display.component 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author 小火柴
	 */
	public class ImageLoader extends ComponentBasic implements IComponent 
	{
		private var _loader:Loader;
		private var _picWidth:Number;
		private var _picHeight:Number;
		private var _smooth:Boolean = false;
		public function ImageLoader() 
		{
			
			_loader = new Loader()
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,__COMPLETE)
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, __IO_ERROR)
			addChild(_loader);
			_loader.mouseChildren = _loader.mouseEnabled = false;
		}
		
		protected function __IO_ERROR(e:IOErrorEvent):void 
		{
			trace( "e : " + e );
			//throw new Error("找不到"+e.toString());
		}
		
		protected function __COMPLETE(e:Event):void 
		{
			//addChild(e.target.content);
			
			if (_picWidth) 
			{
				loader.width = _picWidth;
			}
			if (_picHeight) 
			{
				_loader.height = _picHeight;
			}
			if (_smooth) 
			{
				Bitmap(_loader.content).smoothing = true;
			}
			dispatchEvent(e);
		}
		public function load(url:String):void
		{
			var cont:LoaderContext = new LoaderContext(true);
			_loader.load(new URLRequest(url),cont);
		}
		public function loadBytes(bytes:ByteArray):void
		{
			var cont:LoaderContext = new LoaderContext(true);
			_loader.loadBytes(bytes);
		}
		override public function destory():void 
		{
			loader.unload();
			removeChild(loader);
		}
		public function getBitmapData():BitmapData
		{
			return Bitmap(_loader.content).bitmapData;
		}
		public function get loader():Loader 
		{
			return _loader;
		}
		
		public function get picHeight():Number 
		{
			return _picHeight;
		}
		
		public function set picHeight(value:Number):void 
		{
			_picHeight = value;
		}
		
		public function get picWidth():Number 
		{
			return _picWidth;
		}
		
		public function set picWidth(value:Number):void 
		{
			_picWidth = value;
		}
		
		public function get smooth():Boolean 
		{
			return _smooth;
		}
		
		public function set smooth(value:Boolean):void 
		{
			_smooth = value;
		}
		
		/* INTERFACE com.xmaser.display.component.IComponent */
		
		
	}

}