package hcxm.cn.shape
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;

	public class Draw extends EventDispatcher
	{
		public var canvaMc:Sprite;//在这个影片上画
		public var thickness:Number=1;//线条宽度
		public var linecolor:uint=0x000000;//线条颜色
		public var linealpha:Number=1;//线条的透明度
		
		public function Draw(mc:Sprite)
		{
			canvaMc=mc;
			createEvent()
		}
		private function createEvent():void
		{
			canvaMc.stage.addEventListener(MouseEvent.MOUSE_DOWN,_MOUSE_DOWN);
			canvaMc.stage.addEventListener(MouseEvent.MOUSE_UP,_MOUSE_UP);
			canvaMc.stage.addEventListener(MouseEvent.MOUSE_MOVE,_MOUSE_MOVE)
/* 			canvaMc.addEventListener(MouseEvent.MOUSE_DOWN,_MOUSE_DOWN);
			canvaMc.addEventListener(MouseEvent.MOUSE_UP,_MOUSE_UP);
			canvaMc.addEventListener(MouseEvent.MOUSE_MOVE,_MOUSE_MOVE) */
		}
		protected var isDraw:Boolean=false;
		protected var ga:Graphics
		protected function _MOUSE_DOWN(e:MouseEvent):void
		{
			isDraw=true;
			ga=canvaMc.graphics;
			
			ga.lineStyle(thickness,linecolor,linealpha);
			ga.moveTo(e.localX,e.localY)
		}
		protected function _MOUSE_MOVE(e:MouseEvent):void
		{
			if(isDraw)
			{	
				ga.lineTo(e.localX,e.localY);
			}
		}
		protected function _MOUSE_UP(e:MouseEvent):void
		{
			isDraw=false;
			
		}
		
	}
}