package com.xmaser.map45.resource 
{
	import com.xmaser.net.QueueLoaderSimpleBasic;
	import flash.events.Event;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.Endian;
	
	/**
	 * ...
	 * @author 
	 */
	public class ModLoader extends QueueLoaderSimpleBasic 
	{
		private var _urlLoader:URLLoader
		public function ModLoader() 
		{
			_urlLoader = new URLLoader()
			_urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			_urlLoader.addEventListener(Event.COMPLETE, _onComplete)
			//_uRLStream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, __se_);
			
		}
		
		private function __se_(e:Event):void 
		{
			
		}
		override protected function execute():void 
		{
			var re:URLRequest = new URLRequest( list[0].b);
			_urlLoader.load(re);
			
			
		}
		override protected function onComplete(da:*):void 
		{
			var callBack:Function = list[0].f;
			var callParams:* = list[0].p;
			if (callBack == null) return;
			callBack.call(null, _urlLoader.data,callParams)
		}
	}

}