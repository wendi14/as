package hcxm.cn.util {
	import flash.utils.ByteArray;
	
	import mx.utils.Base64Decoder;
	import mx.utils.Base64Encoder;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class Base64 {
		
		public function Base64() {
			
		}
		/**
		 * 把base64编码过的字符转化为正常显示
		 * @param	b64
		 */
		public static function ToString(b64:String):String {
			var base64:Base64Decoder = new Base64Decoder();
			base64.decode(b64);
			var byt:ByteArray = base64.toByteArray();
			var res:String=byt.readMultiByte(byt.bytesAvailable, "gbk")
			
			return res
		}
		/**
		 * 把正常的字符转为64编码
		 */
		public static function ToBase64(str:String):String {
			
			var ar:ByteArray = new ByteArray()
			ar.writeMultiByte(str, "gbk");
			var bb:Base64Encoder = new Base64Encoder();
			bb.encodeBytes(ar);
			var res:String = bb.toString();
			
			return res;
			
		}
		
	}
	
}
