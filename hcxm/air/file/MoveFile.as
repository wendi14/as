package hcxm.air.file {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	
	/**
	* ...
	* @编写者： wendi(小火柴)
						http://www.hcxm.cn
	*/
	public class MoveFile extends EventDispatcher{
		private var file:File;
		private var targetPath:File; 
		private var url
		
		public static const onMoveFileFinished:String = "onMoveFileFinished";//复制完成
		
		
		/**
		 * 
		 * @param	copyTo		把文件到这里
		 */
		public function MoveFile(copyTo:String)  {
			url = copyTo;
			file = new File();
			file.addEventListener(Event.SELECT, OnSELECT)
			
			targetPath = new File();	
			
			file.browseForOpen("请选择要复制的文件");
	
		}
		
		private function OnSELECT(e:Event):void {
			trace(file.name);
			//trace(file.nativePath);
			//trace(file.url);
			targetPath.nativePath = url+ file.name;
			file.copyToAsync(targetPath, true);
			file.addEventListener(Event.COMPLETE,onCopyComple)
		}
		
		private function onCopyComple(e:Event):void {
			//trace( "e : " + e );
			dispatchEvent(new Event(MoveFile.onMoveFileFinished, true));
		}
		/**
		 * 取得－－文件的最后路径 c:\xxx.jpg
		 */
		public function get targetFilePath() { return targetPath.nativePath; }
		/**
		 * 取得－－可以让调用的地址
		 * －－－
		 * 如，原始地址是：file:///c:/wendi.jpg 	转成－－>c:/wendi.jpg
		 * 	
		 */
		public function get targetFileURL() { 
			var url:String = targetPath.url;//	file:///c:/wendi.jpg
			var reg:RegExp =/(file:\/\/\/)/;
			url = url.replace(reg,"");
			return url; 
		}
		
	}
	
}