package com.xmaser.net.vo 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author ...
	 */
	public class URLAssetsVO extends QueueVO 
	{
		public static const ASSETS_TYPE_PIC:String="assets_type_pic"
		static public const ASSETS_TYPE_SOUND:String = "assetsTypeSound";
		public var loader:Loader = new Loader();
		public var requ:URLRequest;
		public var isTrust:Boolean = true;
		public var type:String = ASSETS_TYPE_PIC;
		public var bitmapData:BitmapData;
		
		public var allowCrossDomain:Boolean = true;
		public var onProgress:Function;
		public function URLAssetsVO() 
		{
			
		}
		override public function destory():void 
		{
			super.destory();
			loader.unload();
			requ = null;
			loader = null
			type = '';
			 
		}
		
	}

}