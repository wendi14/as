package com.xmaser.display.progress 
{
	import com.xmaser.display.component.ComponentBasic;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class ProgressBasic extends ComponentBasic 
	{
		private var _timer:Timer;
		
		public function ProgressBasic() 
		{
			_timer = new Timer(1000, count);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, __TIMER_COMPLETE)
			_timer.addEventListener(TimerEvent.TIMER, __TIMER);
			_timer.start();
		}
		public function reStart():void
		{
			_timer.stop();
			_timer.reset();
			_timer.start();
		}
		public function stop():void
		{
			_timer.stop();
		}
		public function pause():void
		{
			_timer.stop();
		}
		public function resume():void
		{
			_timer.start();
		}
		
		public function destory():void 
		{
			if (_timer)
			{
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER, __TIMER);
				_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, __TIMER_COMPLETE);
				_textFiled = null;
			}
			_timer = null;
		}
		protected function __TIMER_COMPLETE(e:TimerEvent):void 
		{
			
		}
		
		protected function __TIMER(e:TimerEvent):void 
		{
			
		}
	}

}