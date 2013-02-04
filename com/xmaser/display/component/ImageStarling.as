package com.xmaser.display.component 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLRequest;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class ImageStarling extends Sprite 
	{
		private var _loader:Loader;
		
		public function ImageStarling() 
		{
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete);
		}
		
		
		public function load(url:String):void
		{
			_loader.load(new URLRequest(url));
			
		}
		
		private function onLoaderComplete(e:Event):void 
		{
			var loadInfo:LoaderInfo = e.currentTarget as LoaderInfo;
			var t:Texture = Texture.fromBitmap(loadInfo.content as Bitmap);
			var img:Image = new Image(t);
			addChild(img);
			img.scaleX = img.scaleY = 0.5;
			
		}
		
	}

}