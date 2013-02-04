package cn.hcxmflash.time
{
	public class TimeUtils
	{
		public function TimeUtils()
		{
		}
		/**
		 * 输出类似:2009-02-10
		 * @param	da		Date类型
		 * @param	sep	分隔符
		 * */
		public static function getDate(da:Date,sep:String="-"):String
		{
			var yy:Number=da.getFullYear()
			var mm:Number=da.getMonth()+1;
			var m2:String=bu0(mm);
			var dd:Number=da.getDate();
			var d2:String=bu0(dd)
			//			return "日期："+yy+"-"+mm+"-"+dd+"		时间："+hh+":"+min;
			return yy+sep+m2+sep+d2;
		}
		/**
		 * 从当前日期中取出时间
		 * @param	da	Date 
		 * @param	sep	分隔符
		 * @return
		 */
		public static function getTimeFormDate(da:Date,sep:String=":"):String
		{
			var hour:Number = da.getHours();
			var min:Number = da.getMinutes();
			
			var hs:String = bu0(hour)
			var ms:String = bu0(min);
			return hs + sep + ms;
		}
		private static var weekArr:Array = ["星期天","星期一","星期二","星期三","星期四","星期五","星期六"]
		public static function getWeek(da:Date):String
		{
			var w:Number = da.getDay();
			return weekArr[w];
		}
		public static function  bu0(s:Number):String
		{
			var res:String = String(s);
			
			if(s<10)
			{
				res="0"+s
			}
			return res;
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
		/**
		 * 
		 * 1 = "00:00.00"
		 * 分－秒－毫秒
		 * 返回毫秒
		 */
		public static function getTimeFromMSMS(format:String="00:55:66",s1:String=":",s2:String=":"):Number
		{
			var ar:Array=[]
			if (s1 == s2)
			{
				
			}else 
			{
				
				format=format.replace(".", ":");
			}
			ar=format.split(":")
			var m:Number = ar[0];
			var s:Number = ar[1];
			var ms:Number = ar[2];
			var res:Number;
			
			res = m * 60 * 1000 + s * 1000 + ms;
			return res;
			
		}
		/**
		 * 时分秒
		 * @param	format
		 * @param	s1
		 * @param	s2
		 * @return
		 */
		public static function getTimeFromHMS(sec:Number,format:String=":"):String
		{
			var res:String
			
			var h:String = bu0(getHour(sec))
			var m:String = bu0(getMin(sec))
			var s:String = bu0(getSec(sec));
			res = h+format+m + format + s;
			return res;
			
		}
		public static function getTimeIsMHD(time:Number,format:String="分钟,小时,天"):Array
		{
			time = time / 1000;
			var format_arr:Array = format.split(",");
			if (getMin(time) < 60)
			{
				return [getMin(time), format_arr[0]];
			}
			if (getHour(time)<24) 
			{
				return [getHour(time), format_arr[1]];
			}
			return [int(time / 60 / 60 / 24), format_arr[2]];
		}
	}
}