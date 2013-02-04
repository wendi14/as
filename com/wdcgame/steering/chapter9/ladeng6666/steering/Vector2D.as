package ladeng6666.steering  
{
	import flash.display.Graphics;
	
	/**
	 * ...
	 * @author DefaultUser (Tools -> Custom Arguments...)
	 */
	public class Vector2D 
	{
		private var _x:Number;
		private var _y:Number;
		
		public function Vector2D(x:Number=0,y:Number=0) 
		{
			_x = x;
			_y = y;
		}
		
		public function draw(graphics:Graphics, color:uint=0):void {
			graphics.lineStyle(0, color);
			graphics.moveTo(0, 0);
			graphics.lineTo(_x, _y);
		}
		/**
		 * 返回自己的克隆向量
		 * @return Vector2D
		 */
		public function clone():Vector2D {
			return new Vector2D(_x, _y);
		}
		/**
		 * 返回 Vector2D (0,0)
		 * @return Vector2D
		 */
		public function zero():Vector2D {
			_x = 0;
			_y = 0;
			return this;
		}
		/**
		 * 返回是否为零向量
		 * @return Boolean
		 */
		public function iszero():Boolean {
			return _x == 0 && _y == 0;
		}
		public function set length(value:Number):void {
			var a:Number = angle;
			_x = Math.cos(a) * value;
			_y = Math.sin(a) * value;
		}
		/**
		 * 返回向量的长度
		 */
		public function get length():Number {
			return Math.sqrt(lengthSQ);
		}
		public function get lengthSQ():Number {
			return _x * _x + _y * _y;
		}
		public function set angle(value:Number):void {
			var len:Number = length;
			_x = Math.cos(value) * len;
			_y = Math.sin(value) * len;
		}
		public function get angle():Number {
			return Math.atan2(_y, _x);
		}
		/**
		 * 返回垂直向量
		 */
		public function get perp():Vector2D {
			return new Vector2D( -y, x);
		}
		public function set x(value:Number):void {
			_x = value;
		}
		public function get x():Number {
			return _x;
		}
		public function set y(value:Number):void {
			_y = value;
		}
		public function get y():Number {
			return _y;
		}
		/**
		 * 向量单位化
		 * @return Vector2D
		 */
		public function normalize():Vector2D {
			if (length == 0) {
				_x = 1;
				return this;
			}
			var len:Number = length;
			_x /= len;
			_y /= len;
			
			return this;
		}
		public function scale(value:uint):Vector2D {
			
			return new Vector2D(_x * value, _y * value);
		}
		/**
		 * 限制向量的最大长度
		 * @param	max
		 * @return Vector2D
		 */
		public function truncate(max:Number):Vector2D {
			length = Math.min(max, length);
			return this;
		}
		/**
		 * 向量反转
		 * @return Vector2D
		 */
		public function reverse():Vector2D {
			_x = -_x;
			_y = -_y;
			
			return this;
		}
		/**
		 * 返回是否为单位向量
		 * @return Boolean
		 */
		public function isNormalized():Boolean {
			return length == 1.0;
		}
		/**
		 * 返回两个向量夹角的cos值
		 * @return
		 */
		public function dotProd(v2:Vector2D):Number {
			return _x * v2.x + _y * v2.y;
		}
		public function crossProd(v2:Vector2D):Number {
			return _x * v2.y - _y * v2.x;
		}
		/**
		 * 返回两个向量的角度
		 * @param	v1
		 * @param	v2
		 * @return Number
		 */
		public function angleBetween(v1:Vector2D, v2:Vector2D):Number {
			if (!v1.isNormalized()) v1 = v1.clone().normalize();
			if (!v2.isNormalized()) v2 = v2.clone().normalize();
			return Math.acos(v1.dotProd(v2));
		}
		/**
		 * 
		 * @param	v2
		 * @return Vector2D
		 */
		public function sign(v2:Vector2D):int {
			return perp.dotProd(v2) < 0? -1:1;
		}
		/**
		 * 返回两个Vector2D之间的距离
		 * @param	v2
		 * @return Number
		 */
		public function dist(v2:Vector2D):Number {
			return Math.sqrt(distSQ(v2));
		}
		/**
		 * 返回向量的平方值
		 * @param	v2
		 * @return Number
		 */
		public function distSQ(v2:Vector2D):Number {
			var dx:Number = v2.x - x;
			var dy:Number = v2.y - y;
			return dx * dx + dy * dy;
		}
		/**
		 * 加上向量v2
		 * @param	v2
		 * @return Vector2D
		 */
		public function add(v2:Vector2D):Vector2D {
			return new Vector2D(_x + v2.x, _y + v2.y);
		}
		/**
		 * 减去向量v2
		 * @param	v2
		 * @return Vector2D
		 */
		public function substract(v2:Vector2D):Vector2D {
			return new Vector2D(_x - v2.x, _y - v2.y);
		}
		/**
		 * 乘以向量value
		 * @param	value
		 * @return Vector2D
		 */
		public function multiply(value:Number):Vector2D {
			return new Vector2D(_x * value, _y * value);
		}
		/**
		 * 除以向量value
		 * @param	value
		 * @return Vector2D
		 */
		public function divide(value:Number):Vector2D {
			return new Vector2D(_x/value,_y/value);
		}
		/**
		 * 判断两个向量是否相同
		 * @param	v2
		 * @return
		 */
		public function equals(v2:Vector2D):Boolean {
			return _x == v2.x && _y == v2.y;
		}
		public function toString():String {
			return "[Vector2D(x:" + _x + ",y:" + _y + ")]";
		}
	}
	
}