package cn.hcxmflash.loader 
{
	import cn.hcxmflash.loader.URLAssetsQueueService;
	import cn.hcxmflash.net.queue.URLLoaderQueueVO;
	import cn.hcxmflash.net.queue.vo.URLAssetsVO;
	import cn.hcxmflash.utils.Singleton;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author ...
	 */
	public class URLAssetsManager extends Singleton 
	{
		private var _assetsService:URLAssetsQueueService;
		
		public function URLAssetsManager() 
		{
			_assetsService=new URLAssetsQueueService()
		}
		public static function getIns():URLAssetsManager
		{
			return Singleton.getIns(URLAssetsManager);
			
		}
		public function load(url:String,callBack:Function,isTrust:Boolean=true,allowCrossDomain:Boolean=true):URLAssetsVO
		{
			var que:URLAssetsVO = new URLAssetsVO()
			que.isTrust = isTrust;
			que.allowCrossDomain = allowCrossDomain;
			que.requ = new URLRequest(url);
			que.callBackFunction = callBack;
			_assetsService.add(que);
			return que;
		}
		
	}

}