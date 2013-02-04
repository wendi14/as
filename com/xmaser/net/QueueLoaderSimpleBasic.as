package com.xmaser.net 
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author 
	 */
	public class QueueLoaderSimpleBasic 
	{
		private  var _loader:Loader=new Loader();
		 private var _isLoading:Boolean;
		 protected var list:Array=[];
		public function QueueLoaderSimpleBasic() 
		{
			
		}
		public function load(bys:*,callBack:Function,callParams:*=null):void
		{
			list.push({ "b":bys, "f":callBack,"p":callParams })
			if (_isLoading == true)
			{
				return;
			}
			
			_load();
		}
		private function _load():void 
		{
			if (list.length == 0)
			{
				return;
			}
			execute();
			
			
			_isLoading = true;
			/*function onComplete(e:*):*
			{
				
				callBack.call(null, e.target.content.bitmapData);
				_isLoading = false;
				list.pop();
				load()
			}*/
		}
		protected function execute():void
		{
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _onComplete);
			
			var bys:ByteArray = list[0].b;
			var callBack:Function = list[0].f;
			_loader.loadBytes(bys);
		}
		protected function _onComplete(e:Event):void
		{
			/*var bys:ByteArray = list[0].b;
			var callBack:Function = list[0].f;
			
			callBack.call(null, e.target.content.bitmapData);*/
			onComplete( list[0]);
			
			
			_isLoading = false;
			list.pop();
			_load()
		}
		protected function onComplete(da:*):void 
		{
			
			
		}
	}

}