package cn.hcxmflash.loader 
{
	import cn.hcxmflash.net.queue.interfaceClass.IQueueVO;
	import cn.hcxmflash.net.queue.QueueServiceBase;
	import cn.hcxmflash.net.queue.URLLoaderQueueService;
	import cn.hcxmflash.net.queue.vo.URLAssetsVO;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author ...
	 */
	public class URLAssetsQueueService extends QueueServiceBase
	{
		
		public function URLAssetsQueueService() 
		{
			
		}
		override protected function exectue(iqvo:IQueueVO):void 
		{
			URLAssetsVO(iqvo).loader.contentLoaderInfo.addEventListener(Event.COMPLETE, __COMPLETE);
			URLAssetsVO(iqvo).loader.load(URLAssetsVO(iqvo).requ);
			
		}
		
		private function __COMPLETE(e:Event):void 
		{
			handleComplete();
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
		override public function showReadyItem(iqvo:IQueueVO):void 
		{
			if (URLAssetsVO(iqvo).type == URLAssetsVO.ASSETS_TYPE_PIC&&URLAssetsVO(iqvo).allowCrossDomain==true)
			{
				URLAssetsVO(iqvo).data = Bitmap(URLAssetsVO(iqvo).loader.content).bitmapData;
				URLAssetsVO(iqvo).bitmap = new Bitmap(URLAssetsVO(iqvo).data, "auto", true);
			}
			super.showReadyItem(iqvo);
			
		}
		
		
	}

}