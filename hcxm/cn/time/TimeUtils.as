package hcxm.cn.time
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
			var mm:int=da.getMonth()+1;
			mm=bu0(mm.toString());
			var dd=da.getDate();
			dd=bu0(dd)
			//			return "日期："+yy+"-"+mm+"-"+dd+"		时间："+hh+":"+min;
			return yy+"-"+mm+"-"+dd;
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