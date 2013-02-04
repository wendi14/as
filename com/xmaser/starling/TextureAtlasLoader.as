package com.xmaser.starling 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import starling.events.EventDispatcher;
	 
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class TextureAtlasLoader extends EventDispatcher
	{
		static public const TEXTURE_LOAD_COMPLETE:String = "textureLoadComplete";
 
 
		private var picUrl:String;
		private var xmlUrl:String;
		private var _picData:BitmapData;
		private var _xmlData:XML;
		private var _bitmapData:BitmapData;
		
		public function TextureAtlasLoader(picUrl:String,xmlUrl:String) 
		{
			this.xmlUrl = xmlUrl;
			this.picUrl = picUrl;
			//this.addEventListener(Event.COMPLETE, onComplete);
			
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener('complete', onPicComplete);
			loader.load(new URLRequest(this.picUrl));
			
			var urlloader:URLLoader = new URLLoader();
			urlloader.addEventListener('complete', onXmlComplete);
			urlloader.load(new URLRequest(xmlUrl));
		}
		
		private function onXmlComplete(e:*):void 
		{
			_xmlData = new XML(e.currentTarget.data);
			onComplete()
		}
		
		private function onPicComplete(e:*):void 
		{
			if (!this.picData)
			{
				this._picData = Bitmap(LoaderInfo(e.currentTarget).content).bitmapData;
			}
			onComplete()
		}
		
		private function onComplete():void 
		{
			 
			 if (this.picData&&this.xmlData) 
			{
				dispatchEventWith(TEXTURE_LOAD_COMPLETE)
				 
			}
			 
		}
		
		public function get picData():BitmapData 
		{
			return _picData;
		}
		
		public function get xmlData():XML 
		{
			return _xmlData;
		}
		
 
		
	}

}