package hcxm.cn.File
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.FileReference;
	import flash.utils.ByteArray;

	public class BaseFile extends EventDispatcher
	{
		protected var _file:FileReference
		protected var _by:ByteArray		
		public function BaseFile(file:FileReference=null)
		{
			if(file)
			{
				_file=file;
			}else
			{
				_file=new FileReference();		
			}
		
			_file.addEventListener(Event.SELECT,_SELECT);
			_file.addEventListener(Event.COMPLETE,_loadCOMPLETE);
			_file.addEventListener(ProgressEvent.PROGRESS,_PROGRESS)
			_file.addEventListener(Event.OPEN,_OPEN)
		}
		protected function _loadCOMPLETE(e:Event):void 
		{
		}	
		protected function _SELECT(e:Event):void 
		{
		}	
		protected function _PROGRESS(e:Event):void 
		{
		}	
		protected function _OPEN(e:Event):void 
		{
		}	
		public function get fileName():String
		{
			return _file.name;
		}		
	}
}