package com.xmaser.display.container.render
{
	import com.xmaser.display.component.ComponentBasic;
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
	public class ItemRender extends  ComponentBasic
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
		override public function destory():void 
		{
			super.destory();
			_data = null;
		}
		
		
		
	}

}