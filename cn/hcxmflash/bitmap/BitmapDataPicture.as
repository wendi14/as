package cn.hcxmflash.bitmap  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author 
	 */
	public class BitmapDataPicture extends Object 
	{
		private var _bd:BitmapData;
		
		public function BitmapDataPicture(bp:*) 
		{
			if (bp is Bitmap) 
			{
				_bd = Bitmap(bp).bitmapData;
			}else if(bp is BitmapData) 
			{
				_bd = bp;
			}
		}
		public function getRectangleBitmapdata(rec:Rectangle):BitmapData
		{
			//trace( "rec : " + rec );
			var bd:BitmapData = new BitmapData(rec.width, rec.height, true)
			bd.setVector(new Rectangle(0,0,rec.width,rec.height), _bd.getVector(rec));
			return bd;
		}
		public function clearColor(bitmapdata:BitmapData,co:uint=0xFF678B):BitmapData
		{
			for (var i:int = 0; i < bitmapdata.height; i++) 
			{
				for (var j:int = 0; j < bitmapdata.width; j++) 
				{
					
					var c:uint = bitmapdata.getPixel(j, i)
					if (c == co)
					{
						bitmapdata.setPixel32(j, i, 0x00000000);
					}
					
				}
				
			}
			return bitmapdata
		}
		
	}

}