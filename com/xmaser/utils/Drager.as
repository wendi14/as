package com.xmaser.utils 
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author 小火柴
	 */
	public class Drager 
	{
		private var _mouseDownObject:Sprite;
		private var _moveObject:Sprite;
		private var _disable:Boolean;
		/**
		 * 拖动类
		 * @param	mouseDownObject	鼠标点击的
		 * @param	moveObject	真正要移动的
		 */
		public function Drager(mouseDownObject:Sprite,moveObject:Sprite=null) 
		{
			_moveObject = moveObject;
			_mouseDownObject = mouseDownObject;
			if (moveObject == null)
			{
				_moveObject = _mouseDownObject;
			}
		
			if (mouseDownObject.stage)
			{
				addEventListen()
			}else 
			{
				mouseDownObject.addEventListener(Event.ADDED_TO_STAGE, __ADDED_TO_STAGE);
			}
		}
		public function destory():void
		{
			disable();
			_moveObject = _mouseDownObject = null;
			
		}
		public function enable():void
		{
			_disable = false;
			addEventListen()
		}
		public function disable():void
		{
			_disable = true;
			_mouseDownObject.removeEventListener(MouseEvent.MOUSE_DOWN, __MOUSE_DOWN);
		}
		private function __ADDED_TO_STAGE(e:Event):void 
		{
			_mouseDownObject.removeEventListener(Event.ADDED_TO_STAGE, __ADDED_TO_STAGE);
			addEventListen()
		}
		
		private function addEventListen():void 
		{
			_mouseDownObject.addEventListener(MouseEvent.MOUSE_DOWN, __MOUSE_DOWN);
			_mouseDownObject.stage.addEventListener(MouseEvent.MOUSE_UP, __MOUSE_UP);
			if (_disable)
			{
				_mouseDownObject.stage.removeEventListener(MouseEvent.MOUSE_UP, __MOUSE_UP);
			}
		}
		
		private function __MOUSE_UP(e:MouseEvent):void 
		{
			_moveObject.stopDrag();
		}
		
		private function __MOUSE_DOWN(e:MouseEvent):void 
		{
			_moveObject.startDrag();
		}
		
	}

}