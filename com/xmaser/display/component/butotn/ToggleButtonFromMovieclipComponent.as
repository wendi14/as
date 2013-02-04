package com.xmaser.display.component.butotn 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author wdc
	 */
	public class ToggleButtonFromMovieclipComponent extends ButtonFromMovieclipComponent
	{
		private var _selected:Boolean = false;
		private var _clickFunc2:Function;
		public function ToggleButtonFromMovieclipComponent(mc:MovieClip,clickFunc:Function=null) 
		{
			super(mc, clickFunc);
			
		}
		override protected function onMouseUp(e:MouseEvent):void 
		{
			e.stopImmediatePropagation();
			//super.onMouseUp(e);
		
			if (_selected == false)
			{
					_selected = true;
				
			}else 
			{
				_selected = false;
				
			}
			gotoSelected();
			if (this._clickFunc!=null)
				{
					this._clickFunc(mc);
				}
				if (this.clickFunc2!=null) 
				{
					this.clickFunc2.call(null, this);
				}
		}
		override public function destroy():void 
		{
			super.destroy();
			this._clickFunc2 = null;
		}
		private function gotoSelected():void 
		{
			if (_selected == true)
			{
				if (_frameType ==ButtonFromMovieclipComponent. FRAME_TYPE_LABEL)
				{
					mc.gotoAndStop("selected");
				}else 
				{
					mc.gotoAndStop(5);
				}				
				//removeEvents();
				
				
			
				
			}else
			{
				if (_frameType ==ButtonFromMovieclipComponent. FRAME_TYPE_LABEL)
				{
					mc.gotoAndStop("up");
				}else 
				{
					mc.gotoAndStop(1);
				}	
				//addEvents();

			}
		}
		override protected function onMouseOut(e:MouseEvent):void 
		{
			if (_selected == false)
			{
				if (_frameType == FRAME_TYPE_LABEL)
				{
					mc.gotoAndStop("out");
				}else 
				{
					mc.gotoAndStop(3);
				}
			}else
			{
				if (_frameType == FRAME_TYPE_LABEL)
				{
					mc.gotoAndStop("up");
				}else 
				{
					mc.gotoAndStop(5);
				}
			}
		}
		override protected function onMouseOver(e:MouseEvent):void 
		{
			if (_selected == false)
			{
				if (_frameType == FRAME_TYPE_LABEL)
				{
					mc.gotoAndStop("over");
				}else 
				{
					mc.gotoAndStop(2);
				}
			}else
			{
				if (_frameType == FRAME_TYPE_LABEL)
				{
					mc.gotoAndStop("over");
				}else 
				{
					mc.gotoAndStop(5);
				}
			}
		}
		public function get selected():Boolean 
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void 
		{
			_selected = value;
			gotoSelected();
		}
		
		public function get clickFunc2():Function 
		{
			return _clickFunc2;
		}
		
		public function set clickFunc2(value:Function):void 
		{
			_clickFunc2 = value;
		}
		
		
	}

}