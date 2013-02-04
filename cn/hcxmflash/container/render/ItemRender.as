package cn.hcxmflash.container.render
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
	public class ItemRender extends Sprite
	{
		protected var _data:Object;
		
		public function ItemRender() 
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
		
		
	}

}