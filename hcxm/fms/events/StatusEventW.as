package hcxm.fms.events {
	import flash.events.Event;
	
	/**
	* ...
	* @编写者： wendi(小火柴)
						http://www.hcxm.cn
	*/
						
	public class StatusEventW extends Event {
		public static const FAIL:String = "fail";
		public static const OK:String = "ok";
		public static const REJECT:String = "reject";
		public var sta
		public function StatusEventW(type:String,bubbles:Boolean = false,cancelable:Boolean = false) {
			super(type);
			this.sta =0
		}
		override public function clone():Event {
			return new StatusEventW(type,bubbles,cancelable);
		}
		override public function toString():String {
			var su:String = "";
			if (sta==1) {
				su="1 '成功连接...'"
			}else if (sta==2) {
				su="2 '失败，请检查网络连接...'"
			}else if (sta==3) {
				su="3 '被服务器拒绝...'"
			}
			var str = "[Event type=" + type + " bubbles=" + bubbles + " cancelable" + cancelable + " sta=" + su+"]";
			return str
		}
	}
	
}