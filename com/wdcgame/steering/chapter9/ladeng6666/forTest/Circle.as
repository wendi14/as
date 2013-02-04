package ladeng6666.forTest 
{
	import flash.display.Sprite;
	import ladeng6666.steering.Vector2D;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class Circle extends Sprite
	{
		private var _radius:Number;
		private var _color:uint;
		private var _isOn:Boolean = false;
		
		public function Circle(radius:Number, color:uint=0x0000ff) 
		{
			_radius = radius;
			_color = color;
			
			graphics.lineStyle(1, _color);
			graphics.beginFill(0xcccccc,0.5);
			graphics.drawCircle(0, 0, _radius);
			graphics.drawCircle(0, 0, 3);
			graphics.endFill();
		}
		public function get radius():Number {
			return _radius;
		}
		public function get position():Vector2D {
			return new Vector2D(x, y);
		}
		public function light():void {
			if(!_isOn){
				graphics.lineStyle(1, 0xff0000);
				graphics.drawCircle(0, 0, _radius);
			}
			_isOn = true;
		}
		public function off():void {
			if (_isOn) {				
				graphics.lineStyle(1, _color);
				graphics.drawCircle(0, 0, _radius);
			}
			_isOn = false;
		}
		
	}
	
}