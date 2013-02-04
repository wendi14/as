package  com.xmaser.effect
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author 小火柴
wendi14@qq.com
	 */
	public class Eff_Lightning 
	{
		private var timer:Timer;
		private var _mc:Sprite;
		
		public function Eff_Lightning(mc:Sprite,completeFunc:Function=null) 
		{
			_mc = mc;
			timer = new Timer(50, 40);
			timer.addEventListener(TimerEvent.TIMER, 
			function(e:*):void
			{
	
				mc.alpha = timer.currentCount % 2+0.5;
			}
			
			);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,
			function (e:*):void
			{
				mc.alpha = 1;
				if (completeFunc!=null) 
				{
					
					completeFunc();
				}
			}
			)
			timer.start();
		}
		public function clear():void
		{
			if (timer)
			{
				timer.stop();
				
			}
			timer = null;
			mc.alpha=1
		}
		
		public function get mc():Sprite 
		{
			return _mc;
		}
		
	}

}