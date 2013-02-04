package hcxm.cn.shape
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import hcxm.cn.debug.Debug;
	import hcxm.cn.shape.manager.DrawManager;
	
	import mx.controls.Button;
	public class Draw_rec extends DrawBasic
	{
	/**
		 * 在 mc 中画
		 * */
		public function Draw_rec(mc:Sprite)
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
			ds.name="dragSprite_rec"+k
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
			ga.beginFill(0xffffff,1)
			exx=e.stageX-ds.x-canvaMc.x;
			eyy=e.stageY-ds.y-canvaMc.y;
			ga.drawRect(0,0,exx,eyy)
			
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
			
			/* ds.endx=e.localX;
			ds.endy=e.localY; */
			if(yy>e.localY)yy=e.localY;
			if(xx>e.localX)xx=e.localX
			ds.kxx=xx;
			ds.kyy=yy;
			ds.rx=xx
			ds.ry=yy
			ds.isDrawOver=true;	
		}
		
		override public function manualDraw():void
		{
			super.manualDraw()
			ga.beginFill(LFVO.fillColor,LFVO.lineAlpha/100)
			ga.drawRect(0,0,exx,eyy)
			ga.endFill();
		}
		
			
	}
}