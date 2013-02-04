package hcxm.cn.debug
{
	public class Debug
	{
		public function Debug()
		{
		}
		public static function Trace(app:*,prev:String=" "):void
		{
			
			var type:String=typeof(app);
			if(type=="object")
			{
				if(app as Array)
				{
					trace(prev+"数组->["+app+"]"+"-len:"+app.length);
				}else
				{
					trace(prev+app);
				}
			}
			else if(type=="string")
			{
				trace(prev+app);
			}
			else if(type=="boolean")
			{
				trace(prev+app);
			}
		}
		public static function trace_(e:*):void
		{
			trace(e)
		}

	}
}