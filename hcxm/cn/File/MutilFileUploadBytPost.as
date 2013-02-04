package hcxm.cn.File
{
	import flash.events.Event;
	
	import hcxm.cn.Math.Util;
	
	import mx.collections.ArrayCollection;
	[Bindable]
	public class MutilFileUploadBytPost extends MutilFile
	{
		private var _fileArr:Array
		
		public var dataProvider:ArrayCollection
		public function MutilFileUploadBytPost()
		{
			
		}
		override protected function _SELECT(e:Event):void
		{
			_fileArr=_File.fileList;
			var resarr:Array=[]
			for(var i:int=0;i<_fileArr.length;i++)
			{
				var bas:PreviewLocalImage=new PreviewLocalImage(_fileArr[i]);
				bas.load();
				resarr.push(bas);
			}
			dataProvider=new ArrayCollection(resarr);
			dispatchEvent(new Event(Event.SELECT_ALL));
		}
		public function removeItemAtIndex(ar:Array):void
		{
			if(ar.length<=1)
			{
				dataProvider.removeItemAt(ar[0]);
				return;
			}
			var arrc:Array=[]
			for(var i:int=0;i<ar.length;i++)
			{
				var adminindex=ar[i]
				for(var j:int=adminindex;j<dataProvider.length;j++)
				{
					if(j==adminindex)
					{
						dataProvider.setItemAt(null,j);
					}
				}			
			}		
			checkNull()
			
		}
		//删除空的	item;
		private function checkNull():void
		{
			var isN=false;
			for(var j:int=0;j<dataProvider.length;j++)
			{
				var o=dataProvider.getItemAt(j);
				if(o==null)
				{
					dataProvider.removeItemAt(j);
					isN=true;
					dataProvider.refresh()
					break;
				}
			}
			if(isN)
			{
				checkNull()
			}
		}
	}
}