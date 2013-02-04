package  cn.hcxmflash.utils
{
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class StringUtil 
	{
		
		public function StringUtil() 
		{
			
		}
		public static function  miaoBian(mytxt:TextField,mytxtColor:uint=0x000000,miaoBianColor:uint=0x00ff00):void
		{
			mytxt.textColor=mytxtColor;
			//var txtGF:GlowFilter=new GlowFilter(0x000000,1,2,2,16);
			var txtGF2:GlowFilter=new GlowFilter(miaoBianColor,1,3,3,16);
			var myGF_arr:Array=new Array();
			//myGF_arr.push(txtGF);
			myGF_arr.push(txtGF2);
			mytxt.filters=myGF_arr;
		}
		public static function clearMiaoBian(mytxt:TextField):void
		{
			mytxt.filters = [];
			
		}
		public static function replaceWords(str:String='',...args):String
		{
			
			//str = '这里是{a}号地，主人是{a}，请问您要进行何种操作？' ;
			var pattern:String="{}"
			var reg:RegExp = new RegExp(pattern)
			var i:int=0
			while (reg.test(str))
			{
				var o:* = reg.exec(str);
				
				
				str=str.replace(reg, args[i])
				
				i++
			}
			
			return str;
		}
		/**
		 * 替换超长的字符
		 * @param	str 原始字符
		 * @param	keepLength 要保留的字符长度
		 * @param	replaceSymbol 用来替换 当超过要保留的长度的字字符，默认为...
		 * @return
		 */
		public static function cut(str:String,keepLength:int,replaceSymbol:String="..."):String
		{
			var res:String = str;
			if (!str) return "";
			if (str.length > keepLength)
			{
				var pat:String = str.slice(keepLength + 1, str.length);
				//trace( "pat : " + pat,pat.length );
				if (pat.length > 0)
				{
					res = str.replace(pat, replaceSymbol);
				}
			}
			
			
			return res;
		}
		public static function isWhitespace(char:String):Boolean{

		return trim(char).length == 0;

		}



		public static function trim(char:String):String{

		return rtrim(ltrim(char));

		}

		public static function ltrim(char:String):String{

		var pattern:RegExp = /^\s*/;

		return char.replace(pattern,"");

		}

		public static function rtrim(char:String):String{

		var pattern:RegExp = /\s*$/;

		return char.replace(pattern,"");

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
			   for (var i:int = 0; i<oriByteArr.length; i++) {
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
		 public static function decodeLuanMa(str: String):String
		 {
			 var isZh_cn:Boolean = false;
			  var oriByteArr:ByteArray = new ByteArray();
			   oriByteArr.writeUTFBytes (str);
			   var tempByteArr : ByteArray = new ByteArray();
			   for (var i:int = 0; i<oriByteArr.length; i++) {
			    if (oriByteArr[i] == 194) {
					isZh_cn = true;
			    	 tempByteArr.writeByte(oriByteArr[i+1]);
			    	 i++;
			    } else if (oriByteArr[i] == 195) {
					isZh_cn = true;
			    	 tempByteArr.writeByte(oriByteArr[i+1] + 64);
			    	 i++;
			    } else {
			    	 tempByteArr.writeByte(oriByteArr[i]);
			    }
			   }
			   tempByteArr.position = 0;
			   if (isZh_cn)
			   {
				   return tempByteArr.readMultiByte(tempByteArr.bytesAvailable, "chinese");
			   }else 
			   {
				   return tempByteArr.readMultiByte(tempByteArr.bytesAvailable, "utf-8");
			   }
			   
			   
			   
		 }
		 public static function readGB2312_Byte(byte:ByteArray):String
		 {
			 var b1:ByteArray = new ByteArray()
			b1.writeBytes(byte);
			b1.position = 0;
			 
			 var ss:String= b1.readMultiByte(b1.bytesAvailable, "gb2312");
			 return ss;
		 }
		
	}

}