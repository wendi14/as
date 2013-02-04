package  cn.hcxmflash.game.utils
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class Effect 
	{
		
		public function Effect() 
		{
			
		}
		public static function ZhenDong(mc:Sprite):void
		{
			var mcOldx:Number = mc.x;
			var mcOldy:Number=mc.y;
			var timer:Timer = new Timer(10, 20);
			timer.addEventListener(TimerEvent.TIMER, 
			function():void
			{
				if (Math.random() > 0.5)
				{
					mc.x = mcOldx-Math.random()*10
					mc.y = mcOldy - Math.random() * 10;
					mc.scaleX=mc.scaleY=Math.random()*0.04+1
				}else 
				{
					mc.x = mcOldx+Math.random()*10
					mc.y = mcOldy+Math.random()*10;
				}
				
			}
			
			);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, 
			function():void
			{
				mc.x = mcOldx;
				mc.y = mcOldy;
				mc.scaleX=mc.scaleY=1
			}
			
			);
			timer.start();
		}
		/**
		 * 闪亮
		 */
		public static function lightning(mc:Sprite,completeFunc:Function=null):void
		{
			var timer:Timer = new Timer(50, 40);
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
		
		
		
	}

}