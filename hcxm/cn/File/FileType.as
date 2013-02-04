/**
 * 判断上传文件的真正类型
 */
package hcxm.cn.File
{
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	public class FileType
	{
		public static var FileHeaders:Array = createHeaders();
		
		public function FileType()
		{
		}
		
		public static function createHeaders():Array
		{
			var headers:Array = [];
			headers.push({header:"89504E47", ext:"png"});
			headers.push({header:"FFD8FF", ext:"jpg"});
			headers.push({header:"47494638", ext:"gif"});
			headers.push({header:"504B0304", ext:"zip"});
			return headers;
		}
		/**
		 * 调用这个方法
		 * @param	file
		 * @param	filter
		 * @return
		 */
		public static function checkFileHeader(file:FileReference, filter:FileFilter):Boolean
		{
			var ext:String = filter.extension.toLocaleLowerCase();
			var chkExt:String = checkFileExt(file);
			return filter.extension.indexOf("*."+chkExt) != -1;
		}
		
		public static function checkSingleFileHeader(file:FileReference, type:String):Boolean
		{
			var ext:String = type.toLocaleLowerCase();
			var chkExt:String = checkFileExt(file);
			return ext == chkExt;
		}
		
		public static function checkFileExt(file:FileReference):String
		{
			var bytes:ByteArray = new ByteArray();
			file.data.position = 0;
			file.data.readBytes(bytes);

			var len:uint = Math.floor(bytes.length/2);
			var tmpArray:Array = FileHeaders.slice(0);
			for(var i:uint=0;i<len;i+=2)
			{
				var byte:uint;
				try
				{
					byte = bytes.readByte();
				}
				catch(e:Error)
				{
					break;
				}
				var bstr:String = byte.toString(16);
				bstr = bstr.slice(bstr.length-2).toUpperCase();
				bstr = bstr.length<2 ? "0"+bstr : bstr;
				tmpArray = filterLetters(bstr, tmpArray, i);
				if(tmpArray.length == 1 && tmpArray[0].header.length == i+2)
				{
					return tmpArray[0].ext;
				}
				if(tmpArray.length == 0)
				{
					break;
				}
			}
			//
			return "unknown";
		}
		
		public static function filterLetters(doubleLetters:String, headerArray:Array, deep:uint):Array
		{
			//trace("doubleLetters:"+doubleLetters);
			var tmpArray:Array = [];
			if(headerArray.length<0)
			{
				return tmpArray;
			}
			
			for(var i:uint=0;i<headerArray.length;i++)
			{
				var tmp:String = headerArray[i].header.toLocaleUpperCase();
				if(tmp.length<=deep+1) continue;
				var tmpStr:String = tmp.charAt(deep)+tmp.charAt(deep+1);
				if(doubleLetters == tmpStr)
				{
					tmpArray.push(headerArray[i]);
				}
			}
			return tmpArray;
		}
	}
}

