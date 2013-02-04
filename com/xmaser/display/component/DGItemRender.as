package cn.hcxmflash.component
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;

	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class DGItemRender extends Sprite
	{
		protected var _data:Object;
		
		public function DGItemRender() 
		{
			
		}
		public function set data(value:Object):void 
		{
			_data = value
			draw()
		}
		public function get data():Object { return _data; }
		protected function draw():void
		{
			
		}
		
/*		private function __buyCLICK(e:MouseEvent):void 
		{
			dispatchEvent(new HouseEvent("itemClick", true, true, _data));
		}*/
		
		private function __imgCOMPLETE(e:Event):void 
		{
			//e.currentTarget.loader.width=e.currentTarget.
		}
		
	}

}