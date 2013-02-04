package com.xmaser.net 
{
	

	import com.xmaser.net.interfaceClass.IQueueVO;
	import com.xmaser.net.vo.URLAssetsVO;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author ...
	 */
	public class URLAssetsQueueService extends QueueServiceBase
	{
		private var _nowIqvo:URLAssetsVO;
		
		public function URLAssetsQueueService() 
		{
			
		}
		override protected function exectue(iqvo:IQueueVO):void 
		{
			if (!URLAssetsVO(iqvo).loader) 
			{
				handleError();
				return;
			}
			URLAssetsVO(iqvo).loader.contentLoaderInfo.addEventListener(Event.COMPLETE, __COMPLETE);
			URLAssetsVO(iqvo).loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, __IO_ERROR);URLAssetsVO(iqvo).loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, __PROGRESS);
			URLAssetsVO(iqvo).loader.load(URLAssetsVO(iqvo).requ);
			iqvo.isProcessing = true;
			_nowIqvo=URLAssetsVO(iqvo)
		}
		
		private function __PROGRESS(e:ProgressEvent):void 
		{
			if(_nowIqvo.onProgress!=null)_nowIqvo.onProgress.call(null, e.bytesLoaded, e.bytesTotal);
		}
		
		private function __IO_ERROR(e:IOErrorEvent):void 
		{
			trace("e: " + e);
			
			handleError();
		}
		
		private function __COMPLETE(e:Event):void 
		{
			handleComplete();
		}
		override protected function handleErrorEvent(iqvo:IQueueVO):void 
		{
			trace( "handleErrorEvent : "  +URLAssetsVO(iqvo).requ.url);
			showReadyItem(iqvo);
			//showErrorItem(iqvo);
		}
		override protected function checkCache(iqvo:IQueueVO):IQueueVO 
		{
			
			
			//trace("_list.length: " + _list.length);
			for (var i:int = 0; i <_list.length; i++) 
			{
				
				
				var item:URLAssetsVO = _list[i];
				//trace("item.requ.url: " + item.requ.url, "2:"+URLAssetsVO(iqvo).requ.url);
				if (item.requ.url == URLAssetsVO(iqvo).requ.url)
				{
					
					if (item.allowCrossDomain == false) return null;
					
					
					
					
					return item;;
				}
				
			}
			return null;
		}
		override public function showReadyItemFromSame(iqvo:IQueueVO, same:IQueueVO):void 
		{
			if (URLAssetsVO(iqvo).type == URLAssetsVO.ASSETS_TYPE_PIC&&URLAssetsVO(iqvo).allowCrossDomain==true)
			{
				URLAssetsVO(iqvo).data = Bitmap(URLAssetsVO(same).loader.content).bitmapData;
			}
			URLAssetsVO(iqvo).loader = URLAssetsVO(same).loader;
			//same.callBackFunction = iqvo.callBackFunction;
			showReadyItem(iqvo);
		}
		override public function showReadyItem(iqvo:IQueueVO):void 
		{
			if (URLAssetsVO(iqvo).requ.url=="assets/images2/Backgrounds/FRIGISTAN_bg2_.png") 
			{
				trace("x");
			}
			if (URLAssetsVO(iqvo).type == URLAssetsVO.ASSETS_TYPE_PIC&&URLAssetsVO(iqvo).allowCrossDomain==true)
			{
				var bd:BitmapData
				
				if (URLAssetsVO(iqvo).loader.content)
				{
					bd = Bitmap(URLAssetsVO(iqvo).loader.content).bitmapData.clone();
				}
				
				//if (bd)
				//{
					//
					URLAssetsVO(iqvo).bitmapData = bd;
				//}
			}
			
			super.showReadyItem(iqvo);
		}
		
		public function unload(uvo:URLAssetsVO):void 
		{
			try 
			{
				uvo.loader.close()
			}catch (err:Error)
			{
				
			}
			if (uvo.isProcessing) 
			{
				trace( "uvo.isProcessing : " + uvo.isProcessing );
				if(_isLoading==true)_isLoading = false;
			}
		}
		public function getCacheVO(url:String):IQueueVO
		{
			 
			for (var i:int = 0; i <_list.length; i++) 
			{
				
				
				var item:URLAssetsVO = _list[i];
				//trace("item.requ.url: " + item.requ.url, "2:"+URLAssetsVO(iqvo).requ.url);
				if (item.requ.url ==  url)
				{
					
					if (item.allowCrossDomain == false) return null;
 
					return item;;
				}
				
			}
			return null;
		}
		public function getAssetVO(picURL:String):URLAssetsVO 
		{
			for (var i:int = 0; i < _queueList.length; i++) 
			{
				var item:URLAssetsVO = _queueList[i];
				if (item&&item.requ&&item.requ.url==picURL) 
				{
					_queueList.splice(i, 1);
					return item;
				}
			}
			
			return null;
		}
		
		
	}

}