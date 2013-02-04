package hcxm.cn.util {
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	
	/**
	* ...
	* @author Default
	*/
	public class String_W {
		
		public function String_W() {
			
		}
		public static function getData_from_FenGeFu(str:String,stas:String,ends:String){	
				var sta = str.indexOf(stas, 0);
				var end = str.indexOf(ends, sta);
				var last = str.slice(sta+stas.length, end);
				//trace(sta+"-"+last);
				return last;
		}
		public static function getData_from_FenGeFu_loop(str:String, stas:String, ends:String, loop_num, arr:Array, add:String) {
				var end = 0;
				for (var i = 0; i < loop_num; i++) {
					var sta = str.indexOf(stas, end);
					 end = str.indexOf(ends, sta);
					var last = str.slice(sta + stas.length, end);
					
					arr.push(add+last);
				}
		}
		public static function trimLR(str:String,deleS) {
				var c:Array = str.split("");
				var tem:Array=[]
				for(var i=0;i<c.length;i++){
					if (c[i] != " "&&c[i]!=deleS) {
						//trace(i)
						tem.push(c[i]);
					}			
				}
				//trace(tem.length)
				return str = tem.join("");
		}
		public static function split(str:String,total:Number,s2:String) {
				var s1:String = str.substr(0, total);
				return (s1 + s2);
		}
		public static function  getHomeUrl(mc:Sprite,url:String) {
			//trace(mc._url);			
			if (mc.root.loaderInfo.url == url) {
				return true
			}else {
				return false;
			}
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
		
	}
	
}