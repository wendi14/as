package  hcxm.cn.media.event 
{
	import flash.events.Event;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	
	public class FlvEvent  extends Event
	{
		public static  const PROGRE:String="progre"
		public var data:Object
		public function FlvEvent(type:String,bubbles:Boolean,obj:Object) 
		{
			super(type,bubbles);
			this.data = obj;
		}
		public override function clone():Event
		{
			return new FlvEvent(type,bubbles,data)
		}
		
	}
	
}