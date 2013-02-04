package hcxm.cn.shape
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import hcxm.cn.shape.manager.DrawManager;
	
	import mx.controls.Button;
	public class Draw_cir extends DrawBasic
	{
	/**
		 * 在 mc 中画
		 * */
		public function Draw_cir(mc:Sprite)
		{
			super(mc);
		}

		var ds:DragedSprite
		
		var k=0
		override protected function _MOUSE_DOWN(e:MouseEvent):void
		{
			super._MOUSE_DOWN(e);			
			//Debug.trace_("DrawManager.isModi="+DrawManager.isModi)
			if(DrawManager.isModi)
			{
				DrawManager.dragedSprite.showKuan()
				return;
			}
			
			if(!isDraw)return;
			var ta:Object=e.target;
			
			
			if(!isEnabledDraw)return;
			if(ta is Button)return;
			
			
			ds=new DragedSprite();
			ds.Ower=this;
			ds.x=e.stageX-canvaMc.x
			ds.y=e.stageY-canvaMc.y;
			ds.name="dragSprite_cir"+k
			k++
			canvaMc.addChild(ds);
			ga=ds.Pen;
			
			
			
		}
		var xx=0;
		var yy=0;
		var exx
		var eyy
		override protected function _MOUSE_MOVE(e:MouseEvent):void
		{
			
			if(!isDraw||!isEnabledDraw)return;
			
			ga.clear()
			ga.lineStyle(thickness,linecolor,linealpha);
			ga.beginFill(0xffffff,1);
			exx=e.stageX-ds.x-canvaMc.x;
			eyy=e.stageY-ds.y-canvaMc.y;
			var len=Point.distance(new Point(),new Point(exx,eyy))
			//ga.drawCircle(0,0,len/2)
			if(shiftKeyIsPress)
			{
				var maxlen=Math.max(exx,eyy);
				ga.drawEllipse(0,0,maxlen,maxlen);
				
			}else
			{
				ga.drawEllipse(0,0,exx,eyy)
			}
			
			
			ga.endFill();
		}
		override protected function _MOUSE_UP(e:MouseEvent):void
		{
			super._MOUSE_UP(e);
			if(!isEnabledDraw)return;
			if(ds)
			{
				if(ds.isDrawOver==true)return;
			}else
			{
				return;
			}
			
			
			var wwww=	ds.tu1.width/2
			ds.kxx=xx
			ds.kyy=yy
			ds.rx=xx
			ds.ry=yy
			ds.isDrawOver=true;
			
/* 			ds.kxx=-ds.tu1.width/2
			ds.kyy=-ds.tu1.height/2
			ds.tu1.x+=ds.tu1.width/2;
			ds.tu1.y+=ds.tu1.height/2;
			ds.tu.x-=ds.tu1.width/2;
			ds.tu.y-=ds.tu1.height/2;  */
		}
		
		override public function manualDraw():void
		{
			super.manualDraw()
			ga.beginFill(LFVO.fillColor,LFVO.lineAlpha/100)
			ga.drawEllipse(0,0,exx,eyy)
			ga.endFill();
		}
		
			
	}
}