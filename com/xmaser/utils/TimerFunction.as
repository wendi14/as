package com.xmaser.utils 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * 功能说明
	 * 重复要调用的函数只执行一次
	 * 
	 * 可以参考com.xmaser.game.puzzles.Puzzle ;
	 * ...
	 * @author wdc
	 */
	public class TimerFunction extends Timer 
	{
		private var _func:Function;
		
		/**
		 * 
		 * @param	delay	多少毫秒后调用函数
		 * @param	func		要被执行的函数;
		 */
		public function TimerFunction(delay:int,func:Function) 
		{
			super(delay, 1);
			this._func = func;
			start();
			addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
		}
		override public function start():void 
		{
			super.start();
		}
		private function onTimerComplete(e:TimerEvent):void 
		{
			this._func.call();
		}
		public function rePlay():void
		{
			this.stop();
			this.reset();
			this.start();
		}
		
	}

}