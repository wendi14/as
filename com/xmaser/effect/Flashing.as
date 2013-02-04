package com.xmaser.effect 
{
	import com.greensock.events.TweenEvent;
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author 小火柴
	 */
	public class Flashing extends EventDispatcher
	{
		private var tm:TweenMax;
		private var time:Number=0.1;
		private var mc:DisplayObject;
		
		public function Flashing(mc:DisplayObject,colorize:uint=0xFFFFFF) 
		{
			this.mc = mc;
			tm = TweenMax.to(mc, time, { colorMatrixFilter: { colorize:colorize, amount:1, brightness:2.5}} ); 
			tm.addEventListener(TweenEvent.COMPLETE,__c1)
		}
		public function pause():void
		{
			tm.pause();
		}
		public function restart():void
		{
			tm.restart();
		}
		private function __c1(e:TweenEvent):void 
		{
			tm.removeEventListener(TweenEvent.COMPLETE, __c1);
			
			time=0.3
			tm = TweenMax.to(mc, time, { colorMatrixFilter: { colorize:0, amount:0, brightness:1}} ); 
			//tm.addEventListener(TweenEvent.COMPLETE,__c1)
			
			
		}
		
	}

}