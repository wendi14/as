package hcxm.cn.time
{
	/**
	 * 格式化时间;
	 * */
	public class FormatDate
	{
		public function FormatDate()
		{
		}
		/**
		 * 输出类似:2009-02-10
		 * @param	da		Date类型
		 * @param	sep	分隔符
		 * */
		public static function toDate(da:Date,sep:String="-"):String
		{
			var yy=da.getFullYear()
			var mm=da.getMonth()+1;
			mm=bu0(mm);
			var dd=da.getDate();
			dd=bu0(dd)
//			return "日期："+yy+"-"+mm+"-"+dd+"		时间："+hh+":"+min;
			return yy+"-"+mm+"-"+dd;
		}

		/**
		 * 输出类似:14:01
		 * */		
		public static function toTime(da:Date,sep:String=":"):String
		{
			var hh=da.getHours();
			if(hh<10)hh="0"+hh;
			var min=da.getMinutes();
			if(min<10)min="0"+min;
			return hh+sep+min;
		}

		/**
		 * 计算指定时的倒计时，并将结果以月、周、天、时、分、秒返回，方法如下，参数为毫秒，从1970年1月1日开始算起。
		 * 
				使用例子：
				
				     var MAX_DATE:Date = new Date();
				      MAX_DATE.setMonth(3);
				      MAX_DATE.setDate(30);
				      trace(getCountDown(MAX_DATE.getTime() - (new Date()).getTime()));
				
				输出结果示例：
				
				2月1周23小时59分钟60秒
		 * */
	    public function getCountDown(uptime:Number):String 
	    {
		     if(uptime <= 0) return "error";
		    
		     var secs:Number = uptime/1000; 
		     var result:String = new String();
		    
		     var months:int = secs/(30 * 24 * 3600);
		     secs = secs % (30 * 24 * 3600);
		     if(months > 0) result += months + "月";
		    
		     var weeks:int = secs/(7 * 24 * 3600);
		     secs = secs % (7 * 24 * 3600);
		     if(weeks > 0) result += weeks + "周";
		    
		     var days:int = secs/(24 * 3600);
		     secs = secs % (24 * 3600);
		     if(days > 0) result += days + "天";
		    
		     var hours:int = secs/3600;
		     secs = secs % 3600;
		     if(hours > 0) result += hours + "小时";
		    
		     var minutes:int = secs/60;
		     secs = secs % 60;
		     if(minutes > 0) result += minutes + "分钟";
		    
		     if(Math.round(secs) > 0) result += Math.round(secs) + "秒";
		    
		     return result;
	    }
		private static function  bu0(s):String
		{
			if(s<10)
			{
				s="0"+s
			}
			return s;
		}
		/**将秒数转为时分秒
		 * n		是一个秒数
		 * */
		public static function FormSecondToTime(n:Number):String
		{
			var res;
			if(n==0)
			{
				return "00:00";
			}
			if(n%60==0)
			{
				res=bu0(int(n/60))+":00";
			}else
			{
				res=bu0(int(n/60))+":"+bu0(n%60);
			}
			return res;
		}


	}
}