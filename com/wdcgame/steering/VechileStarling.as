package com.wdcgame.steering 
{
	 
	import com.wdcgame.utils.Vector2D;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import starling.display.Image;
	import starling.display.Sprite
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class VechileStarling extends Sprite 
	{
		private var _maxSpeed:Number = 10;
		private var _velocity:Vector2D;
		private var _mass:Number = 1;
		private var _position:Vector2D;
		
		private var _steerForce :Vector2D = new Vector2D();
		private var _maxForce:Number = 1;
		
		private var _pathIndex:int = 0;
		private var _pathThreshold:Number = 20;
		
		public function VechileStarling() 
		{
			draw();
		}
		
		
		protected function draw():void
		{
			var s:Shape=new Shape()
			s.graphics.clear();
			s.graphics.lineStyle(1, 0x000000);
			s.graphics.beginFill(0xff0000);
			s.graphics.moveTo(10, 0);
			s.graphics.lineTo( -10, 5);
			s.graphics.lineTo( -10, -5);
			s.graphics.lineTo( 10, 0);
			s.graphics.endFill();
			var bd:BitmapData = new BitmapData(20, 20,true,0x00000000);
			bd.draw(s);
			var t:Texture = Texture.fromBitmapData(bd);
			var img:Image = new Image(t);
			addChild(img);
		}
		
		public function update():void 
		{
			
			velocity = _velocity.add(_steerForce);
			_steerForce = new Vector2D();
			_position = _position.add(_velocity);
			
			
			
			this.x = _position.x;
			this.y = _position.y;
			
			this.rotation = _velocity.angle ;// * 180 / Math.PI;
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
		
		public function followPath(path:Array, loop:Boolean = true):void {
			//当前的wayPoint
			var wayPoint:Vector2D = path[_pathIndex];
			if (wayPoint == null) return;
			//是否到达当前wayPoint
			if (_position.dist(wayPoint) < _pathThreshold) {
				if (_pathIndex >= path.length - 1) {
					//如果是最后一个wayPoint,如果循环,返回到第一个wayPoint
					if (loop) {
						_pathIndex = 0;
					}else {
						arrive(wayPoint);
					}
				}else {
					//如果已经到达,seek下一个wayPoint
					_pathIndex++;
				}
			}else {
				seek(wayPoint);
			}
		}
		
		public function arrive(wayPoint:Vector2D):void 
		{
			
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
			//this.scaleX = this.scaleY = value;       
		}
	}

}