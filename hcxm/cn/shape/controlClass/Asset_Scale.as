package hcxm.cn.shape.controlClass
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	import hcxm.cn.debug.Debug;
	import hcxm.cn.event.Event_;
	import hcxm.cn.mouse.MouseICNO;
	import hcxm.cn.shape.DragedSprite;
	import hcxm.cn.shape.manager.DrawManager;
	
	import mx.managers.CursorManager;

	public class Asset_Scale extends Sprite
	{
		public static const MOVE:String="scale_move"
		public var scale_dir:String="scaleV";
		public var xo:Number=0
		public var yo:Number=0
		public static const dw:int=8;
		public var isController:Boolean=true;
		public var Ower:DragedSprite
		public function Asset_Scale()
		{
			super();
			this.graphics.lineStyle(1,ScaleControler.LineColor);
			this.graphics.beginFill(0xffffff);
			this.graphics.drawRect(-dw/2,-dw/2,dw,dw)
			this.graphics.endFill();
			
			
			this.addEventListener(MouseEvent.MOUSE_OUT,_MOUSE_OUT);
			this.addEventListener(MouseEvent.MOUSE_OVER,_MOUSE_OVER);
			this.addEventListener(MouseEvent.MOUSE_DOWN,_MOUSE_DOWN)
		
			
			this.addEventListener(Event.ADDED_TO_STAGE,_ADDED_TO_STAGE)
		}
		private function _ADDED_TO_STAGE(e:Event):void
		{
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE,_MOUSE_MOVE);
			this.stage.addEventListener(MouseEvent.MOUSE_UP,_MOUSE_UP);
		}
		private function _MOUSE_OVER(e:MouseEvent):void
		{
			Debug.trace_(this+"		MouseICNO[scale_dir]")
			Ower.isScale=true
			Mouse.hide();
			CursorManager.setCursor(MouseICNO[scale_dir],2,xo,yo)
		}
		private function _MOUSE_OUT(e:MouseEvent):void
		{
			Ower.isScale=false;
			Mouse.show()
			CursorManager.removeAllCursors();
			
		}
		private var isPress:Boolean=false;
		private var isControing:Boolean=false;//是否在进行控制中
		private function _MOUSE_DOWN(e:MouseEvent):void
		{
			isPress=true
		}
		
		private function _MOUSE_MOVE(e:MouseEvent):void
		{
			
			if(isPress)
			{
				isControing=true;
				var o:Object=new Object()				
				if(this.scale_dir==ScaleDirConst.ScaleH)
				{
					var bx=e.stageX-Ower.x-Ower.owner.x
					o.width=bx
				}else if(this.scale_dir==ScaleDirConst.ScaleV)
				{
					var by=e.stageY-Ower.y-Ower.owner.y
					o.height=by;
				}else if(this.scale_dir==ScaleDirConst.ScaleB1)
				{
					var bx=e.stageX-Ower.x-Ower.owner.x;
					var by=e.stageY-Ower.y-Ower.owner.y;
					o.width=bx
					o.height=by;
				}
				
				
				CursorManager.setCursor(MouseICNO[scale_dir],2,xo,yo)
				
				
				dispatchEvent(new Event_(MOVE,o))
			}
		}
		private function _MOUSE_UP(e:MouseEvent):void
		{
			isPress=false;
			if(isControing)
			{
				//控制完成
				DrawManager.NoCursor()
			}
			isControing=false;
		}
	}
}