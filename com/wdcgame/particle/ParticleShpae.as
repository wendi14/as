package com.wdcgame.particle 
{
	import flash.geom.Point;
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	 
	
	/**
	 * ...
	 * @author 
	 */
	public class ParticleShpae extends Sprite implements IAnimatable 
	{
		private var _targetPoint:Point
		private var _speedX:Number=1;
		private var _speedY:Number = 1;
		
		private var _xspeed:Number;
		private var _yspeed:Number;
		
		public function ParticleShpae() 
		{
			
		}
		
		public function destroy():void
		{
			dispatchEventWith(Event.COMPLETE);
			this.dispose();
			Starling.juggler.remove(this);
			this.removeFromParent();
			
		}
		
		public function advanceTime(time:Number):void 
		{
			
		}
		
		public function get targetPoint():Point 
		{
			return _targetPoint;
		}
		
		public function set targetPoint(value:Point):void 
		{
			_targetPoint = value;
			
		}
		
		public function get speedX():Number 
		{
			return _speedX;
		}
		
		public function set speedX(value:Number):void 
		{
			_speedX = value;
		}
		
		public function get speedY():Number 
		{
			return _speedY;
		}
		
		public function set speedY(value:Number):void 
		{
			_speedY = value;
		}
		
		public function get xspeed():Number 
		{
			return _xspeed;
		}
		
		public function set xspeed(value:Number):void 
		{
			_xspeed = value;
		}
		
		public function get yspeed():Number 
		{
			return _yspeed;
		}
		
		public function set yspeed(value:Number):void 
		{
			_yspeed = value;
		}
	}

}