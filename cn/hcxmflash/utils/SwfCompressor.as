package cn.hcxmflash.utils 
{
	import flash.utils.ByteArray;
	/**
	 * ...压缩和解压缩SWF
	 * @author 小火柴
	 */
	public class SwfCompressor
	{
		
		public function SwfCompressor() 
		{
			
		}
		public static function decompress(da:ByteArray):ByteArray
		{
			var header:ByteArray = new ByteArray();
			var content:ByteArray = new ByteArray();
			var deContent:ByteArray = new ByteArray();
			
			header.writeBytes(da, 3,5);
			content.writeBytes(da, 8);
			content.uncompress()
			
			deContent.writeMultiByte("FWS", "us-ascii");
			deContent.writeBytes(header);
			deContent.writeBytes(content);
			
			
			return deContent;
		}
		public static function compress(data:ByteArray):ByteArray
       {
            var header:ByteArray = new ByteArray();
            var decompressed:ByteArray = new ByteArray();
            var compressed:ByteArray = new ByteArray();
 
            header.writeBytes(data, 3, 5); //read the header, excluding the signature
            decompressed.writeBytes(data, 8); //read the rest
 
            decompressed.compress();
 
            compressed.writeMultiByte("CWS", "us-ascii"); //mark as compressed
            compressed.writeBytes(header);
            compressed.writeBytes(decompressed);
 
            return compressed;
        }

	}

}