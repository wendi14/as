package hcxm.cn.event {
	import flash.events.Event;
	
	/**
	* ...带一个参数
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class Event_ extends Event {
		public static const COMPLETE:String="complete";
		public static const PROGRESS:String="progress";
		public static const CLICK:String = "clickthis";
		public var data:*;
		public function Event_(type:String, object:*=null,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = object;
		}
		override public  function clone():Event{
			return new Event_(this.type,this.data,this.bubbles,this.cancelable);
		}
	}
	
}