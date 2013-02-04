package com.xmaser.net 
{
	
	
	import com.xmaser.net.interfaceClass.IQueueVO;
	import com.xmaser.net.vo.URLLoaderQueueVO;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;

	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class URLLoaderQueueService extends QueueServiceBase
	{
		private var _urlLoader:URLLoader;
		
		public function URLLoaderQueueService() 
		{
			_urlLoader = new URLLoader()
			_urlLoader.addEventListener(Event.COMPLETE, __COMPLETE);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, __IO_ERROR);
		}
		
		
		
		private function __COMPLETE(e:Event):void 
		{
		
			var iqvo:IQueueVO = _queueList[0];
			iqvo.data = e.target.data;
			handleComplete()
			
		}
		
		private function __IO_ERROR(e:IOErrorEvent):void 
		{
			handleError();
		}
		override protected function exectue(iqvo:IQueueVO):void 
		{
			
			
			_urlLoader.load(URLLoaderQueueVO(iqvo).requ);
			
			
		}
		override public function showReadyItem(iqvo:IQueueVO):void 
		{
			//trace( "iqvo : " + (URLLoaderQueueVO(iqvo).requ.url) );
			if (iqvo.callBackFunction != null)
			{
				iqvo.callBackFunction.apply(null, [iqvo]);
				iqvo.data = null;
				iqvo.destory();
			}
			
			
		}
		
	}

}