package com.xmaser.net.vo 
{
	
	import cn.hcxmflash.vo.VoBasicFlash;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class URLLoaderQueueVO extends QueueVO
	{
		public var requ:URLRequest;
		public var callBackObject:*;
		public function URLLoaderQueueVO() 
		{
			
		}
		override public function destory():void 
		{
			super.destory();
			requ = null;
			callBackObject = null;
		}
		
	}

}