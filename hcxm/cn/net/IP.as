package hcxm.cn.net
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import hcxm.cn.net.vo.IpVO;
	import hcxm.cn.string.StringW;
	
	public class IP extends EventDispatcher
	{
		public static const  URL:String="http://www.youdao.com/smartresult-xml/search.s?type=ip&q="
		private var _loader:URLLoader
		public var data:IpVO;
		private var ip:String;
		public function IP()
		{		
			
			_loader=new URLLoader(new URLRequest("http://www.hcxmflash.cn/ip.php"));
			_loader.addEventListener(Event.COMPLETE,_COMPLETE);
		}	
		private function _COMPLETE(e:Event):void
		{
			var da:*=XML(_loader.data);
			
			var ip:String=da.product.ip
			var lo:String=da.product.location;
			lo=hcxm.cn.string.StringW.EncodeUtf8(lo);
			var reg:RegExp=/\s/;
			var o:Object=reg.exec(lo);
			var ty:String=lo.substr(o.index+1);
			lo=lo.substr(0,o.index);
			var ipvo:IpVO=new IpVO(ip,lo,ty);
			this.data=ipvo;
			dispatchEvent(new Event(Event.COMPLETE));
			
			this._loader.removeEventListener(Event.COMPLETE,_COMPLETE);
			this._loader=null;
		}
	}
}