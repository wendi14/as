package cn.hcxmflash.utils 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class Drager extends EventDispatcher
	{
		private var _mc:Sprite
		private var _click:InteractiveObject
		public function Drager(mc:Sprite,clickedMc:InteractiveObject=null) 
		{
			_mc = mc;
			_click = clickedMc;
			if (clickedMc == null)
			{
				_click = _mc;
			}
			if (mc.stage) 
			{
				init()
			}else
			{
				mc.addEventListener(Event.ADDED_TO_STAGE, __mcADDED_TO_STAGE);
			}
		}
		public function stop():void
		{
			_mc.stopDrag();
		}
		private function __mcADDED_TO_STAGE(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, __mcADDED_TO_STAGE);
			init()
		}
		
		private function init():void
		{
			_click.addEventListener(MouseEvent.MOUSE_DOWN, __mcMOUSE_DOWN);

		}
		
		private function __mcMOUSE_UP(e:MouseEvent):void 
		{
			_mc.stopDrag();
			
			dispatchEvent(e);
			_mc.stage.removeEventListener(MouseEvent.MOUSE_UP, __mcMOUSE_UP);
		}
		
		private function __mcMOUSE_DOWN(e:MouseEvent):void 
		{
			_mc.stage.addEventListener(MouseEvent.MOUSE_UP, __mcMOUSE_UP);
			_mc.startDrag();
		}
		
	}

}