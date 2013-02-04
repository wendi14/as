package  cn.hcxmflash.time
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import house.model.HouseModelLocater;
	import newutils.TextUtils;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class DaoJiShiUtil extends MovieClip
	{
		private var _uiClass;
		private var _s1;
		private var _s2;
		private var _m1;
		private var _m2;
		private var _h1;
		private var _h2;
		private var ww;
		private var gap = 14;
		private var _second;
		private var _hold:Sprite;
		private var _showFen:Boolean = false;
		public static const OVER:String = "over"
		private var _txt:TextField
		private var gap2:int=45;
		public function DaoJiShiUtil(uiClass:Class, second:Number, showFen:Boolean = true) 
		{
			_showFen = showFen;
			_uiClass = uiClass;
			_second = second
			draw()
		}
		
		private function draw():void
		{
			
			ww = 0;
			_hold = new Sprite();
			
			addChild(_hold);
			if (!_showFen) 
			{
				_hold.scaleX = _hold.scaleY = 0.5;
				_hold.x -= 71;
				_hold.y = 19;
				
				
				
				_day1= new _uiClass();
				_day2= new _uiClass();
				_hold.addChild(_day1); 
				_hold.addChild(_day2)
				
				_day1.x = ww;
				ww += gap;
				_day2.x = ww;
				ww += gap;
			}
			
			
			
			if (!_showFen)
			{
				ww+=gap2;
			}
			
			
			
			_h1 = new _uiClass();
			_h2 = new _uiClass();
			_hold.addChild(_h1); 
			_hold.addChild(_h2)
			
			_h1.x = ww;
			ww += gap;
			_h2.x = ww;
			ww += gap;
			
			if (_showFen)
			{
				var fen = new _uiClass();
				fen.gotoAndStop(11)
				_hold.addChild(fen)
				fen.x = ww;
				ww += gap;
			}else
			{
				ww+=(gap2-13);;
			}
			
			
			
			_m1 = new _uiClass();
			_m2 = new _uiClass();
			_hold.addChild(_m1);_hold.addChild(_m2)
			_m1.x = ww;
			ww += gap;
			_m2.x = ww;
			ww += gap;
			
			if (_showFen) 
			{
				fen = new _uiClass();
				fen.gotoAndStop(11)
				_hold.addChild(fen)
				fen.x = ww;
				ww += gap;
			}else
			{
				ww+=(gap2-12);
			}
			
			
			_s1 = new _uiClass();
			_s2 = new _uiClass();
			_hold.addChild(_s1); _hold.addChild(_s2);
			_s1.x = ww;
			ww += gap;
			_s2.x = ww;
			
			
			start()
		}
		private var _timer:Timer
		private var _day1;
		private var _day2;
		public function start():void
		{
			_timer = new Timer(1000,_second+1)
			_timer.addEventListener(TimerEvent.TIMER, __TIMER);
			_timer.start();
		}
		public function destory():void 
		{
			try 
			{
				_timer.stop()
				_timer.removeEventListener(TimerEvent.TIMER, __TIMER);
				_timer = null;
			}catch (err:Error)
			{
				
			}
		
		}
		private function __TIMER(e:TimerEvent):void 
		{
			_second--;
			
			if (_second < 0)
			{
				//trace("destory : " + destory);
				destory()
				
				dispatchEvent(new Event(OVER))
				
				return;
			}
			update(_second);
			
		}
			
		/**
		 * 更新计时
		 * @param	second
		 */
		public function update(second:int):void
		{
			if (_day1)
			{
				var d:String=bu0(getDay())
				var ard=d.split('')
				_day1.gotoAndStop( int(ard[0])+1);
				_day2.gotoAndStop(int(ard[1])+1);
			}
			
			
			
			var s:String = bu0(getSec(second));
			
			var ars = s.split('')
			
			
			_s2.gotoAndStop( int(ars[1])+1);
			_s1.gotoAndStop(int(ars[0])+1);
			
			
			var m:String = bu0(getMin(second));
			var arm = m.split('');
			
			
			_m2.gotoAndStop(  int(arm[1])+1);
			_m1.gotoAndStop(  int(arm[0])+1);
			
			var h:String = bu0(getHour(second));
			var arh = h.split('');
			
			_h1.gotoAndStop(int(arh[0])+1)
			_h2.gotoAndStop(int(arh[1]) + 1)
			
			
		/*	var d = getDay();
			if (d > 0)
			{
				if (!_txt) 
				{
					_txt = new TextField()
					_txt.text = d + HouseModelLocater.getIns().language.words.day;
					_txt.mouseEnabled = false;
					var tf:TextFormat = new TextFormat("_sans",14,0,true)
					tf.align = "center";
					_txt.selectable = false;
					_txt.setTextFormat(tf)
					addChild(_txt);
					//TextUtils.miaoBian(_txt,0x000000,0xffffff);
					_txt.y =-14
					_txt.x =12
				}
			}else
			{
				if (_txt) 
				{
					removeChild(_txt);
				}
			}*/
			
		}
		
		private function getDay():*
		{
			var d = int((_second-1) / 60 / 60 / 24)
			return d;
		}
		
		public static function getHour(second:int):int
		{
			var hour:int = 0;
			hour = int(second / 60/60)%24;
			return hour;
		}
		public static function getMin(second:int):int
		{
			var min:int = 0;
			min = int(second / 60)%60;
			
			return min;
		}
		public static function getSec(second:int):int
		{
			var sec:int = 0;
			sec = second % 60;
			
			return sec;
		}
		public static function bu0(n:*):String
		{
			var str:String = String(n);
			if (n<10) 
			{
				str = "0" + str;
			}
			
			return str;
		}
	}

}