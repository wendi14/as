package hcxm.air.app
{
	import air.update.ApplicationUpdaterUI;
	import air.update.events.StatusUpdateEvent;
	import air.update.events.UpdateEvent;
	
	import flash.filesystem.File;
	
	import hcxm.cn.debug.Debug;
	
	public class UpdateApp
	{
		private var appUpdater:ApplicationUpdaterUI;
		public function UpdateApp()
		{
			appUpdater=new ApplicationUpdaterUI()
			appUpdater.configurationFile=new File("app:/updateConfig.xml");
			appUpdater.addEventListener(UpdateEvent.CHECK_FOR_UPDATE,_CHECK_FOR_UPDATE)
			appUpdater.addEventListener(UpdateEvent.INITIALIZED,_INITIALIZED);
			appUpdater.addEventListener(StatusUpdateEvent.UPDATE_STATUS,_UPDATE_STATUS)
			appUpdater.initialize();
		}
		private function _INITIALIZED(e:UpdateEvent):void
		{
			
			Debug.trace_(e)
			appUpdater.checkNow();
			
		}
		private function _CHECK_FOR_UPDATE(e:UpdateEvent):void
		{
			Debug.trace_(e)
		}
		private function _UPDATE_STATUS(e:StatusUpdateEvent):void
		{
			Debug.trace_(e)
		}

	}
}