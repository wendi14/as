package com.wdcgame.steering 
{
	import com.wdcgame.utils.Vector2D;
	import starling.display.Sprite;
	import flash.display.Stage;
 
	
	public class VechileStarling2 extends Sprite
	{
		private var _color:uint;			//机车的颜色
		private var _position:Vector2D;		//机车的坐标
		private var _velocity:Vector2D;		//机车的速度向量
		private var _steerForce:Vector2D;	//机车受到的外力
		
		private var _maxSpeed:Number=10;	//机车的最大速度,默认为10;
		private var _mass:uint = 1;		//机车的质量,默认为1;
		private var _maxForce:Number = 1;	//机车的最大转向力;
		
		private var _arrivalThreshold:Number = 100;	//机车的视力范围
		
		private var _wanderDistance:Number = 50;		//机车漫游的圆心位置
		private var _wanderRadius:Number = 30;			//机车漫游目标的范围
		private var _wanderAngle:Number = 0;			//偏移量的角度
		private var _wanderRange:Number = 1;			//偏移量角度的变化范围
		
		private var _avoidDistance:Number = 200;			//avoid的探测触角长度
		private var _avoidBuffer:Number = 20;
		
		private var _isAvoiding:Boolean = false;
		
		private var _pathIndex:int = 0;
		private var _pathThreshold:Number = 20;
		
		private var _edgeBehavior:String = "wrap";//边缘行为,默认为卷屏
		
		public static var BOUNCE = "bounce";
		public static var WRAP = "wrap";
		
		
		public function VechileStarling2(color:uint=0xffffff) 
		{
			_color = color;
			_position = new Vector2D();
			_velocity = new Vector2D();
			_steerForce = new Vector2D();
			
			drawVehicle();
		}
		protected function draw():void
		{
			
		}
		protected function drawVehicle(size:uint=1):void {
			//graphics.clear();
			//graphics.lineStyle(0);
			//graphics.beginFill(_color, 0.8);
			//graphics.moveTo(10*size, 0);
			//graphics.lineTo( -10*size, 5*size);
			//graphics.lineTo( -10*size, -5*size);
			//graphics.lineTo(10*size, 0);
			//graphics.endFill();
		}
		private function bounce():void {
			if (stage == null) return;
			
			if (_position.x < 0) {
				_position.x = 0;
				_velocity.x *= -1;
			}else if (_position.x > stage.stageWidth) {
				_position.x = stage.stageWidth;
				_velocity.x *= -1;
			}
			if (_position.y < 0) {
				_position.y = 0;
				_velocity.y *= -1;
			}else if (_position.y > stage.stageHeight) {
				_position.y = stage.stageHeight;
				_velocity.y *= -1;
			}
		}
		private function wrap():void {
			if (stage == null) return;
			if (_position.x < 0) _position.x = stage.stageWidth;
			if (_position.x > stage.stageWidth) _position.x = 0;
			if (_position.y < 0) _position.y = stage.stageHeight;
			if (_position.y > stage.stageHeight) _position.y = 0;
		}
		//下面的setter和getter应该就不用解释了吧
		public function set position(value:Vector2D):void {
			_position = value;
		}
		public function get position():Vector2D {
			return _position;
		}
		public function set velocity(value:Vector2D):void {
			value.truncate(_maxSpeed);				//限制速度矢量的最大值
			_velocity = value;
		}
		public function get velocity():Vector2D {
			return _velocity;
		}
		public function set steerForce(value:Vector2D):void {
			value.truncate(_maxForce);				//限制转向力的最大值,因为"方向盘转的角度有限"
			
			_steerForce = value.divide(_mass);		//大质量的机车转弯比较慢
		}
		public function get steerForce():Vector2D {
			return _steerForce;
		}
		public function set maxSpeed(value:Number):void {
			_maxSpeed = value;
		}
		public function get maxSpeed():Number {
			return _maxSpeed;
		}
		public function set mass(value:uint):void {
			if (value< 1) return;
			_mass = value;
			drawVehicle(value);		//这一句实现机车大小的变化
		}
		public function get mass():uint {
			return _mass;
		}
		public function set edgeBehavior(value:String):void {
			_edgeBehavior = value;
		}
		public function get edgeBehavior():String {
			return _edgeBehavior;
		}
		public function get color():uint {
			return _color;
		}
		public function set arrivalThreshold(value:Number):void {
			_arrivalThreshold = value;
		}
		public function get arrivalThreshold():Number {
			return _arrivalThreshold;
		}
		public function set wanderDistance(value:Number):void {
			_wanderDistance = value;
		}
		public function get wanderDistance():Number {
			return _wanderDistance;
		}
		public function set wanderRadius(value:Number):void {
			_wanderRadius = value;
		}
		public function get wanderRadius():Number {
			return _wanderRadius;
		}
		public function set wanderRange(value:Number):void {
			_wanderRange = value;
		}
		public function get wanderRange():Number {
			return _wanderRange;
		}
		//=下面的函数是分解测试用的========================
		//public function analysis():void {
			//graphics.lineStyle(1,0,0.5);
			//graphics.drawCircle(_wanderDistance, 0, _wanderRadius);
			//
			//graphics.drawRect( 0, -_avoidBuffer, _avoidDistance, _avoidBuffer*2);
		//}
		//public function get velocityEnd():Vector2D {
			//return _position.clone().add(_velocity.clone().scale(5));
		//}
		//public function get steerForceEnd():Vector2D {
			//return _position.clone().add(_steerForce.clone().scale(50));
		//}
		private var _wanderForce:Vector2D;
		//public function get wanderForce():Vector2D {
			//return _position.clone().add(_wanderForce);
		//}
		//=================================================
		
		public function update():void {
			velocity = _velocity.add(_steerForce);		//速度与转向力的矢量叠加
			_position = _position.add(_velocity);		//位置与速度的矢量叠加
			
			this.x = _position.x;
			this.y = _position.y;
			//判断并设置边缘行为
			if (_edgeBehavior == "bounce") {
				bounce();
			}else if (_edgeBehavior == "wrap") {
				wrap();
			}
			this.rotation = _velocity.angle ;//
		}
		public function seek(target:Vector2D):void {
			var desiredVelocity:Vector2D = target.subtract(_position);	
			//计算desiredVelocity
			desiredVelocity.normalize();								
			//将desiredVelocity单位化
			desiredVelocity = desiredVelocity.multiply(_maxSpeed);		
			//desiredVelociy乘以最大速度maxSpeed,最大速度向目标前进
			
			var force:Vector2D = desiredVelocity.subtract(_velocity);
			//计算转向力
			steerForce = _steerForce.add(force);
			//讲计算出来的转向力与原转向力叠加
		}
		public function flee(target:Vector2D):void {
			var desiredVelocity:Vector2D = target.subtract(_position);	
			//计算desiredVelocity
			desiredVelocity.normalize();								
			//将desiredVelocity单位化
			desiredVelocity = desiredVelocity.multiply(_maxSpeed);		
			//desiredVelociy乘以最大速度maxSpeed,最大速度向目标前进
			
			var force:Vector2D = desiredVelocity.subtract(_velocity);
			//计算转向力
			steerForce = _steerForce.subtract(force);
			//将计算出来的转向力与原转向力做矢量差
		}
		public function arrive(target:Vector2D):void {
			var desiredVelocity:Vector2D = target.subtract(_position);	
			//计算desiredVelocity
			desiredVelocity.normalize();
			//将desiredVelocity单位化
			
			var distance:Number = _position.dist(target);
			//机车与目标的距离
			if (distance < _arrivalThreshold) {
				desiredVelocity = desiredVelocity.multiply(_maxSpeed * distance / _arrivalThreshold);
				//机车的速度等于距离目标与”视力范围”的比率乘以最大速度
			}else {
				desiredVelocity = desiredVelocity.multiply(_maxSpeed);		
				//desiredVelociy乘以最大速度maxSpeed,最大速度向目标前进
			}
			
			var force:Vector2D = desiredVelocity.subtract(_velocity);
			//计算转向力
			steerForce = _steerForce.add(force);
			//讲计算出来的转向力与原转向力叠加
		}
		public function pursue(target:VechileStarling2):void {
			var lookAheadTime:Number = target.position.dist(_position) / _maxSpeed;
			//计算此时追上目标的预计时间,即lookAheadTime.
			var predictedTarget:Vector2D = target.position.add(target.velocity.multiply(lookAheadTime));
			//在这段时间内,目标以现在的速度,预计会到达的位置,即"未来目标"
			seek(predictedTarget);
			//寻找这个"未来目标"
		}
		public function evade(target:VechileStarling2):void {
			var lookAheadTime:Number = target.position.dist(_position) / _maxSpeed;
			//计算此时追上目标的预计时间,即lookAheadTime.
			var predictedTarget:Vector2D = target.position.add(target.velocity.multiply(lookAheadTime));
			//在这段时间内,目标以现在的速度,预计会到达的位置,即"未来目标"
			flee(predictedTarget);
			//避开这个"未来目标"
		}
		public function wander():void {
			if (_isAvoiding) return;
			
			var center:Vector2D = _velocity.clone().normalize().multiply(_wanderDistance);
			//在机车的正前方_wanderDistance位置,添加圆的圆心
			var offset:Vector2D = new Vector2D(0);
			//随机点与圆心的偏移量
			offset.length = _wanderRadius;
			//为是随机点落在圆心上,限定偏移量的长度为_wanderRadius
			offset.angle = _wanderAngle;
			//随机偏移的角度
			_wanderAngle += (Math.random() - 0.5) * _wanderRange;
			
			var force:Vector2D = center.add(offset);
			//圆心矢量加偏移矢量确定随机点,随机点确定后,直接添加随机点方向的转向力.
			steerForce = _steerForce.add(force);
			//讲计算出来的转向力与原转向力叠加
			
			_wanderForce = force;
		}
		
		/*public function avoid(targets:Array):void {
			
			for (var i:Number = 0; i < targets.length;i++ ) {
				var circle:Circle = targets[i] as Circle;
				//heading只表示机车的行驶方向,即单位话的速度velocity,
				var heading:Vector2D = _velocity.clone().normalize();
				//速度方向上的回避threshold,可以参考示意图中的avoidDistance.
				var feeler:Vector2D = heading.multiply(_avoidDistance);
				
				//机车与circle位置的矢量差,参考示意图
				var difference:Vector2D = circle.position.subtract(_position);
				//参考示意图中的projection
				var dotProd:Number = difference.dotProd(heading);
				
				if (dotProd > 0) {//当cos(a)/length>0,表示circle在机车的前方.
					//下面这两个变量请参考示意图
					var projection:Vector2D = heading.multiply(dotProd);
					var dist:Number = projection.subtract(difference).length;
					
					//在视角边界方向和速度方向都相撞,才会真正的撞在一起
					if (dist < circle.radius + _avoidBuffer && projection.length < feeler.length + circle.radius + _avoidBuffer) {
						//最大的转向力.
						var force:Vector2D = heading.multiply(_maxSpeed);
						//如果circle在机车左边,机车就往右转,在右边,机车就往左转.
						//difference顺时针转90与heading之间的夹角取sign后返回1或-1,可以参考一下Vector2D的sign方法
						force.angle += difference.sign(heading) * Math.PI / 2;
						//离circle越近,转向力越大,没意见吧
						force = force.multiply(1 - projection.length / feeler.length+circle.radius+_avoidBuffer);
						//转向力叠加
						steerForce = _steerForce.add(force);
						//离circle越近,刹车越猛,也没意见吧!
						_velocity = _velocity.multiply(projection.length / (feeler.length+circle.radius+_avoidBuffer));
						_isAvoiding = true;
						_wanderAngle = force.angle;
					}else {
						_isAvoiding = false;
					}
				}
			}
		}*/
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
	}
	
}