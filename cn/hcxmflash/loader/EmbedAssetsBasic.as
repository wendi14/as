package  cn.hcxmflash.loader
{
	import cn.hcxmflash.net.queue.URLLoaderQueueVO;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author 
	 */
	public class EmbedAssetsBasic extends EventDispatcher
	{
		[Event(name = "complete", type = "flash.events.Event")]
		
		public function EmbedAssetsBasic(uiArr:Array) 
		{
			var es:EmbedAssetsQueueService = new EmbedAssetsQueueService()
			es.isAuto = false;
			es.addEventListener(Event.COMPLETE, __COMPLETE);
			for (var i:int = 0; i < uiArr.length; i++) 
			{
				var itemC:* = uiArr[i];
				var item:*= new itemC();
				var itemv:URLLoaderQueueVO = new URLLoaderQueueVO()
				itemv.data = item;
				es.add(itemv);
			}
			es.start()
		}
		
		private function __COMPLETE(e:Event):void 
		{
			dispatchEvent(new Event(Event.COMPLETE))
		}
		
	}

}