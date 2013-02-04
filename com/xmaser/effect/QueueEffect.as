package com.xmaser.effect 
{
	import com.greensock.core.TweenCore;
	import com.greensock.events.TweenEvent;
	import com.greensock.TweenMax;
	/**
	 * ...
	 * @author 小火柴
	 */
	public class QueueEffect 
	{
		private var _effects:Array;
		
		public function QueueEffect(...args) 
		{
			_effects = args;
			for (var i:int = 0; i < args.length; i++) 
			{
				var item:* = args[i];
				item.pause()
				item.addEventListener(TweenEvent.COMPLETE, __COMPLETE);
				
			}
			_effects[0].restart();
		}
		
		private function __COMPLETE(e:TweenEvent):void 
		{
			_effects.shift();
			if (_effects.length == 0) return;
			_effects[0].restart();
		}
		
	}

}