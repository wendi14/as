package hcxm.cn {
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import hcxm.cn.loading.LoadingTiao;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class MyLoader extends Sprite {
		private var _url:String
		private var loader:Loader
		var LTiao:LoadingTiao
		private var _showTiao:Boolean = false
		/**
		 * 用来加载的sprite
		 * @param	url 要被加载的资源的路径
		 * @param	root 这个sprite 是放在哪里的
		 */
		public function MyLoader(url:String,root:Sprite) {
			_url = url;
			loader = new Loader();
			
			loader.load(new URLRequest(url));
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, PROGRESS);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, COMPLETE)
			this.addChild(loader)
			root.addChild(this);

		}
		/**
		 * 设置是否显示加载的进度条
		 */
		public function set showTiao(value:Boolean):void {
			_showTiao = value;
			LTiao=new LoadingTiao()
			addChild(LTiao)
		}
		private function PROGRESS(e:ProgressEvent):void {
			if (_showTiao) {
				LTiao.move(e.bytesLoaded/e.bytesTotal)
			}
		}		
		private function COMPLETE(e:Event):void {
			if (_showTiao) {		
				LTiao.comple()
			}else {
				
			}
		}
	}
	
}