package com.xmaser.mouse 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.ui.MouseCursorData;
	/**
	 * ...
	 * @author wdc
	 */
	public class MouseCursor 
	{
		
		public function MouseCursor() 
		{
			
		}
		public static function defaultCursor():void
		{
			Mouse.cursor = flash.ui.MouseCursor.AUTO;
		}
		public static function setCursor(cursorName:String,data:Vector.<BitmapData>, fps:uint = 1,hotSpot:Point=null):void
		{
			var mouseCursorData:MouseCursorData = new MouseCursorData();
            mouseCursorData.data = data;
            mouseCursorData.frameRate = fps;
			if (hotSpot) 
			{
				mouseCursorData.hotSpot = hotSpot;
			}
            
            Mouse.registerCursor( cursorName, mouseCursorData );
            Mouse.cursor = cursorName;
		}
		
		public static function removeCursor(cursorName:String):void
		{
			Mouse.unregisterCursor(cursorName);
			
		}
	}

}