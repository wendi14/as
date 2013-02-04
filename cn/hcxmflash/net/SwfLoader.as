package cn.hcxmflash.net 
{
	import flash.display.Loader;
	import flash.events.Event;
	import gs.TweenLite;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class SwfLoader extends Loader
	{
		
		public var widthTrue
		public var heightTrue
		public function SwfLoader() 
		{
			contentLoaderInfo.addEventListener(Event.COMPLETE, __contentLoaderInfoCOMPLETE,false,0,true);
			contentLoaderInfo.addEventListener(Event.INIT, __contentLoaderInfoINIT,false,0,true);
		}
		
		private function __contentLoaderInfoINIT(e:Event):void 
		{
			widthTrue = contentLoaderInfo.width;
			heightTrue = contentLoaderInfo.height;
		}
		private function __contentLoaderInfoCOMPLETE(e:Event):void 
		{
			contentLoaderInfo.removeEventListener(Event.COMPLETE, __contentLoaderInfoCOMPLETE);

			TweenLite.to(this, 0.3, { alpha:1 } );
		}
		
	}

}