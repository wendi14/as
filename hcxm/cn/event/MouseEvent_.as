package hcxm.cn.event {
	import flash.events.Event;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class MouseEvent_ extends Event {
		public static const CLICK:String = "click";
		public var data:*;
		public function MouseEvent_(type:String, object:*=null,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = object;
			
		}
		override public  function clone():Event{
			return new MouseEvent_(this.type,this.data,this.bubbles,this.cancelable);
		}
		
	}
	
}
