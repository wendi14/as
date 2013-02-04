package cn.hcxmflash.game.comm
{
	import cn.hcxmflash.event.Event_;
	import cn.hcxmflash.time.DaoJiShi;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class DianZiShuZhi extends MovieClip
	{
		
		public function DianZiShuZhi(time:int=10) 
		{
			stop();
			
			this.gotoAndStop(time);
			var daoji:DaoJiShi = new DaoJiShi(time-1)
			daoji.addEventListener(DaoJiShi.UPDATE, __daupdate);
			daoji.addEventListener(Event.COMPLETE, __dacomplete);
		}

		
		private var dizshuz:DianZiShuZhi
		private function __dacomplete(e:Event):void 
		{
			dispatchEvent(e);
		}
		
		private function __daupdate(e:Event_):void 
		{
		trace("e.data : " + e.data);
			this.gotoAndStop(e.data + 1);
			
		
			
		}
	}

}