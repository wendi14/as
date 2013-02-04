package cn.hcxmflash.time 
{
	import cn.hcxmflash.event.Event_;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class DaoJiShi extends EventDispatcher
	{
		public static var  UPDATE:String = "update";
		private var _time;
		private var timer:Timer;
		
		/**
		 * 秒数
		 * @param	time
		 */
		public function DaoJiShi(time:Number) 
		{
			
			_time = time;
			timer = new Timer(1000, time);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, __TIMER_COMPLETE)
			timer.addEventListener(TimerEvent.TIMER, __TIMER);
			timer.start();
		}
		
		private function __TIMER(e:TimerEvent):void 
		{
			trace("e : " + e);
			dispatchEvent(new Event_(UPDATE,_time-timer.currentCount))
		}
		
		private function __TIMER_COMPLETE(e:TimerEvent):void 
		{
			dispatchEvent(new Event(Event.COMPLETE))
		}
		
	}

}