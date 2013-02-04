package com.xmaser.net 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	/**
	 * ...
	 * @author 
	 */
	public class URLLoaderSimple extends EventDispatcher 
	{
		protected var _callBackObject:Object;
		protected var _urlloader:URLLoader;
		protected var _callBackFunc:Function;
		protected var requ:URLRequest;
		
		public function URLLoaderSimple(url:String,param:URLVariables=null,callBackFunc:Function=null,callBackObject:Object=null) 
		{
			_callBackObject = callBackObject;
			_callBackFunc = callBackFunc;
		
			requ = new URLRequest();
			requ.url = url;
			requ.data = param;
			_urlloader = new URLLoader();
			_urlloader.addEventListener(IOErrorEvent.IO_ERROR, __IO_ERROR);
			_urlloader.addEventListener(Event.COMPLETE, __COMPLETE);
			//addEventListener(IOErrorEvent.IO_ERROR, __IO_ERROR);
		}
		public function set method(value:String):void 
		{
			requ.method = value;
		}
		protected function __COMPLETE(e:Event):void 
		{
			if (_callBackFunc != null)
			{
				_callBackFunc.call(null,e.target.data,_callBackObject);
			}
		}
		
		public function load():void
		{
			_urlloader.load(requ);
		}
		
		private function __IO_ERROR(e:IOErrorEvent):void 
		{
			load();
		}
		
	}

}