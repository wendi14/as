package  cn.hcxmflash.picture
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import gs.easing.Back;
	import gs.easing.Elastic;
	import gs.easing.Quad;
	import gs.TweenLite;
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class PictureEffect 
	{
		static private var total;
		static private var now:int;
		static private var callbackFunc:Function;
		
		public function PictureEffect() 
		{
			
		}
		public static function showFromSquare(bd:BitmapData,w:int=4,h:int=4,rot:Sprite=null,callback:Function=null):void
		{
			callbackFunc=callback
			var ww:int = bd.width / w;
			
			var hh:int = bd.height / h;
		
			
			total = w * h;
			now=0
			for (var i:int = 0; i < h; i++) 
			{
				for (var j:int = 0; j <w; j++) 
				{
					
					var bd2:BitmapData = new BitmapData(ww, hh);
					bd2.copyPixels(bd, new Rectangle(j*ww, i*hh, ww, hh), new Point())
					var bit:Bitmap = new Bitmap(bd2, "auto", true)
					if (rot)
					{
						rot.addChild(bit)
						bit.x = j * ww;
						bit.y = bd.height + hh;
						TweenLite.to(bit,0.4,{x:j*ww,y:i*hh,delay:i*0.2+j*0.1,ease:Quad.easeOut,onComplete:__oncomplete})
					}
					
				}
				
			}
		}
		
		static private function __oncomplete():void 
		{
			now++
			if (now>=total) 
			{
				
				
				if (callbackFunc!=null) 
				{
					callbackFunc()
				}
			}
		}
		
	}

}