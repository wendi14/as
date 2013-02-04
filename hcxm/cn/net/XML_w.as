package hcxm.cn.net {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import hcxm.cn.util.ArrEvent;
	
	/**
	* ...
	* @author Default
	* 使用方法：
	* var xm=new XML_w(url).
	* xml.parse("xml","name")
	* 这样就可以得到xml节点下name节点的值。
	*/

	public class XML_w extends EventDispatcher {
		public var loader:URLLoader;
		public var URL:String;//http://localhost/SearchPic.php
		public var arr:Array
		private var arg:Array
		public function XML_w(url:String) {
			this.URL = url;
					
		}		
		private function COMPLETE (e:Event):void {
			var lo:URLLoader = e.target as URLLoader;
			var xml:XML = new XML (lo.data)
		
			var k = 0;
			var s:String = "";
			var xmla = xml;
			for (var i:int = 0; i < arg.length; i++) {
				 s += arg[i];
				xmla = xmla[arg[i]]
				//trace(xmla)				
			}
			//trace(xml["dataset"]["data"])
			
			for each (var myxml:XML in xmla) {
				//trace ( "myxml : " + myxml.children ()[0].text());
				arr[k]=[]
				for (var j:int = 0; j < myxml.children().length(); j++) {
					arr[k].push (myxml.children ()[j]);
					//trace( "arr[k] : " + arr[k] );
				}
				//arr.push (arr[k]);
				k++;				
			}
			//trace(arr.length)
			dispatchEvent (new ArrEvent (Event.COMPLETE, true,arr));
			
		}
		public function parse (...args):void {
			arr = [];
			loader = new URLLoader ();
			loader.load (new URLRequest (URL));
			loader.addEventListener (Event.COMPLETE, COMPLETE);
			arg=[]
			for (var i = 0; i < args.length; i++) {
				arg.push (args[i]);
			}		
		}		
	}	
}
