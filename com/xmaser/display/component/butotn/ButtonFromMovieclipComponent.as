package com.xmaser.display.component.butotn 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author wdc
	 */
	public class ButtonFromMovieclipComponent 
	{
		protected var _mc:MovieClip;
		protected var _clickFunc:Function;
		protected var _frameType:String=FRAME_TYPE_NUMBER;
		static public const FRAME_TYPE_NUMBER:String = "frameTypeNumber";
		static public const FRAME_TYPE_LABEL:String = "frameTypeLabel";
		public function ButtonFromMovieclipComponent(mc:MovieClip,clickFunc:Function=null) 
		{
			this._clickFunc = clickFunc;
			this.mc = mc;
			mc.stop();
			mc.addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
			mc.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			mc.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			mc.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			mc.mouseChildren = false;
			if (this._clickFunc!=null) 
			{
				//mc.addEventListener(MouseEvent.CLICK, onClick);
			}
			mc.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		public function set frameType(value:String):void 
		{
			_frameType = value;
		}
		
		public function get mc():MovieClip 
		{
			return _mc;
		}
		
		public function set mc(value:MovieClip):void 
		{
			_mc = value;
		}
		
		public function get clickFunc():Function 
		{
			return _clickFunc;
		}
		private function onClick(e:MouseEvent):void 
		{
			this._clickFunc();
		}
		
		private function onRemovedFromStage(e:Event):void 
		{
			destroy();
			e.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			mc = null;
		}
		
		protected function onMouseOver(e:MouseEvent):void 
		{
			if (_frameType == FRAME_TYPE_LABEL)
			{
				mc.gotoAndStop("over");
			}else 
			{
				mc.gotoAndStop(2);
			}
			
		}
		
		protected function onMouseOut(e:MouseEvent):void 
		{
			//trace( "onMouseOut : " + onMouseOut );
			
			if (_frameType == FRAME_TYPE_LABEL)
			{
				mc.gotoAndStop("out");
			}else 
			{
				mc.gotoAndStop(3);
			}
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			
			if (_frameType == FRAME_TYPE_LABEL)
			{
				mc.gotoAndStop("down");
			}else 
			{
				mc.gotoAndStop(4);
			}
		}
		
		protected function onMouseUp(e:MouseEvent):void 
		{
			
			if (_frameType == FRAME_TYPE_LABEL)
			{
				mc.gotoAndStop("up");
			}else 
			{
				mc.gotoAndStop(1);
			}
			
			if (this._clickFunc!=null)
			{
				this._clickFunc();
			}
		}
		public function destroy():void
		{
			removeEvents();
			mc = null;
			
		}
		public function addEvents():void
		{
			mc.gotoAndStop(1);
			mc.addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
			mc.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			mc.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			mc.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			if (this._clickFunc!=null)
			{
				//mc.addEventListener(MouseEvent.CLICK, onClick);
			}
		}
		public function removeEvents():void
		{
			if (!mc) return;
			mc.removeEventListener(MouseEvent.ROLL_OVER, onMouseOver);
			mc.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			mc.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			mc.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
	}

}