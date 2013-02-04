package com.xmaser.net 
{
	import cn.hcxmflash.utils.Singleton;
	import com.xmaser.net.vo.URLLoaderQueueVO;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class URLLoaderManager extends Singleton 
	{
		private var _service:URLLoaderQueueService;
		
		public function URLLoaderManager() 
		{
			_service = new URLLoaderQueueService()
			
		}
		public static function getIns():URLLoaderManager
		{
			return Singleton.getIns(URLLoaderManager);
		}
		
		public function addService(url:String, callBackFunction:Function,callBackObject:*=null):URLLoaderQueueVO
		{
			var uvo:URLLoaderQueueVO = new URLLoaderQueueVO()
			uvo.requ = new URLRequest(url);
			uvo.callBackFunction = callBackFunction;
			uvo.callBackObject = callBackObject;
			_service.add(uvo);
			return uvo;
		}
		
	}

}