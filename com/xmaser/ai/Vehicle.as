package com.xmaser.ai 
{
	import com.xmaser.utils.Vector2D;
	import flash.display.Sprite;
	
	/**
	 * ...机车基类
	 * @author 小火柴
	 */
	public class Vehicle extends Sprite 
	{
		private var _position:Vector2D;
		private var _velocity:Vector2D;
		private var _steerForce:Vector2D;
		
		private var _maxSpeed:Number = 6;
		private var _mass:Number = 1;
		private var _edgeBehavior:String=WRAP;
		private var _arrivalThreshold:Number = 200;
		
		public static const WRAP:String = "wrap";
		public static const BOUNCE:String = "bounce";
		public function Vehicle() 
		{
			_position = new Vector2D()
			_velocity = new Vector2D();
			_steerForce = new Vector2D();
			draw()
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
		/**
		 * 寻找
		 * @param	target
		 */
		public function seek(target:Vector2D):void
		{
			var desiredVelocity:Vector2D = target.subtract(_position);
			desiredVelocity.normalize();
			desiredVelocity = desiredVelocity.multiply(_maxSpeed);
			
			var force:Vector2D = desiredVelocity.subtract(_velocity);
			
			steerForce = _steerForce.add(force);
			
		}
		/**
		 * 避开
		 * @param	target
		 */
		public function flee(target:Vector2D):void
		{
			var desiredVelocity:Vector2D = target.subtract(_position);
			desiredVelocity.normalize();
			desiredVelocity = desiredVelocity.multiply(_maxSpeed);
			
			var force:Vector2D = desiredVelocity.subtract(_velocity);
			
			steerForce = _steerForce.subtract(force);
			
		}
		/**
		 * 到达
		 * 寻找目标
							 l  	判断与目标的距离是否在arrivalThreshold内,如果在arrivalThreshold内,减速直到停在目标位置
		 * @param	target
		 */
		public function arrive(target:Vector2D):void
		{
			var desiredVelocity:Vector2D = target.subtract(_position);
			desiredVelocity.normalize();
			
			
			var dist:Number = _position.dist(target);
			if (dist<_arrivalThreshold) 
			{
				desiredVelocity = desiredVelocity.multiply(_maxSpeed*dist/_arrivalThreshold);
			}else 
			{
				desiredVelocity = desiredVelocity.multiply(_maxSpeed);
			}
			
			
			
			var force:Vector2D = desiredVelocity.subtract(_velocity);
			
			steerForce = _steerForce.add(force);
		}
		public function update():void
		{
			_velocity = _velocity.add(_steerForce);
			_steerForce = new Vector2D();
			_velocity.truncate(_maxSpeed);
			_position=_position.add(_velocity);
			if(_edgeBehavior == WRAP)
			{
				wrap();
			}
			else if(_edgeBehavior == BOUNCE)
			{
				bounce();
			}
			this.x = _position.x;
			this.y = _position.y
			
			this.rotation = _velocity.angle * 180 / Math.PI ;
			
		}
		 private function bounce():void {
                          if(stage != null)
			{
				if(position.x > stage.stageWidth)
				{
					position.x = stage.stageWidth;
					velocity.x *= -1;
				}
				else if(position.x < 0)
				{
					position.x = 0;
					velocity.x *= -1;
				}
				
				if(position.y > stage.stageHeight)
				{
					position.y = stage.stageHeight;
					velocity.y *= -1;
				}
				else if(position.y < 0)
				{
					position.y = 0;
					velocity.y *= -1;
				}
			}
                   }
                   private function wrap():void {
                           if(stage != null)
			{
				if(position.x > stage.stageWidth) position.x = 0;
				if(position.x < 0) position.x = stage.stageWidth;
				if(position.y > stage.stageHeight) position.y = 0;
				if(position.y < 0) position.y = stage.stageHeight;
			}
                   }
		public function get position():Vector2D 
		{
			return _position;
		}
		
		public function set position(value:Vector2D):void 
		{
			_position = value;
		}
		
		public function get velocity():Vector2D 
		{
			return _velocity;
		}
		
		public function set velocity(value:Vector2D):void 
		{
			_velocity = value;
		}
		
		public function get steerForce():Vector2D 
		{
			return _steerForce;
		}
		
		public function set steerForce(value:Vector2D):void 
		{
			_steerForce = value.divide(_mass);
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
			if (value < 1)
			{
				return;
			}
			_mass = value;
			
			this.scaleX = this.scaleY = _mass;
		}
		
		public function get arrivalThreshold():Number 
		{
			return _arrivalThreshold;
		}
		
		public function set arrivalThreshold(value:Number):void 
		{
			_arrivalThreshold = value;
		}
		
		
	}

}