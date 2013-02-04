package cn.hcxmflash.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class Event_ extends Event
	{
		public var data:*;
		public static const ORDER:String = 'ORDER';//下棋
		public static const ORDER_other:String = 'ORDER_other';//另一方下的棋
		public static const DESK_INFO:String = 'deskinfo';
		public static const GAME_OVER:String = 'gameover';
		
		
		public static const NEXT:String = "next";
		public static const PREV:String = "prev";
		public static const STOP:String = "stop";
		static public const PLAY:String = "play";
		static public const PAUSE:String = "pause";
		static public const OPEN:String = "open";
		static public const PROGRESS:String = "progress";
		
		public static const ITEM_CLICK:String = "itemClick"
		
		static public const LOADER_COMPLETE:String = "loaderComplete";
		static public const SELECTED:String = "selected";
		public function Event_(type:String,data:*=null,bubbles:Boolean=false,cancelable:Boolean=false) 
		{
			
			super(type, bubbles, cancelable);
			this.data = data;
		}
		override public function clone():Event 
		{
			return new Event_(type,data,bubbles,cancelable)
		}
	}

}