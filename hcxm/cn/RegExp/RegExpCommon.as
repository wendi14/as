package hcxm.cn.RegExp {
	
	/**
	* ...
	* @author Default
	*/
	public class RegExpCommon {
		
		public function RegExpCommon() {
			
		}
		/**
		 * 验证E-Mail;
		 */
		public static function get email ():RegExp {
/* 			var name:String = "([a-z0-9_-]+(?:\.[a-z0-9_-])*@)";		
			var domain:String = "((?:[a-z0-9_-]\.)*\.)";
			var superDomain:String = "([a-z]{2,4})";

			var emailPattern:RegExp = new RegExp ( name + domain + superDomain, "ig"); */
			var emailPattern:RegExp= /^([a-z0-9_-][\w.-]+@)[\w.-]+\.[\w.-]*[a-z][a-z]$/i;
			/**
			 * private function isValidEmail(email:String):Boolean {
       var emailExpression:RegExp = /^[\w-]+(\.[\w-]+)*@([a-z0-9-]+(\.[a-z0-9-]+)*?\.[a-z]{2,6}|(\d{1,3}\.){3}\d{1,3})(:\d{4})?$/i;
       return emailExpression.test(email);
}
			 **/
			return emailPattern;
		}
		/**
		 * 验证网址
		 */
		public static function get httpUrl ():RegExp {
			var protocol:String = "((?:http|ftp)://)";
			var urlPart:String = "([a-z0-9_-]+\.[a-z0-9_-]+)";
			var optionalUrlPart:String = "(\.[a-z0-9_-]*)";

			var urlPattern:RegExp = new RegExp (protocol + urlPart + optionalUrlPart, "ig");
			return urlPattern;
		}
		
	}
	
}
