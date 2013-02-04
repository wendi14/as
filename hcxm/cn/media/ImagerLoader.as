package hcxm.cn.media
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.display.MovieClip;
	import hcxm.cn.event.Event_;
	
	
	public class ImagerLoader extends Sprite
	{
		protected var loader:Loader;
		private var _bitmapdata;
		private var _progressBar:ImageProgressBar
		
		public var bytesLoaded
		public var bytesTotal
		public var loadPercent;
		public var percentLabel="%";//显示进度的时候后面的标签
		public var URL:String;//被加载的地址
		
		public var data
		
		public static const LOAD_COMPLETE:String="loadComplete"
		/**
		 * @param	url		图片的地址
		 * @param	autoStart		是否自动加载，默认为ture（自动加载），如果为fasle，则要手动调用 startLoad() 函数;
		 * */
		public function ImagerLoader(url:String=null,autoStart:Boolean=true)
		{
			loader=new Loader();
			if (url != null)
			{
				URL = url;
				if(autoStart)
				{
					startLoad()
				}
			}
			loader.contentLoaderInfo.addEventListener(Event.INIT,_COMPLETE);
			loader.contentLoaderInfo.addEventListener(Event.OPEN,_onStart)
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, _PROGRESS);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,_IO_ERROR)
			addChild(loader);
		}
		
		private function _IO_ERROR(e:IOErrorEvent):void 
		{
			trace("e:"+e)
		}
		public function manualLoad(url:String):void
		{
			this.URL = url;
			startLoad()
		}
		public function startLoad():void
		{

			loader.load(new URLRequest(this.URL));
			if(_progressBar)
			{
				_progressBar.visible=true;
			}
		}
		private function _onStart(e:Event):void
		{
			if(_progressBar)
			{
				_progressBar.source=this;
				_progressBar.visible=true;
			}
		}
		private function _PROGRESS(e:ProgressEvent):void
		{
			bytesLoaded=e.bytesLoaded;
			bytesTotal=e.bytesTotal;
			loadPercent=Math.round(bytesLoaded/bytesTotal*100)+percentLabel;
			if(_progressBar)
			{
				dispatchEvent(new Event_(Event_.PROGRESS,{bytesLoaded:bytesLoaded,bytesTotal:bytesTotal}));
			}
		}
		public var content
		private function _COMPLETE(e:Event):void
		{
			var bitm:Bitmap = loader.content as Bitmap;
			content = bitm;
			_bitmapdata=bitm.bitmapData;
			dispatchEvent(new Event(LOAD_COMPLETE));

			if(_progressBar)
			{
				_progressBar.clear();
				_progressBar=null;
			}
		}
		
		public function setProgressBar(sp:ImageProgressBar,xx:Number=0,yy:Number=0)
		{
			_progressBar=sp;
			addChild(_progressBar);
			_progressBar.visible = false;
			if (xx)
			{
				_progressBar.x=xx
			}
			if (yy)
			{
				_progressBar.y = yy;
			}
		}
		
		public function get bitmapdata():BitmapData
		{
			return _bitmapdata;
		}

	}
}