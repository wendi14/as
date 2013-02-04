package com.xmaser.bitmap 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author 
	 */
	public class ImageDecoder 
	{
		private static var _loader:Loader=new Loader();
		static private var _isLoading:Boolean;
		static private var list:Array=[];
		
		public function ImageDecoder(bys:ByteArray,callBack:Function,callParams:*) 
		{
			
			var l:Loader=new Loader()
			l.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
						
			l.loadBytes(bys);
						
				
			function onComplete(e:*):*
			{
				//trace(getTimer()-tt)
				l.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
				callBack.call(null, e.target.content.bitmapData,callParams);
			}
		}
		public static function bytesToBitmapData(bys:ByteArray,callBack:Function,callParams:*):void
		{
			
			list.push({ "b":bys, "f":callBack,"p":callParams })
			if (_isLoading == true)
			{
				return;
			}
			
			load();
			
			
		}
		
		static private function load():void 
		{
			if (list.length == 0)
			{
				return;
			}_isLoading = true;
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			
			var bys:ByteArray = list[0].b;
			var callBack:Function = list[0].f;
			var callParams:* = list[0].p;
			_loader.loadBytes(bys);
			//var tt:Number=getTimer()
			function onComplete(e:*):*
			{
				//trace(getTimer()-tt)
				_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
				callBack.call(null, e.target.content.bitmapData,callParams);
				_isLoading = false;
				
				list.pop();
				load()
			}
		}
	}

}