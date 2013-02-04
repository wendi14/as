package  cn.hcxmflash.utils
{
	import flash.utils.describeType;
	
	public class DescribeClass
	{
		public function DescribeClass()
		{
		}
		public static function describe(o:*):Object
		{
			var xml:XML = describeType(o);
			//trace( "xml : " + xml );
			var xmlist:XMLList=xml.accessor;
			var o:Object={};
			for(var i:int=0;i<xmlist.length();i++)
			{
				
				var na:String=xmlist[i].attribute("name");
				o[na]=null;
			}
			return o;
		}		
		public static function describe_flash(o:*):Object
		{
			var xml:XML = describeType(o);
			
			var xmlist:XMLList=xml.variable;
			var o:Object={};
			for(var i:int=0;i<xmlist.length();i++)
			{
				
				var na:String=xmlist[i].attribute("name");
				o[na]=null;
			}
			return o;
		}
	}
}