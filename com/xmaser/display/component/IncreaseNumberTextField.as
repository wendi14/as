package com.xmaser.display.component 
{
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author 小火柴
wendi14@qq.com
	 */
	public class IncreaseNumberTextField 
	{
		private var _per:Number;
		private var _timer:Timer;
		private var _score:int;
		private var _txt:TextField;
		private var increase:int;
		
		public function IncreaseNumberTextField(txt:TextField, increase:int = 20 ) 
		{
			this.increase = increase;
			_txt = txt;
			_timer = new Timer(10, this.increase);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			_timer.start();
		}
		
		private function onTimerComplete(e:TimerEvent):void 
		{
			var s:int =_score
		
			_txt.text = s+"";
		}
		public function update(score:int):void 
		{
			if (_score)
			{
				_txt.text = _score.toString();
			}
			_per = Math.ceil((score-this._score) / this.increase);
			if (_txt.name == "txt_magic")
			{
				//trace(_per);
			}
			_score = score;
		
			_timer.stop();
			_timer.reset();
			
			_timer.start();
			
			
		}
		
		private function onTimer(e:TimerEvent):void 
		{
			//trace( "onTimer : " + onTimer , _per,_score);
			var s:int = int(_txt.text) + _per;
			if (s == _score)
			{
				_timer.stop();
			_timer.reset();
			}
			_txt.text = s+"";
		}
		
	}

}