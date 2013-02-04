package hcxm.cn.shape
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import hcxm.cn.debug.Debug;
	import hcxm.cn.shape.manager.DrawManager;
	
	import mx.controls.Button;
	
	
	public class Draw_arc extends DrawBasic
	{
		/**
		 * 在 mc 中画
		 * */
		public function Draw_arc(mc:Sprite)
		{
			super(mc)
		}
		private function _ADDED_TO_STAGE(e:Event):void
		{		
			
		}
		
		protected function _stageCLICK(e:MouseEvent):void
		{
			
		}
		var ds:Draw_arc_dragSprite
		private var myShape:Shape;
		var k=0
		override protected function _MOUSE_DOWN(e:MouseEvent):void
		{
			super._MOUSE_DOWN(e);			
			
			if(DrawManager.isModi)
			{
				DrawManager.dragedSprite.showKuan()
				return;
			}
			if(!isDraw)return;
			var ta:Object=e.target;
			
			Debug.trace_("draw_arc "+isEnabledDraw)
			if(!isEnabledDraw)return;
			if(ta is Button)return;
			ds=new Draw_arc_dragSprite();
			ds.Ower=this
			ds.x=e.stageX-canvaMc.x
			ds.y=e.stageY-canvaMc.y;
			ds.name="dragSprite_arc"+k
			k++
			canvaMc.addChild(ds);

			ga=ds.tu1.graphics;
			
			ga.lineStyle(thickness,linecolor,linealpha);
			ga.moveTo(0,0);
			xx=0
			yy=0
			ds.startx=xx
			ds.starty=yy
			dianArr.push({x:0,y:0})
		}
		var xx
		var yy;
		public var dianArr:Array=[]
		override protected function _MOUSE_MOVE(e:MouseEvent):void
		{
			
			if(!isDraw||!isEnabledDraw)return;
			ga.clear()
			dianArr=[]
			ga.lineStyle(thickness,linecolor,linealpha);
			ga.moveTo(xx,yy)
			dianArr.push({x:0,y:0})
			var tx=e.stageX-ds.x-canvaMc.x;
			var ty=e.stageY-ds.y-canvaMc.y;
			ga.lineTo(tx,ty);
			dianArr.push({x:tx,y:ty})
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
			ds.endx=e.localX;
			ds.endy=e.localY;
			if(yy>e.localY)yy=e.localY;
			if(xx>e.localX)xx=e.localX
			//ds.endfill(xx,yy);
			//ds.endDrag()
			ds.kxx=xx;
			ds.kyy=yy;
			ds.rx=xx
			ds.ry=yy
			ds.isDrawOver=true;	
			
		

		}
		override public function manualDraw():void
		{
			super.manualDraw();
			if(ds.dianArr.length>0)
			{
				this.dianArr=ds.dianArr;
				ga.moveTo(dianArr[0].x,dianArr[0].y)
				ga.curveTo(dianArr[1].x,dianArr[1].y,dianArr[2].x,dianArr[2].y)
			}else
			{
				ga.moveTo(dianArr[0].x,dianArr[0].y)
				
				ga.lineTo(dianArr[1].x,dianArr[1].y)
				
			}
			
		}
	}
}