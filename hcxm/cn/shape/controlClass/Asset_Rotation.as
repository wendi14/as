package hcxm.cn.shape.controlClass
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;
	
	import hcxm.cn.event.Event_;
	import hcxm.cn.mouse.MouseICNO;
	import hcxm.cn.shape.DragedSprite;
	import hcxm.cn.shape.manager.DrawManager;
	
	import mx.managers.CursorManager;

	public class Asset_Rotation extends Sprite
	{
		public static const SCALE_CENTER:String="scale_center"
		public static const ROTATION:String="rotation"
		public var scale_dir:String="Rotation";
		public var xo:Number=-4
		public var yo:Number=-4
		public static const dw:int=4;
		public var isController:Boolean=true;
		public var Ower:DragedSprite
		public function Asset_Rotation()
		{

			super();
			this.graphics.lineStyle(1,ScaleControler.LineColor);
			this.graphics.beginFill(0xffffff);
			this.graphics.drawCircle(0,0,dw)
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
		public var isChangeCenter:Boolean=false;
		private function _MOUSE_OVER(e:MouseEvent):void
		{
			Ower.isScale=true
			Mouse.hide();
			CursorManager.setCursor(MouseICNO[scale_dir],2,xo,yo)
		}
		private function _MOUSE_OUT(e:MouseEvent):void
		{
			Ower.isScale=false;
			DrawManager.NoCursor();
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
				isControing=true
				isChangeCenter=true;
				var wx=Ower.x;
				//this.x=e.stageX-Ower.x;
				//this.y=e.stageY-Ower.y;
				var hu=Math.atan2(e.stageY-Ower.y-Ower.owner.y,e.stageX-Ower.x-Ower.owner.x)
				//var po1:Point=new Point(Ower.x,Ower.y)
				//var po2:Point=Ower.localToGlobal(po1)
				//hu=Math.atan2(e.stageY-po2.y,e.stageX-po2.x)
				var du=180*hu/Math.PI
				Mouse.hide();
				CursorManager.setCursor(MouseICNO[scale_dir],2,xo,yo)		
				dispatchEvent(new Event_(ROTATION,du))
			}
		}
		private function _MOUSE_UP(e:MouseEvent):void
		{
			isPress=false;
			
			if(isControing)
			{
				DrawManager.NoCursor()
			}
			isControing=false;
			
			if(!isChangeCenter)return;
			isChangeCenter=false;
			var o:Object=new Object()
			var wx=Ower.transform.pixelBounds;
			trace(wx)
			o.x=e.stageX-wx.x-5
			o.y=e.stageY-wx.y-5
			//dispatchEvent(new Event_(SCALE_CENTER,o))
		
		}
	}
}