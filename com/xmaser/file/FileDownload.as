package com.xmaser.file 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	
	/**
	 * ...用来在air下下载文件用的
	 * @author wdc
	 */
	public class FileDownload extends URLStream 
	{
		private var _saveFile:File;
		private var _url:String;
		private var _fileName:String;
		private var _savePath:File;
		
		public function FileDownload(url:String,fileName:String,savePath:File=null) 
		{
			this._savePath = savePath;
			this.fileName = fileName;
			this.url = url;
			if (!_savePath) 
			{
				_savePath = new File(File.applicationDirectory.resolvePath("down").nativePath);
			
			}
			_savePath = _savePath.resolvePath(fileName);
			this.load(new URLRequest(url));
			this.addEventListener(Event.COMPLETE, onComplete);
			this.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
		}
		
		private function onIoError(e:Event):void 
		{
			trace(e);
			dispatchEvent(new Event(Event.INIT));
		}
		
		private function onComplete(e:Event):void 
		{
			
			var fs:FileStream = new FileStream()
			fs.open(_savePath, FileMode.WRITE);
			
			var by:ByteArray = new ByteArray()
			this.readBytes(by);
			fs.writeBytes(by);
			fs.close();
		
			dispatchEvent(new Event(Event.INIT));
		}
		
		public function get url():String 
		{
			return _url;
		}
		
		public function set url(value:String):void 
		{
			_url = value;
		}
		
		public function get fileName():String 
		{
			return _fileName;
		}
		
		public function set fileName(value:String):void 
		{
			_fileName = value;
		}
		
		public function get savePath():File 
		{
			return _savePath;
		}
		
		public function set savePath(value:File):void 
		{
			_savePath = value;
		}
		
	}

}