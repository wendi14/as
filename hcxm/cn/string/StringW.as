package hcxm.cn.string {
	import flash.filters.GlowFilter;
	import flash.utils.ByteArray;
	
	/**
	* ...
	* @author 小火柴(http://www.hcxm.cn)
	*/
	public class StringW {
		
		public function StringW() {
			
		}
	public static function addMiaoBianEffect(target,bian_color:uint=0x000000):void {
		var glow:GlowFilter = new GlowFilter(bian_color, 100, 2, 2, 4,1, false, false);
		var myarr:Array = target.filters;
		myarr.push(glow);
		target.filters = myarr;
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
				var ar:Array = reg.exec(str)
				var len = int(ar[3] / 14);
				var br:String = "";
				for (var i:int = 0; i < len; i++) {
					br += "<br/>";
				}
				s = str.replace(reg, ar[0]+br);
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
		/**
		 * 把简体中文（乱码）转为utf-8
		 * @param	str
		 * @return
		 */
		public  static function EncodeUtf8(str: String):String {
			   var oriByteArr:ByteArray = new ByteArray();
			   oriByteArr.writeUTFBytes (str);
			   var tempByteArr : ByteArray = new ByteArray();

			   for (var i = 0; i<oriByteArr.length; i++) {
			    if (oriByteArr[i] == 194) {
			    	 tempByteArr.writeByte(oriByteArr[i+1]);
			    	 i++;
			    } else if (oriByteArr[i] == 195) {
			    	 tempByteArr.writeByte(oriByteArr[i+1] + 64);
			    	 i++;
			    } else {
			    	 tempByteArr.writeByte(oriByteArr[i]);
			    }
			   }
			   tempByteArr.position = 0;
			   return tempByteArr.readMultiByte(tempByteArr.bytesAvailable,"chinese");
		 }
		 /**
		 * 搜索两个字符之间的字符
		 * @param	s1		边界符
		 * @param	s2		边界符
		 * @param	searchStr		要被搜索的字符串
		 * */
		public static function SearchBetweenTwoWorld(s1:String,s2:String,searchStr:String):String
		{
			var reg1:RegExp=new RegExp(s1);
			var reg2:RegExp=new RegExp(s2);
			
			var o1:Object=reg1.exec(searchStr)
			var o2:Object=reg2.exec(searchStr);
			if(o1==null)return ""
			var index1=o1.index;
			var index2=o2.index;
			
			searchStr=searchStr.slice(index1+s1.length,index2)
			var res:String=searchStr;
			return res;
		}	
		
public static function urlencodeGB2312(str:String):String{
   var result:String ="";
   var byte:ByteArray =new ByteArray();
   byte.writeMultiByte(str,"gb2312");
   for(var i:int;i<byte.length;i++){
    result += escape(String.fromCharCode(byte[i]));
   }
   return result;
  }

  public static function urlencodeBIG5(str:String):String{
   var result:String ="";
   var byte:ByteArray =new ByteArray();
   byte.writeMultiByte(str,"big5");
   for(var i:int;i<byte.length;i++){
    result += escape(String.fromCharCode(byte));
   }
   return result;
  }

  public static function urlencodeGBK(str:String):String{
   var result:String ="";
   var byte:ByteArray =new ByteArray();
   byte.writeMultiByte(str,"gbk");
   for(var i:int;i<byte.length;i++){
    result += escape(String.fromCharCode(byte));
   }
//   trace(result);
   return result;
  }

 		
		
		
		
		
		
			 		
	}
	
}