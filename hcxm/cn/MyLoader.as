package hcxm.cn {
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	import hcxm.cn.event.Event_;
	import hcxm.cn.loading.LoadingTiao_As;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class MyLoader extends Sprite {
		private var _url:String
		private var loader:Loader
		var LTiao:LoadingTiao_As;
		private var _showTiao:Boolean = false
		/**
		 * 用来加载的sprite
		 * @param	url 要被加载的资源的路径
		 * @param	root 这个sprite 是放在哪里的
		 */
		public function MyLoader(url:String) {
			_url = url;
			loader = new Loader();
			
			loader.load(new URLRequest(url));
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, PROGRESS);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, COMPLETE);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,_IO_ERROR);
			this.addChild(loader)


		}
		/**
		 * 设置是否显示加载的进度条
		 */
		public function set showTiao(value:Boolean):void {
			_showTiao = value;
			LTiao=new LoadingTiao_As()
			addChild(LTiao)
		}
		private function PROGRESS(e:ProgressEvent):void {
			if (_showTiao) {
				LTiao.move(e.bytesLoaded/e.bytesTotal)
			}
		}
		private function COMPLETE(e:Event):void {
			//Debug.trace(_url,Debug.LEVEL_ERROR)
			//Debug.trace(e.target.width,Debug.LEVEL_FATAL)
			dispatchEvent(new Event_(Event.COMPLETE,{width:e.target.width,height:e.target.height},true,true));
			if (_showTiao) {
				setTime();
			}else {
				
			}
		}
		/**
		 * 加载完成后，再多停留个0.5秒，然后再把进度条删除
		 */
		private function setTime() {
			var timer:Timer = new Timer(500, 1);
			timer.start();
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,TIMER_COMPLETE)
		}
		
		private function TIMER_COMPLETE(e:TimerEvent):void {
			LTiao.comple()
		}
		
		private function _IO_ERROR(e:IOErrorEvent):void
		{
			
		}
	}
	
}
