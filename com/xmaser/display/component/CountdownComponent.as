package com.xmaser.display.component 
{
	import com.xmaser.assets.asset_countdownBar;
	import com.xmaser.time.CountDown;
	import com.xmaser.view.ViewBasic;
	import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class CountdownComponent extends ComponentBasic 
	{
		private var _countDown:CountDown;
		protected var _percent:Number;
		protected var _diplayObject:DisplayObject;
		
		protected var _timer:Timer;
		protected var _count:Number;
		protected var _remainCount:int;
		public function CountdownComponent(count:Number,delay:Number=1000) 
		{
			createTimer(count, delay);
		}
		
		protected function createTimer(count:Number, delay:Number):void 
		{
			this._count = count;
			_timer = new Timer(delay, count * 1000 / delay);
			//trace( "count*1000/delay : " + count*1000/delay );
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
		override public function destory():void 
		{
			super.destory();
			if (_timer)
			{
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER, __TIMER);
				_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, __TIMER_COMPLETE);
				
			}
			_timer = null;
		}
		
		protected function __TIMER_COMPLETE(e:TimerEvent):void 
		{
			_percent = 1;
		}
		
		protected function __TIMER(e:TimerEvent):void 
		{
			_percent = this._timer.currentCount / (this._count * 1000 / _timer.delay) ;
			_remainCount = this._count*1000-this._timer.currentCount * _timer.delay;
			//trace( "_remainCount : " + _remainCount );
		}
		
		
		
		public function get diplayObject():DisplayObject 
		{
			return _diplayObject;
		}
		
		public function get percent():Number 
		{
			return _percent;
		}
		
	}

}