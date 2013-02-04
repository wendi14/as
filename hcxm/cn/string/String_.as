package hcxm.cn.string {
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class String_ {
		
		public function String_() {
			
		}
		//<a href="http://download.microsoft.com/download/1/7/d/17d82b72-bc6a-4dc8-bfaa-98b37b22b367/subinacl.msi" target="_blank"><span style="color: #0000ff;">http://download.microsoft.com/download/1/7/d/17d82b72-bc6a-4dc8-bfaa-98b37b22b367/subinacl.msi</span></a>
		/**
		 * 给链接加颜色
		 * @param	str
		 */
		public static function a_href(str:String) {
			//var reg:RegExp=/<span style=(.*)>(.*)<\/span><\/a>/ig;
			var reg:RegExp=/<a href="(.*)" (.*)<\/a>/ig;
			var s = str.replace(reg, "<a href='$1' target='_blank'><font color='#0066cc'>$1</font></a>");
			return s;
		}
		/**
		 * 给图像换行
		 * @param	str
		 *  <strong><img src="http://www.ali213.net/picfile/News/2008-06/Diablo3.jpg" alt="" width="554" height="718" /></strong>

<strong>《暗黑破坏神3》官方网站：</strong>
		 */
		public static function imgHuanHang(str:String) {
			var reg:RegExp =/(<img.*)(height=")(\d+)"(.*)(\/>)/ig;
			
			//如果有找到的话
			var s
			if (reg.test(str)) {
				 reg.exec(str);
				var arr = reg.exec(str);
				var len = int(arr[3] / 14);
				var br:String = "";
				for (var i:int = 0; i < len; i++) {
					br += "<br/>";
				}
				s = str.replace(reg, arr[0]+br);
			}else {
				//如果没有找到的话
				s = str
			}

			return s;
		}
		/**
		 * <strong>《暗黑破坏神3》官方网站：</strong>
		 * @param	str
		 */
		public static function strong(str:String) {
			var reg:RegExp =/<strong>(.*)<\/strong>/ig;
			var s = str.replace(reg, "<b>$1</b>");
			//trace( "s : " + s );
			return s;
		}
		
	}
	
}
