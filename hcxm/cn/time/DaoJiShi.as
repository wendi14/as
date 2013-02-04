package hcxm.cn.time
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class DaoJiShi extends EventDispatcher
	{	

	
		public static var TIMER_OVER:String = "time_over";
		public static var TIMER_PAUSE:String = "time_pause";
		[Bindable]
		public var data:String;
		
		private var newDate:Date
		private var localDate:Date
		public function DaoJiShi(howlong:Date)
		{		
			newDate=howlong
			start()
		}
		private function _enterFrameHandler(e:TimerEvent):void
		{
			localDate=new Date()
			var dif=(newDate.time-localDate.time)/1000
			var dif_d = Math.floor(dif/(3600*24));
			 //相差的天数=[相差的总秒数/一天的总秒数(60秒*60分*24小时)]
			dif_d=bu0(dif_d)
			 var dif_h = Math.floor((dif-dif_d*3600*24)/3600);
			 //相差的小时=[(天数取整后剩于的总秒数)/一小时的总秒数]
			dif_h=bu0(dif_h)
			 var dif_m = Math.floor((dif-dif_d*3600*24-dif_h*3600)/60);
			 //相差的分钟=[(天数和小时取整后剩于的总秒数)/一分钟的总秒数]
			dif_m=bu0(dif_m)
			 var dif_s = Math.floor(dif-dif_d*3600*24-dif_h*3600-dif_m*60);
			 //相差的秒数=[天数和小时和分钟取整后剩于的总秒数]
			 dif_s=bu0(dif_s)
			 data=dif_d+"天"+dif_h+"时"+dif_m+"分"+dif_s+"秒";
		}
		/**
		 * 暂停时间
		 */
		private function pause():void {
			
			dispatchEvent(new Event(DaoJiShi.TIMER_PAUSE))
		}
		/**
		 * 开始和继续
		 */
		private var timer:Timer
 
		private function start():void {
			timer=new Timer(100,0)
			timer.start();
			timer.addEventListener(TimerEvent.TIMER,_enterFrameHandler)
		}
		private static function  bu0(s):String
		{
			if(s<10)
			{
				s="0"+s
			}
			return s;
		}
	}
}