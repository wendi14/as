package cn.hcxmflash.utils
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import hcxm.cn.event.Event_;
	
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class Config extends EventDispatcher
	{
		/**
		 * 地址数组
		 */
		public var URLArr:Array
		public function Config() 
		{
			var urllo:URLLoader = new URLLoader(new URLRequest("config.xml"));
			urllo.addEventListener(Event.COMPLETE, __COMPLETE);
		}
		
		private function __COMPLETE(e:Event):void 
		{
			URLArr=[]
			var xml:XML = XML(e.target.data);
			var host = xml.host;
			
			for (var i:int = 0; i < host.length(); i++) 
			{
				URLArr.push(host[i])
			}
			
			dispatchEvent(new Event_(Event_.COMPLETE,host))
		}
		
		
	}

}