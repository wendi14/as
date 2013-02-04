package com.xmaser.display.container 
{
	import com.xmaser.display.component.ComponentBasic;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class VBox extends ComponentBasic 
	{
		private var _vGap:int = 6;
		private var _topGap:int = 0;
		private var _leftGap:int = 0;
		private var _hh:Number = 0;
		public function VBox() 
		{
			_hh = _topGap;
		}
		override public function addChild(child:DisplayObject):flash.display.DisplayObject 
		{
			child.y = _hh;
			var rec:Rectangle = child.getBounds(child);
			child.x = -rec.left + _leftGap;
			//_hh += child.height;
			
			_hh += ( -rec.top + rec.height+_vGap );
			return super.addChild(child);
		}
		
		public function get vGap():int 
		{
			return _vGap;
		}
		
		public function set vGap(value:int):void 
		{
			_vGap = value;
		}
		
		public function get topGap():int 
		{
			return _topGap;
		}
		
		public function set topGap(value:int):void 
		{
			_topGap = value;
			_hh = _topGap;
		}
		
		public function get leftGap():int 
		{
			return _leftGap;
		}
		
		public function set leftGap(value:int):void 
		{
			_leftGap = value;
		}
	}

}