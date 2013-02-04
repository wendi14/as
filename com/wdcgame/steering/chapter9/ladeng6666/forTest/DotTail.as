package ladeng6666.forTest 
{
	import flash.display.Sprite;
	import ladeng6666.forTest.Dot;
	import ladeng6666.steering.Vehicle;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class DotTail extends Sprite
	{
		private var _length:Number;
		private var _target:Array;
		
		public function DotTail(target:Array,length:uint) 
		{
			this._target = target;
			this._length = length;
		}
		public function update():void {
			for (var i = 0; i < _target.length; i++) {
				var vehicle:Vehicle = _target[i];
				var dot:Dot = new Dot(1,_length*50,vehicle.color);
				addChild(dot);
				
				dot.x = vehicle.x;
				dot.y = vehicle.y;
			}
		}
		
	}
	
}