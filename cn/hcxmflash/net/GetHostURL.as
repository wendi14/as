package cn.hcxmflash.net
{
	import flash.net.LocalConnection;

	public class GetHostURL
	{
		public function GetHostURL()
		{
		}
		public static function getURL():String
		{
			var loc:LocalConnection=new LocalConnection()
			return loc.domain;
		}
	}
}