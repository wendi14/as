package hcxm.cn.File
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.FileReferenceList;
	
	
	
	[Event(name="selectAll", type="flash.events.Event")]
	
	
	public class MutilFile extends EventDispatcher
	{
		
		protected var _File:FileReferenceList
		private var _fileArray:Array=[]
		public function MutilFile(typeFilter:Array=null)
		{
			_File=new FileReferenceList()
			_File.browse(typeFilter);
			_File.addEventListener(Event.SELECT,_SELECT)
		}
		
		protected function _SELECT(e:Event):void 
		{
			_fileArray=_File.fileList;
			dispatchEvent(new Event(Event.SELECT_ALL));
		}
		
		public function get FileArray():Array
		{
			return _fileArray;
		}
	}
}