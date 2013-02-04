package com.xmaser.time 
{
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class CountDown extends EventDispatcher 
	{
		private var _timer:Timer;
		private var _textFiled:TextField;
		private var _count:Number;
		private var _onComplete:Function;
		/**
		 * 秒
		 * @param	count
		 */
		public function CountDown(count:Number,onComplete:Function,uiClass:Class=null,textFiled:TextField=null) 
		{
			this._count = count;
			_timer = new Timer(1000, count);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, __TIMER_COMPLETE)
			_timer.addEventListener(TimerEvent.TIMER, __TIMER);
			_timer.start();
			
			if (textFiled)
			{
				_textFiled = textFiled;
				_textFiled.text = String(this._count - this._timer.currentCount);
			}
			if (onComplete!=null)
			{
				this._onComplete = onComplete;
			}
			
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
		private function __TIMER_COMPLETE(e:TimerEvent):void 
		{
			if (this._onComplete!=null) 
			{
				this._onComplete();
			}
		}
		
		private function __TIMER(e:TimerEvent):void 
		{
			if (_textFiled)
			{
				_textFiled.text = String(this._count - this._timer.currentCount);
			}
		}
		
	}

}