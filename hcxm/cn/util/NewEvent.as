package hcxm.cn.util {
	import flash.events.Event;
	
	/**
	* ...
	* @author Default
	*/
	public class NewEvent extends Event {
		public var arr:Array
		public function NewEvent(type:String, bubbles:Boolean,arr:Array) { 
			super (type,bubbles);
			this.arr = arr;
			
		} 
		
		public override function clone():Event { 
			return new NewEvent(type, bubbles,arr);
		} 
		
		public override function toString():String { 
			return formatToString("NewEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}
