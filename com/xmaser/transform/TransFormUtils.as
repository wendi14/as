package com.xmaser.transform 
{
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author 小火柴
	 */
	public class TransFormUtils 
	{
		
		public function TransFormUtils() 
		{
			
		}
		/**
		 * 缩放
		 * @param	mc
		 * @param	scaleX
		 * @param	scaleY
		 * @param	align 
		 */
		public static function scale(mc:DisplayObject,scaleX:Number,scaleY:Number,align:String='center'):void
		{
			

			var ma:Matrix=mc.transform.matrix;
			var oldX:Number=ma.tx;
			var oldY:Number=ma.ty;
			var oldRect:Rectangle = mc.transform.pixelBounds;
			
			var perX:Number=1.4;
			var perY:Number=1.4;;
			//ma.scale(perX,perY);
			ma.a = scaleX; ma.d = scaleY;
			mc.transform.matrix=ma;;
			var newRect:Rectangle = mc.transform.pixelBounds
		
			ma.tx-=(newRect.x+newRect.width/2)-(oldRect.x+oldRect.width/2);
			ma.ty-=(newRect.y+newRect.height/2)-(oldRect.y+oldRect.height/2);

			mc.transform.matrix=ma;;
			

		}
	}

}