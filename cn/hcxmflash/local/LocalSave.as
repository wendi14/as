package cn.hcxmflash.local 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	/**
	 * ...
	 * @author 小火柴
	 */
	
	 
	 [Event(name="saveSuccess", type="flash.events.Event")] 
	public class LocalSave extends EventDispatcher
	{
		public static const SAVE_SUCCESS = "saveSuccess";
		private var _shareObject:SharedObject;
		private var _limitSpace;
		private var _saveName;
		
		/**
		 * 
		 * @param	saveName
		 * @param	limitSpace  1M
		 */
		public function LocalSave(saveName:String="saveName",limitSpace:Number=1024*1024) 
		{
			_saveName=saveName
			_shareObject = SharedObject.getLocal(saveName);
			_limitSpace=limitSpace
		}
		public function save(data:*):void
		{
			_shareObject.data[_saveName] = data;
			var res:String=_shareObject.flush(_limitSpace)
			if (res==SharedObjectFlushStatus.PENDING) 
			{
				trace("space not enough!");
			}else if (res == SharedObjectFlushStatus.FLUSHED);
			{
				trace("save success!");
				dispatchEvent(new Event(SAVE_SUCCESS));
			}
		}
		public function get data():Object { return _shareObject.data[_saveName]; }
		
	}

}