package ladeng6666.forTest 
{
	import flash.display.Sprite;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Dot extends Sprite
	{
		public var father:Dot;
		public var prevX:Number;
		public var prevY:Number;
		private var t:Timer;
		
		public function Dot(size:Number=1,life:uint=100,color:uint=0) 
		{
			t = new Timer(life,10);
			t.start();
			t.addEventListener(TimerEvent.TIMER, dim);
			t.addEventListener(TimerEvent.TIMER_COMPLETE, die);
			
			draw(size,color);
		}
		private function draw(size:uint,color:uint):void {
			graphics.lineStyle(1,color);
			graphics.beginFill(0);
			graphics.drawCircle(0, 0, size);
			graphics.endFill();
		}
		private function dim(e:TimerEvent):void {
			this.alpha-=0.1
		}
		private function die(e:TimerEvent):void {
			this.parent.removeChild(this);
		}
	}
	
}