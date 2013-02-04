package com.xmaser.net
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	
	import nl.demonsters.debugger.MonsterDebugger;

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
//			urlrequ.contentType= 'multipart/form-data; boundary=' +UploadPost.getBoundary()
			urlrequ.method=URLRequestMethod.POST;
			urlrequ.data=UploadPost.getPostData(fileName,byt,para);
			urlrequ.requestHeaders.push( new URLRequestHeader( 'Cache-Control', 'no-cache' ));
			
			urlloader=new URLLoader();
			urlloader.addEventListener(Event.COMPLETE,_loadComplete)
			urlloader.addEventListener(ProgressEvent.PROGRESS,_PROGRESS)
			urlloader.dataFormat=URLLoaderDataFormat.BINARY;
			urlloader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,_er)
		
				urlloader.load(urlrequ);
			
			
		}
		private function _er(e:SecurityErrorEvent):void
		{
			trace(e)
		}
		public function stopUpload():void
		{
			if(urlloader)
			{
				urlloader.close();
			}
		}
		private function _loadComplete(e:Event):void
		{
			
			dispatchEvent(new Event(Event.COMPLETE))
			
		}
		private function _PROGRESS(e:ProgressEvent):void
		{
			nl.demonsters.debugger.MonsterDebugger.trace(this,[e.bytesLoaded,e.bytesTotal]);
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS,true,true,e.bytesLoaded,e.bytesTotal));
			
		}

		
	}
}