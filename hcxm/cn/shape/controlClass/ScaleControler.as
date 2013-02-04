package hcxm.cn.shape.controlClass
{
	import flash.display.Sprite;
	
	import hcxm.cn.event.Event_;
	import hcxm.cn.shape.DragedSprite;
	import hcxm.cn.shape.GDashedLine;
	
	public class ScaleControler extends Sprite
	{
		public static const LineThickness:Number=2;
		public static const LineColor:uint=0x666666;
		
		
		
		public function ScaleControler()
		{
			this.mouseEnabled=false;
		}
		var dianArr:Array=[]
		public var Ower:DragedSprite
		public function show(xx,yy,ww,hh,rx,ry):void
		{
			this.xx=xx
			this.yy=yy
			this.ww=ww;
			this.hh=hh;
			dianArr=[
			{x:xx,y:yy,dir:ScaleDirConst.ScaleB1,xo:-12,yo:-12},
			{x:xx+ww/2,y:yy,dir:ScaleDirConst.ScaleV,xo:-2,yo:-4},
			{x:xx+ww,y:yy,dir:ScaleDirConst.ScaleB2,xo:-12,yo:-12},
			{x:xx+ww,y:yy+hh/2,dir:ScaleDirConst.ScaleH,xo:-5,yo:-4},
			{x:xx+ww,y:yy+hh,dir:ScaleDirConst.ScaleB1,xo:-12,yo:-12},
			{x:xx+ww/2,y:yy+hh,dir:ScaleDirConst.ScaleV,xo:-2,yo:-4},
			{x:xx,y:yy+hh,dir:ScaleDirConst.ScaleB2,xo:-12,yo:-12},
			{x:xx,y:yy+hh/2,dir:ScaleDirConst.ScaleH,xo:-5,yo:-4}]
			
		/* 	var ga:Graphics=this.graphics;
			ga.lineStyle(1)
			ga.beginFill(0x000000,0.1)
			ga.drawRect(xx,yy,ww,hh);
			ga.endFill(); */
			
			
			
			for(var i:int=0;i<8;i++)
			{
				var asc:Asset_Scale=new Asset_Scale()
				asc.x=dianArr[i].x
				asc.y=dianArr[i].y
				asc.scale_dir=dianArr[i].dir;
				asc.xo=dianArr[i].xo;
				asc.yo=dianArr[i].yo;
				addChild(asc);
				asc.Ower=this.Ower;
				asc.addEventListener(Asset_Scale.MOVE,_onMoveHander)
			}
						
			var asrx:Asset_RotationXian=new Asset_RotationXian()
			asrx.x=xx+ww/2
			asrx.y=yy+hh/2
			asrx.drawLine(0,-(hh/2+30))
			addChildAt(asrx,0)
	
			var asr:Asset_Rotation=new Asset_Rotation()
			asr.x=xx+ww/2
			asr.y=yy-30;
			asr.Ower=this.Ower;
			addChild(asr)
			asr.addEventListener(Asset_Rotation.ROTATION,_SCALE_CENTER)
			
			
			var myDashedDrawing:GDashedLine = new GDashedLine(this, 4, 4);
			myDashedDrawing.beginFill(0xffffff,0.1)
			myDashedDrawing.lineStyle(2,0x666666,1)
			myDashedDrawing.drawRect(xx,yy,ww,hh);
			myDashedDrawing.endFill()
		}
		private function _SCALE_CENTER(e:Event_):void
		{
			Ower.rotation=e.data+30
		}
		private function _onMoveHander(e:Event_):void
		{
			Ower.chageScae(e.data)
		}
		public var ww
		public var hh
		public var xx
		public var yy
	}
}