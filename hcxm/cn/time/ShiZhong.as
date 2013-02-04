package hcxm.cn.time {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField
	
	/**
	* ...
	* @author 小火柴(http://www.hcxm.cn)
	*/
	public class ShiZhong extends MovieClip {
		var data:Date
		var _year
		var _month
		var _date
		public function ShiZhong() {
			
			init();	
		}
		private function init() {
			this.addEventListener(Event.ENTER_FRAME,onenterF)
		}
		private function onenterF(e:Event) {
			data = new Date();
			var hour:Number = data.getHours();
			var min:Number = data.getMinutes();
			var sec:Number = data.getSeconds();
			s_hand.rotation = sec*6;
			m_hand.rotation = min*6+sec/60;
			h_hand.rotation = hour * 30 + min * 0.5;
			_year = data.getFullYear()
			_month=data.getMonth() + 1;
			_date=data.getDate();
		}
		//补0位
		private function get0(n) {
			if (n<10) {
				n = "0"+n;
				return String(n);
			}
			return n;
		}
		public function getYear():Number {
		
			return _year
			
		}
		public function getMonth() {
			return _month
		}
		public function getDate() {
			return _date
		}
		
		
	}
	
}