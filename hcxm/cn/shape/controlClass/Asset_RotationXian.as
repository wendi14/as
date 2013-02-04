package hcxm.cn.shape.controlClass
{
	import flash.display.Sprite;
	
	import hcxm.cn.shape.GDashedLine;
	public class Asset_RotationXian extends Sprite
	{
		public static const dw:int=4;
		public function Asset_RotationXian()
		{
			super();
			this.graphics.lineStyle(1,ScaleControler.LineColor);
			this.graphics.beginFill(0xffffff);
			this.graphics.drawCircle(0,0,dw)
			this.graphics.endFill();
		}
		public function drawLine(ex,ey):void
		{
				
				
				var myDashedDrawing:GDashedLine = new GDashedLine(this, 4, 4);
				myDashedDrawing.lineStyle(2,0x666666,1)
				myDashedDrawing.moveTo(0, 0);
				myDashedDrawing.lineTo(ex, ey);

		}
	}
}