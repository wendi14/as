package com.xmaser.shape 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class DotLine extends Sprite 
	{
		private var _length:int;
		private var _perWidth:int;
		/**
		 * 
		 * @param	length	线的总长度
		 * @param	perWidth	每段的长度
		 */
		public function DotLine(length:int,perWidth:int) 
		{
			_length = length;
			_perWidth = perWidth;
			
			draw()
		}
		
		private function draw():void 
		{
			var total:int = _length / _perWidth;
			
			
		}
		
	}

}