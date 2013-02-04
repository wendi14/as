package hcxm.air.controls {
	import fl.controls.TextInput;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import hcxm.cn.event.Event_;
	
	/**
	* ...
	* @编写者： wendi(小火柴)
						http://www.hcxm.cn
	*/
	public class File_Browser extends Sprite {
		//var btn_open:TextInput;
		//var file_name:TextInput;
		var file:File
		var _fileType:FileFilter
		var _path:String
		//public static const ONFinished:String = "ONFinished";
		public function File_Browser() {
			file = new File()
			file.addEventListener(Event.SELECT,onSelectFile)

			btn_open.addEventListener(MouseEvent.CLICK,onOpen)
		}
		
		private function onSelectFile(e:Event):void {
			var name = file.name;
			var url = file.nativePath;
			/**
			 * url : file:///C:/wendi.jpg
file.nativePath : C:\wendi.jpg
url : C:/wendi.jpg
			 */
			//trace( "url : " + url );	
			var reg:RegExp =/(file:\/\/\/)/;
			url = url.replace(reg, "");
			var reg2:RegExp =/(\\)/g;
			url = url.replace(reg2, "/");		
			trace( "url : " + url );
			_path =url;
			file_name.text = _path;
			dispatchEvent(new Event_(Event.COMPLETE, url, true));
			
		}
		
		private function onOpen(e:MouseEvent):void {
			//trace(this._fileType)
			file.browseForOpen("先选择一个文件", [_fileType]);
			
		}
		public function set fileType(value):void {
			this._fileType = new FileFilter(value, "*." + value,null);
		}
		public function get path() { return _path; }
		public function set path(value):void {
			_path = value;
		}
		
	}
	
}