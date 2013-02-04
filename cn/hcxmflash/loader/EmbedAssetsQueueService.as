package  cn.hcxmflash.loader
{
	import cn.hcxmflash.net.queue.interfaceClass.IQueueVO;
	import cn.hcxmflash.net.queue.QueueServiceBase;
	import cn.hcxmflash.net.queue.URLLoaderQueueService;
	import cn.hcxmflash.net.queue.URLLoaderQueueVO;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	/**
	 * ...
	 * @author 
	 */
	public class EmbedAssetsQueueService extends QueueServiceBase 
	{
		private var _loader:Loader;
		public function EmbedAssetsQueueService() 
		{
			_loader = new Loader()
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, __COMPLETE);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, __IO_ERROR);
		}
		
		private function __COMPLETE(e:Event):void 
		{
		
			var iqvo:IQueueVO = _queueList[0];
			iqvo.data = LoaderInfo(e.target).bytes;
			handleComplete()
			
		}
		
		private function __IO_ERROR(e:IOErrorEvent):void 
		{
			handleError();
		}
		override protected function exectue(iqvo:IQueueVO):void 
		{
			
			var cont:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			/*cont.allowCodeImport = true;*/ //air
			_loader.loadBytes(URLLoaderQueueVO(iqvo).data,cont);
			
			
		}
		override public function showReadyItem(iqvo:IQueueVO):void 
		{
			//trace( "iqvo : " + (URLLoaderQueueVO(iqvo).requ.url) );
			if (iqvo.callBackFunction != null)
			{
				iqvo.callBackFunction.apply(null, [iqvo]);
			}
			
			
		}
		
	}

}