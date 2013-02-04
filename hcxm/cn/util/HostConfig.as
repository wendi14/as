package hcxm.cn.util {
	import flash.events.Event;
	import hcxm.cn.net.XML_w;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import hcxm.cn.util.NewEvent;
	
	
	/**
	* ...
	* @author Default
	*/
	public class HostConfig extends EventDispatcher {
		public var loader:URLLoader;
		public var URL:String;//http://localhost/SearchPic.php
		public var arr:Array		;
		var xml:XML 
		public function HostConfig() {
			this.URL = "HostConfig.xml";
			arr = []
			xml = new XML();
			var url:URLRequest = new URLRequest(URL);
			var myloader:URLLoader = new URLLoader(url);
			
			myloader.addEventListener (Event.COMPLETE, COMPLETE);
		}

		private function COMPLETE (e:Event):void {
			
			xml = XML(e.target.data);
			var url = xml..host_url;
			arr.push(url)
			dispatchEvent (new NewEvent (Event.COMPLETE, true,arr));
			
		}
	
	}
	
}
