package com.xmaser.display.container.render.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class ItemRenderEvent extends Event 
	{
		[Event(name = "resize", type = "com.xmaser.display.container.render.events.ItemRenderEvent")]
		public static const RESIZE:String = "resize";
		public function ItemRenderEvent(type:String,bubbles:Boolean=false,cancelable:Boolean=false) 
		{
			super(type,bubbles,cancelable)
		}
		
	}

}