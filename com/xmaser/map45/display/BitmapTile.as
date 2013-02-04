package com.xmaser.map45.display 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author 
	 */
	public class BitmapTile extends GraphicTile 
	{
		
		public function BitmapTile(size:Number,bitmapdata:BitmapData) 
		{
			_graphic= new Bitmap(bitmapdata);
			super(size,_graphic);
			
			
			
		}
		
	}

}