package cn.hcxmflash.file 
{
	import flash.filesystem.File;
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class FileUtils 
	{
		
		public function FileUtils() 
		{
			
		}
		/**
		 * 列出目录底下所有的文件，包括子目录中的文件
		 * @param	file　主目录
		 * @param	resArr　储存结果的
		 */
		public static function getAllFile(file:File, resArr:Array):void
		{
			if (file.isDirectory) 
			{
				var ar:Array = file.getDirectoryListing()
				for (var i:int = 0; i < ar.length; i++) 
				{
					var item:File = ar[i];
					if (item.isDirectory == false)
					{
						resArr.push(item);
					}else 
					{
						getAllFile(item, resArr);
					}
					
				}
			}
		}
				
		
	}

}