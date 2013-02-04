package com.wdcgame.steering 
{
	 
	import com.wdcgame.utils.Vector2D;
	import flash.display.Sprite
	
	/**
	 * ...
	 * @author wdc
	 */
	public class Vechile extends Sprite 
	{
		private var _maxSpeed:Number = 6;
		private var _velocity:Vector2D;
		private var _mass:Number = 1;
		private var _position:Vector2D;
		
		private var _steerForce :Vector2D = new Vector2D();
		private var _maxForce:Number = 1;
		public function Vechile() 
		{
			draw();
		}
		
		
		protected function draw():void
		{
			graphics.clear();
			graphics.lineStyle(1, 0x000000);
			graphics.beginFill(0xff0000);
			graphics.moveTo(10, 0);
			graphics.lineTo( -10, 5);
			graphics.lineTo( -10, -5);
			graphics.lineTo( 10, 0);
			graphics.endFill();
		}
		
		public function update():void 
		{
			
			velocity = _velocity.add(_steerForce);
		_steerForce = new Vector2D();
			_position = _position.add(_velocity);
			
			
			
			this.x = _position.x;
			this.y = _position.y;
			
			this.rotation = _velocity.angle * 180 / Math.PI;
		}
		
		/**
		 * 寻找
		 * @param	target
		 */
		public function seek(target:Vector2D):void
		{
			var dis:Vector2D = target.subtract(_position);//与目标点的距离
			dis.normalize();//单位化
			
			dis = dis.multiply(_maxSpeed);//最大可移动的距离
			
			var force:Vector2D = dis.subtract(_velocity);
			steerForce = _steerForce.add(force);
 
		}
		
		
		
		/**
		 * 位置
		 */
		public function get position():Vector2D 
		{
			return _position;
		}
		
		public function set position(value:Vector2D):void 
		{
			_position = value;
		}
		/**
		 * 速度
		 */
		public function get velocity():Vector2D 
		{
			return _velocity;
		}
		
		public function set velocity(value:Vector2D):void 
		{
			value.truncate(_maxSpeed);                        //限制速度矢量的最大值
			_velocity = value;
			
			
		}
		/**
		 * 转向力
		 */
		public function get steerForce():Vector2D 
		{
			return _steerForce;
		}
		
		public function set steerForce(value:Vector2D):void 
		{
			
			value.truncate(_maxForce)
			_steerForce = value;
			
			_steerForce=_steerForce.divide(_mass);
		}
		
		public function get maxSpeed():Number 
		{
			return _maxSpeed;
		}
		
		public function set maxSpeed(value:Number):void 
		{
			_maxSpeed = value;
		}
		
		public function get mass():Number 
		{
			return _mass;
		}
		
		public function set mass(value:Number):void 
		{
			_mass = value;
			 if (value< 1) return;
			_mass = value;
			this.scaleX = this.scaleY = value;       
		}
		
		public function get maxForce():Number 
		{
			return _maxForce;
		}
		
		public function set maxForce(value:Number):void 
		{
			_maxForce = value;
		}
	}

}