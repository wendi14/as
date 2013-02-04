package com.xmaser.map45.utils 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class ISOUtils 
	{
		// 1.2247的精确计算版本
		public static const Y_CORRECT:Number = Math.cos(-Math.PI / 6) * Math.SQRT2;
		public function ISOUtils() 
		{
			
		}
		public static function iso2screen(point3d:Point3D):Point
		{
			var sx:Number = point3d.x - point3d.z;
			var sy:Number = point3d.y * Y_CORRECT + (point3d.x + point3d.z) * 0.5;
			return new Point(sx, sy);
		}
		public static function screen2iso(p:Point):Point3D
		{
			var x1:Number = p.y + p.x / 2;
			var y1:Number = 0;
			var z1:Number = p.y - p.x / 2;
			return new Point3D(x1, y1, z1);
		}
		
	}

}