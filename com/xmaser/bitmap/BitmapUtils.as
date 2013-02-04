package com.xmaser.bitmap 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author 
	 */
	public class BitmapUtils 
	{
		
		public function BitmapUtils() 
		{
			
		}
		/**
		 * 从一行中提取出图像
		 * @param	bd
		 * @param	rec
		 * @return
		 */
		public static function buildRows(bd:BitmapData,rec:Rectangle):Array
		{
			var bps:Array = new Array(Math.ceil(bd.width / rec.width));
			
			for (var i:int = 0; i < bps.length; i++) 
			{
				rec.x = i * rec.width;
				var item: BitmapData = new BitmapData(rec.width, rec.height, true, 0x00000000);
				item.copyPixels(bd, rec, new Point());
				bps[i] = new Bitmap( item, "auto", true);
			}
			
			return bps
		}	
		
		public static function buildCols(bd:BitmapData,rec:Rectangle):Array
		{
			var bps:Array = new Array(Math.ceil(bd.height / rec.height));
			
			for (var i:int = 0; i < bps.length; i++) 
			{
				rec.y = i * rec.height;
				
				var item: BitmapData = new BitmapData(rec.width, rec.height, true, 0x00000000);
				item.copyPixels(bd, rec, new Point());
				bps[i] = item;
			}
			
			return bps
		}
		public static function buildRowCol(bd:BitmapData, rowNum:int, colNum:int,rectangle:Rectangle=null):Array
		{
			var bps:Array = [];
			
			var rec:Rectangle = new Rectangle();
			rec.width = bd.width / rowNum;
			rec.height = bd.height / colNum;
			if (rectangle) 
			{
				rec = rectangle;
			}
			for (var i:int = 0; i < colNum; i++) 
			{
				rec.y = i*rec.height;
				for (var j:int = 0; j <rowNum; j++) 
				{
					rec.x = j * rec.width;
					
					var item: BitmapData = new BitmapData(rec.width, rec.height, true, 0x00000000);
					item.copyPixels(bd, rec, new Point());
					bps.push(item);
					
					
				}
				
			}
			return bps;
		}
			/**
		 * 返回MovieClip中每一帧的bitmapdata数据
		 * @param	mc
		 * @return
		 */
		
		public static function drawMcToBitmapdatas(mc:MovieClip):Array
		{
			
			var bdArr:Array = [];
			
			var tol:int = mc.totalFrames;
			var bd:BitmapData;
			var rec:Rectangle = mc.getBounds(mc);
			var ww:Number = rec.width;
			var hh:Number = rec.height;
			var ma:Matrix = new Matrix();
			ma.tx -= rec.left;
			ma.ty -= rec.top;
			for (var i:int = 0; i < tol; i++) 
			{
				mc.gotoAndStop(i + 1);
				bd = new BitmapData(ww, hh, true, 0x00000000);
				bd.draw(mc, ma);
				bdArr.push(bd);
				
			}
			return bdArr;
		}
		
		/**
		 * 抠图
		 * 从透明图像中，把不包含图像的多余透明部分去除掉
		 * @param	bd
		 */
		public static function mattingPNG(bd:BitmapData):BitmapData
		{
			var rec:Rectangle = bd.getColorBoundsRect(0xff000000, 0x00000000, false);
			
			//var b2:BitmapData = new BitmapData(rec.width, rec.height, false,0xcccccc);
			var b2:BitmapData = new BitmapData(rec.width, rec.height);
			b2.copyPixels(bd, rec, new Point())
			bd.dispose();
			
			return b2;
		}
		
		
		
	}

}