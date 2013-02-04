package com.xmaser.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class MenuEvent extends Event
	{
		public var data:*;
		
		
		public static const MENU_SELECTED:String = "menuSelected"
		
		
		public function MenuEvent(type:String,data:*=null,bubbles:Boolean=false,cancelable:Boolean=false) 
		{
			
			super(type, bubbles, cancelable);
			this.data = data;
		}
		override public function clone():Event 
		{
			return new MenuEvent(type,data,bubbles,cancelable)
		}
	}

}