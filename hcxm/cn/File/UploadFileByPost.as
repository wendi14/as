package hcxm.cn.File
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;

	public class UploadFileByPost extends EventDispatcher
	{
		private var uploadPath:String;
		private var urlrequ:URLRequest
		private var urlloader:URLLoader
		/**
		 * 
		 * @param	path	上传的地址
		 */
		public function UploadFileByPost(path:String)
		{
			this.uploadPath=path;
			
		}
		/***
		 * 上传单个文件
		 * */
		public function upload(fileName:String,byt:ByteArray,para:Object=null):void
		{
			
			urlrequ=new URLRequest(uploadPath);
			urlrequ.contentType= 'multipart/form-data; boundary=' +UploadPost.getBoundary()
			urlrequ.method=URLRequestMethod.POST;
			urlrequ.data=UploadPost.getPostData(fileName,byt,para);
			urlrequ.requestHeaders.push( new URLRequestHeader( 'Cache-Control', 'no-cache' ));
			
			urlloader=new URLLoader();
			urlloader.dataFormat=URLLoaderDataFormat.BINARY;
			urlloader.load(urlrequ);
			urlloader.addEventListener(Event.COMPLETE,_loadComplete)
			urlloader.addEventListener(ProgressEvent.PROGRESS,_PROGRESS)
		}
		private function _loadComplete(e:Event):void
		{
			if(!isMuti)
			{
				dispatchEvent(new Event(Event.COMPLETE))
			}else
			{
				upedNum++;
				if(upedNum==needUpTotal)
				{
					dispatchEvent(new Event(Event.COMPLETE))
				}else
				{
					_upOneToOne()
				}
				
			}
			
		}
		private function _PROGRESS(e:ProgressEvent):void
		{
			if(nowPrevLo)
			{
				nowPrevLo.bytesLoaded=e.bytesLoaded;
			nowPrevLo.bytesTotal=e.bytesTotal;
			}
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS,true,false,e.bytesLoaded,e.bytesTotal));
			
		}
		var nowPrevLo:PreviewLocalImage;
		var isMuti:Boolean=false;//是否是上传多个文件?
		var upedNum:int=0;//上传了几个了
		var needUpTotal;
		var muArr:Array
		public function uploadMutil(arr:Array):void
		{
			needUpTotal=arr.length;
			isMuti=true;
			muArr=arr;
			_upOneToOne()
		}
		private function _upOneToOne():void
		{
			nowPrevLo=muArr[upedNum];
			upload(nowPrevLo.fileName,nowPrevLo.bytearr);
		}
		
	}
}