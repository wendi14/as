package hcxm.cn.net
{
	import flash.utils.ByteArray;
	
	/***
	 * URL 编码;
	 * */
	public class UrlEncoder
	{
		public function UrlEncoder()
		{
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
			    result += escape(String.fromCharCode(byte[i]));
			   }
			   return result;
		  }

	  public static function urlencodeGBK(str:String):String{
	   var result:String ="";
	   var byte:ByteArray =new ByteArray();
	   byte.writeMultiByte(str,"gbk");
	   for(var i:int;i<byte.length;i++){
			result += escape(String.fromCharCode(byte[i]));
	   }
	//   trace(result);
	   return result;
	  }
	}
}