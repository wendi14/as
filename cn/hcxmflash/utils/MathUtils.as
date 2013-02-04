package cn.hcxmflash.utils 
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class MathUtils
	{
		
		public function MathUtils() 
		{
			
		}
		/**
		 * 同比率缩放对像，正常情况下，是比较短的
		 * @param	w	原始的宽度
		 * @param	h	原始的高度
		 * @param newWidth 要缩放到的宽度
		 * @param newHeight 要缩放到的高度
		 * @return 缩放比率 (最后你要的就是原始的宽和高都乘以缩放比率)
		 */
		public static function scaleSameRatio(w:Number, h:Number,newWidth:Number,newHeight:Number):Number
		{
			var rx:Number = newWidth/w;
			var ry:Number = newHeight/h;
			
			return Math.max(rx, ry);
			
		}
		/**
		 * 同比率缩放对像，正常情况下，是比较短的
		 * @param	rec1 原始的
		 * @param	rec2 要缩放到
		 * @return
		 */
		public static function resizeScaleBySameRatio(rec1:Rectangle,rec2:Rectangle=null):Number
		{
			
			if (rec2 == null)
			{
				rec2 = new Rectangle(0, 0, 50, 50);
			}
			var p:Number;
			
			var w1:Number = rec2.width / rec1.width;
			var h1:Number = rec2.height / rec1.height;
			
			p = Math.max(w1, h1);
			return p;
		}
		public static function getPage(total:int, perPage:int):int
		
		{
			var t1:int = total / perPage;
			if (total % perPage > 0)
			{
				t1++;
			}
			return t1;
			
		}
	}

}