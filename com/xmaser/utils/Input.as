package com.xmaser.utils 
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author wdc
	 */
	public class Input 
	{
		static private var _stage:Stage;
		static private var _isDown:Boolean;
		static public var activate:Boolean=true;
		
		public function Input() 
		{
			
		}
		public static function register(stage:Stage):void
		{
			_stage = stage;
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			//stage.addEventListener(Event.DEACTIVATE, onDeactivate);
			//stage.addEventListener(Event.ACTIVATE, onActivate);
		}
		public static function isPressed():Boolean
		{
			if (_stage == null)
			{
				throw new Error('没有 register ')
			}
			//trace( "_isDown : " + _isDown );
			return _isDown ;
		}
		static private function onMouseDown(e:MouseEvent):void 
		{
			_isDown = true;
			
		}
		
		static private function onMouseUp(e:MouseEvent):void 
		{
			
		}
		static private function onActivate(e:Event):void 
		{
 
			activate = true;
		}
		
		static private function onDeactivate(e:Event):void 
		{
			//trace( "onDeactivate : " + onDeactivate );
			activate = false;
			
		}
	}

}