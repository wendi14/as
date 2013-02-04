package ladeng6666.steering 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class TargetObj extends Sprite
	{
		public function TargetObj() 
		{
			draw();
		}
		private function draw():void {
			var radius:Number = 5;
			var span:Number = 3;
			
			graphics.lineStyle(1);
			graphics.drawCircle(0, 0, radius);
			graphics.moveTo(0, -radius - span);
			graphics.lineTo(0, radius  + span);
			graphics.moveTo( -radius - span, 0);
			graphics.lineTo(radius  + span, 0);
		}
		public function get position():Vector2D {
			return new Vector2D(this.x, this.y);
		}
		public function set position(value:Vector2D):void {
			x = value.x;
			y = value.y;
		}
	}
	
}