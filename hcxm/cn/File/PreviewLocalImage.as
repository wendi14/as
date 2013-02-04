package hcxm.cn.File
{
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	

	
	/**
	 * 预览本地图像，需要flash Player 10以上
	 * */
	public class PreviewLocalImage extends BaseFile
	{

		public function PreviewLocalImage(file1=null)
		{
			super(file1)
			file=_file;
		}
		public var  file:FileReference=_file;
		public function load():void
		{
			_file.load()
		
		}
		public function browse():void
		{
			_file.browse()
		}
		override protected function _loadCOMPLETE(e:Event):void
		{
			_by=_file.data;
			dispatchEvent(new Event(Event.COMPLETE))
		}	
		override protected function _SELECT(e:Event):void
		{		
			_file.load()
		}	
		public function get bytearr():ByteArray
		{
			return _by;
		}
		
		private var _upBytes
		public function set bytesLoaded(v):void
		{
			_upBytes=v;
		}	
		public function get bytesLoaded ():Number
		{
			return _upBytes;
		}	
		private var _tolBytes
		public function set bytesTotal(v):void
		{
			_tolBytes=v;
		}	
		public function get bytesTotal():Number
		{
			return _tolBytes;
		}	
	}
}