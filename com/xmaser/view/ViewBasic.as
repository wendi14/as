package com.xmaser.view 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ViewBasic extends Sprite 
	{
		protected var _uiClass:Class;
		protected var _mc:*;
		
		public function ViewBasic(uiCla:Class) 
		{
			_uiClass = uiCla;
			drawUI();
			
			if (stage)
			{
				__ADDED_TO_STAGE(null);
			}else
			{
				addEventListener(Event.ADDED_TO_STAGE, __ADDED_TO_STAGE);
			}
			
		}
		
		private function __ADDED_TO_STAGE(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, __ADDED_TO_STAGE);
			init()
		}
		
		protected function init():void 
		{
			
		}
		
		protected function drawUI():void 
		{
			if (_uiClass)
			{
				_mc = new _uiClass();
				addChild(_mc);
			}
		}
		public function destroy():void
		{
			while (this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
			_uiClass = null;
			_mc = null;
		}
		public function get mc():* 
		{
			return _mc;
		}
		protected function postionUImc(added:*,mc1:*):void
		{
			added.x = mc1.x; added.y = mc1.y;
			mc1.visible = false;
		}
		protected function widthAndHeightUImc(added:*, mc1:*):void
		{
			added.width = mc1.width; added.height = mc1.height;
			mc1.visible = false;
		}
		
	}

}