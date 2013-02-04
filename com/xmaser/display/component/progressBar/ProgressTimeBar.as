package  com.xmaser.display.component.progressBar
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class ProgressTimeBar extends ProgressBarBasic 
	{
		private var _uiClass:Class;
		private var _mc:*;
		private var _bar:*;
		private var _timer:Timer;
		private var _delay:int=1000;
		private var _repeatCount:int=0;
		private var _totalTime:int = 0;
		public function ProgressTimeBar(uiClass:Class) 
		{
			_uiClass = uiClass;
			
			draw()
		}
		
		private function draw():void 
		{
			_mc = new _uiClass();
			addChild(_mc);
			
			
		}
		override public function start():void 
		{
			totalProgress = _totalTime / _delay;
			trace( "totalProgress : " + totalProgress );
			
			_timer = new Timer(_delay, totalProgress);
			_timer.start()
			_timer.addEventListener(TimerEvent.TIMER, __TIMER);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE,__TIMER_COMPLETE)
		}
		public function pause():void
		{
			_timer.stop()
		}
		public function resume():void
		{
			_timer.start();
		}
		public function stop():void
		{
			_timer.stop()
			_timer.reset();
			_bar.scaleX = 0;
			
		}
		public function get running():Boolean { return _timer.running; }
		private function __TIMER_COMPLETE(e:TimerEvent):void 
		{
			complete();
		}
		
		private function __TIMER(e:TimerEvent):void 
		{
			nowProgress++;
			updateBar();
		}
		override public function updateBar():void 
		{
			_bar.scaleX = nowProgress / totalProgress;
		}
		public function get bar():* 
		{
			return _bar;
		}
		
		public function set bar(value:*):void 
		{
			_bar = value;
		}
		
		public function get delay():int 
		{
			return _delay;
		}
		
		public function set delay(value:int):void 
		{
			_delay = value;
		}
		
		public function get totalTime():int 
		{
			return _totalTime;
		}
		
		public function set totalTime(value:int):void 
		{
			_totalTime = value;
		}
		
		public function get mc():* 
		{
			return _mc;
		}
		
		public function set mc(value:*):void 
		{
			_mc = value;
		}
		
		
	}

}