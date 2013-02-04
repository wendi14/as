package com.xmaser.display.component 
{
	import com.xmaser.assets.asset_countdownBar;
	import flash.events.Event;
	import flash.events.TimerEvent;
	/**
	 * ...
	 * @author wdc
	 */
	public class CountdownProgressBarComponent extends CountdownComponent 
	{
		
		public function CountdownProgressBarComponent(count:Number) 
		{
			super(count,30);
		}
		override protected function drawUI():void 
		{
			super.drawUI();
			_diplayObject = new asset_countdownBar();
			addChild(_diplayObject);
		}
		override protected function init():void 
		{
			super.init();
		}
		override protected function __TIMER(e:TimerEvent):void 
		{
			super.__TIMER(e);
			_diplayObject["mc_bar"].scaleX = this._percent;
			//trace( "this._timer.currentCount : " + this._timer.currentCount );
			
		}
		override protected function __TIMER_COMPLETE(e:TimerEvent):void 
		{
			_diplayObject["mc_bar"].scaleX = 1;
			dispatchEvent(new Event(Event.COMPLETE))
		}
	}

}