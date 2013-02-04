package cn.hcxmflash.utils 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import hcxm.cn.flashcn.CopyRight;
	/**
	 * 检查客户是否有付完款
	 * ...
	 * @author hcxmflash.cn
	 */
	public class CheckMoney extends EventDispatcher
	{
	
		private var target:DisplayObject;
		private var isWeb:Boolean;
		/**
		 * 构造
		 * @param	target 主场景，或者某个物件上面
		 * @param	url 对应的工程付款地址;
		 * @param	isWeb 是否应用于网络上;
		 */
		public function CheckMoney(target:DisplayObject,url:String,isWeb:Boolean=true) 
		{
			this.target = target;
			var urlloader:URLLoader = new URLLoader(new URLRequest(url));
			urlloader.addEventListener(Event.COMPLETE, __complete);
			isWeb=isWeb
			urlloader.addEventListener(IOErrorEvent.IO_ERROR, __ioerr);
		}
		
		private function __ioerr(e:IOErrorEvent):void 
		{
			if (!isWeb) 
			{
				new CopyRight(target);
			}
		}
		
		private function __complete(e:Event):void 
		{
			var str = e.target.data;
			if (str=='0') 
			{
				new CopyRight(target);
			}
		}
		
	}

}