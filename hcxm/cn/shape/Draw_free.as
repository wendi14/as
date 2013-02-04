package hcxm.cn.shape
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import hcxm.cn.shape.manager.DrawManager;
	
	import mx.controls.Button;
	
	/***
	 *  自由作画，铅笔
	 * */
	public class Draw_free extends DrawBasic
	{
		/**
		 * 在 mc 中画
		 * */
		public function Draw_free(mc:Sprite)
		{
			super(mc)
		}
		private function _ADDED_TO_STAGE(e:Event):void
		{		
			
		}
		
		protected function _stageCLICK(e:MouseEvent):void
		{
			
		}
		var ds:DragedSprite

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
			
			
			if(!isEnabledDraw)return;
			if(ta is Button)return;
			
			ds=new DragedSprite();
			ds.Ower=this
			ds.x=e.stageX-canvaMc.x
			ds.y=e.stageY-canvaMc.y;

			canvaMc.addChild(ds);

			ga=ds.Pen;
			
			ga.lineStyle(thickness,linecolor,linealpha);
			ga.moveTo(0,0);
			dianArr=[]
			dianArr.push({x:0,y:0})
		}
		var xx=0
		var yy=0;
		var dianArr:Array=[]
		override protected function _MOUSE_MOVE(e:MouseEvent):void
		{
			
			if(!isDraw||!isEnabledDraw)return;
			
			
			
			ga.lineTo(e.stageX-ds.x,e.stageY-ds.y);
			dianArr.push({x:e.stageX-ds.x,y:e.stageY-ds.y})
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
			ds.isDrawOver=true;
			
			if(yy>e.localY)yy=e.localY;
			if(xx>e.localX)xx=e.localX
			//ds.endfill(xx,yy);
			//ds.endDrag()
			ds.kxx=xx;
			ds.kyy=yy;
			ds.rx=xx
			ds.ry=yy
				
		}
		override public function manualDraw():void
		{
			super.manualDraw();
			ga.moveTo(dianArr[i].x,dianArr[i].y)
			for(var i:int=1;i<dianArr.length;i++)
			{
				ga.lineTo(dianArr[i].x,dianArr[i].y)
			}
		}

	}
}