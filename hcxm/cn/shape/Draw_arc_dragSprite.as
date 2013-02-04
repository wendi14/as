/***
 * 存放由线条转换而来的弧线;
 * */
package hcxm.cn.shape
{
	import flash.events.MouseEvent;
	
	import hcxm.cn.shape.manager.DrawManager;
	
	public class Draw_arc_dragSprite extends DragedSprite
	{
		//标记 画完了,只有为  true 时，才能够调整它的弧度
		//public var isDrawOver:Boolean=false;
		
		//[Embed(source="")]
		public function Draw_arc_dragSprite()
		{
			super();
		}
		public var startx
		public var starty
		public var endx
		public var endy;
		public var isDrawArc:Boolean=false;
		private var isPress:Boolean=false;
		private var enableArc:Boolean=false;
		public var isArc:Boolean=true;//是否可以转弧形;如果要画直线的话，就把它设置为 false
		
		
		public var dianArr:Array=[]

		
		override protected function _MOUSE_OVER(e:MouseEvent):void
		{
			/*  Debug.trace_("ISDRAWOVER"+isDrawOver)
			Debug.trace_("ENABLEDMOVE"+enabledMove)
			Debug.trace_("ISSELECT"+isSelect)   */
			super._MOUSE_OVER(e)
			if(isDrawOver&&!isSelect&&isDrawArc&&isArc)
			{
				DrawManager.HuxianCursor();
				enableArc=true;
			}
		}
		override protected function _MOUSE_DOWN(e:MouseEvent):void
		{
			isPress=true
			stage.addEventListener(MouseEvent.MOUSE_MOVE,_MOUSE_MOVE1)
			stage.addEventListener(MouseEvent.MOUSE_UP,_MOUSE_UP1);
			
		}
		function _MOUSE_MOVE1(e:MouseEvent):void
		{
			/* Debug.trace_("isDrawArc"+isDrawArc)
			Debug.trace_("isPress"+isPress) */
		
			if(enableArc&&isPress&&isArc)
			{
				drag.enabledDrag(false);
				DrawManager.HuxianCursor();
				dianArr=[]
				this.hideKuan()
				this.Pen.clear();
				this.Pen.lineStyle(this.Ower.LFVO.lineThickness,Ower.LFVO.lineColor,Ower.LFVO.lineAlpha);
				this.Pen.moveTo(startx,starty)
				dianArr.push({x:startx,y:starty})
				var tx=e.stageX-this.x-this.owner.x;
				var ty=e.stageY-this.y-this.owner.y;
				this.Pen.curveTo(tx,ty,endx,endy)
				dianArr.push({x:tx,y:ty})
				dianArr.push({x:endx,y:endy})
				
			}
		}
		function _MOUSE_UP1(e:MouseEvent):void
		{
			isPress=false;
			enableArc=false
			if(!isSelect)
			{
				DrawManager.NoCursor()
			}
			drag.enabledDrag(true);
			//drag.enabledDrag(false)
		}
		
		override protected function _MOUSE_OUT(e:MouseEvent):void
		{
			super._MOUSE_OUT(e)
			DrawManager.hasArc=false;
			
			if(isDrawOver&&!isSelect&&isDrawArc&&!DrawManager.isDraw&&isArc)
			{
				DrawManager.NoCursor()
			}
			if(isSelect)
			{
				DrawManager.NoCursor()
			}
			if(DrawManager.isDraw)
			{
				DrawManager.DrawCursor();
			}
						
	
		}
		override public function showKuan():void
		{
			super.showKuan()
			isDrawArc=false;			
		/* 	Debug.trace_("ISDRAWOVER"+isDrawOver)
			Debug.trace_("ENABLEDMOVE"+enabledMove)
			Debug.trace_("ISSELECT"+isSelect)
			Debug.trace_("enabledMove"+enabledMove)
			Debug.trace_("DrawManager.isDraw"+DrawManager.isDraw) */

		}
		override public function hideKuan():void
		{
			super.hideKuan();
			isDrawArc=true
		}
		
	}
}