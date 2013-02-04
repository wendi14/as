package com.xmaser.net 
{


	import cn.hcxmflash.utils.Singleton;
	import com.xmaser.net.interfaceClass.IQueueVO;
	import com.xmaser.net.vo.URLAssetsVO;
	import com.xmaser.net.vo.URLLoaderQueueVO;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class URLAssetsManager extends Singleton
	{
		static public var checkCache:Boolean=true;
		private var _assetService:URLAssetsQueueService
		
		public function URLAssetsManager() 
		{
			_assetService = new URLAssetsQueueService()
			_assetService.needCheckCache = checkCache;
		}
		
		static public function getIns():URLAssetsManager 
		{
			return Singleton.getIns(URLAssetsManager)
		}
		
		public function load(url:String, callBackFunction:Function, allowCrossDomain:Boolean=true, isTrust:Boolean=true,type:String=URLAssetsVO.ASSETS_TYPE_PIC,onProgress:Function=null):URLAssetsVO 
		{
			var avo:URLAssetsVO = new URLAssetsVO();
			avo.allowCrossDomain = allowCrossDomain;
			avo.callBackFunction = callBackFunction;
			avo.isTrust = isTrust;
			avo.type = type;
			avo.requ = new URLRequest(url);
			 avo.onProgress = onProgress;
			_assetService.add(avo);
			return avo;
		}
		
		public function getCacheVO(url:String ) :IQueueVO
		{
			return _assetService.getCacheVO(url);
		}
		public function remove(p:IQueueVO):void
		{
			_assetService.remove(p);
		}
		public function unload(picURL:String):void 
		{
			var uvo:URLAssetsVO = _assetService.getAssetVO(picURL);
			if (uvo) 
			{
				_assetService.unload(uvo);
			}
		}
		
		
		
	}

}