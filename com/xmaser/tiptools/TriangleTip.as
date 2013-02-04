package com.xmaser.tiptools 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author 小火柴
	 */
	public class TriangleTip extends Sprite
	{
		private var _bgGshap:Shape;
		private var _ww:int=100;
		private var _hh:int=60;
		private var _arrowWidth:Number=20;
		private var _arrowHeight:Number=20;
		private var _arrowPoint:Point;//箭头朝向的坐标>
		private var _arrowPositionX:int;//箭头左起的X位置
		public function TriangleTip() 
		{
			drawBG()
		}
		
		private function drawBG():void 
		{
			_bgGshap = new Shape()
			addChild(_bgGshap);
			
			_bgGshap.graphics.lineStyle(1, 0);
			
			_bgGshap.graphics.lineTo(_ww, 0)
			_bgGshap.graphics.lineTo(_ww, _hh)
			_bgGshap.graphics.lineTo(_ww/2+_arrowWidth/2, _hh);
			
			//箭头
			if (_arrowPoint == null)
			{
				_arrowPoint.x = _ww / 2;
				_arrowPoint.y = _hh + _arrowHeight;
			}
			/*_bgGshap.graphics.lineTo(_ww / 2, _hh + _arrowHeight);
			_bgGshap.graphics.lineTo(_ww / 2 - _arrowWidth / 2, _hh);*/

			
			_bgGshap.graphics.lineTo(0, _hh);
			_bgGshap.graphics.lineTo(0, 0)
			
			
			
			_bgGshap.graphics.endFill();
			
			
		}
		
	}

}