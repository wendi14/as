package com.xmaser.utils 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author 小火柴
	 */
	public class Utils 
	{
		
		public function Utils() 
		{
			
		}
		public static function resizeMc(mc:*,newRec:Rectangle=null):void
		{
			var per:Number = Utils.resizeScale(new Rectangle(0, 0, mc.width, mc.height),newRec);	
			mc.scaleX = mc.scaleY = per;
		}
		
		public static function resizeScale(recOld:Rectangle,recNew:Rectangle=null):Number
		{
			
			if (recNew == null)
			{
				recNew = new Rectangle(0, 0, 50, 50);
			}
			var p:Number;
			
			var w1:Number = recNew.width / recOld.width;
			var h1:Number = recNew.height / recOld.height;
			
			if (recOld.size > recNew.size)
			{
				p = Math.max(w1, h1);
			}else
			{
				p = Math.min(w1, h1);
			}
			return p;
		}
		
		static public function alignCenterMc(mc:DisplayObject, rectangle:Rectangle):void 
		{
			var rec:Rectangle = mc.getBounds(mc.parent);
			var rec2:Rectangle = mc.getBounds(mc);
			mc.x -= rec2.left;
			mc.y -= rec2.top;
			mc.x += (rectangle.width / 2 - rec.width / 2);
			mc.y += (rectangle.height / 2 - rec.height / 2);
		}
	}

}