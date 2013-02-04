package com.xmaser.file 
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class FileSaveAs extends File 
	{
		
		public function FileSaveAs() 
		{
			
		}
		/**
		 * 
		 * @param	data	二制制
		 * @param	defaultFileName		c:\\a\\filename.jpg
		 */
		override public function save(data:*, defaultFileName:String = null):void 
		{
			var f:File = new File(defaultFileName);
			var fs:FileStream = new FileStream();
			fs.open(f, FileMode.WRITE);
			fs.writeBytes(data);
			fs.close();
			
		}
		
	}

}