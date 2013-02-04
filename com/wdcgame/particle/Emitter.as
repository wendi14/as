package com.wdcgame.particle 
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import flash.geom.Point;
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
 
	
	/**
	 * ...
	 * @author 
	 */
	public class Emitter extends Sprite implements IAnimatable
	{
		private var _shap:Class;
		private var _number:Number=5;
		private var _radius:Number=150;
		private var _time:Number=Number.MAX_VALUE;
		private var _nowTime:Number = 0;
		private var _items:Array;
		public function Emitter() 
		{
			_items = [];
		}
		public function set shape(value:Class):void 
		{
			_shap = value;
		}
		public function set number(value:Number):void 
		{
			_number = value;
		}
		
		public function get time():Number 
		{
			return _time;
		}
		
		public function set time(value:Number):void 
		{
			_time = value;
		}
		
		public function get radius():Number 
		{
			return _radius;
		}
		
		public function set radius(value:Number):void 
		{
			_radius = value;
		}
		

		public function start():void
		{
			
			
			var dir:int = 1;
			
			for (var i:int = 0; i < _number; i++) 
			{
				var per:Number = Math.PI *2/ _number * i;
 
				if (Math.random() > 0.5) dir = -1;
				var ran:Number = Math.random() * 50 * dir +_radius
				//var ran:Number = _radius;//test
				 
				var item:* = new _shap();
				addChild(item);
				
				var xx:Number=Math.cos(per)*ran;
				var yy:Number = Math.sin(per ) * ran;
				//item.x = xx; item.y = yy;//test
 
				//var sca:Number = 1 + Math.random() * dir;
				item.targetPoint = new Point(xx, yy);
				_items.push(item);
				Starling.juggler.add(ParticleShpae(item));
				item.addEventListener(Event.COMPLETE, onC);
			}
		}
		
		private function onC(e:Event):void 
		{
			_items.shift();
			if (_items.length == 0)
			{
				Starling.juggler.remove(this);
				this.removeFromParent(true);
			}
		}
		
		 
		
		public function advanceTime(time:Number):void 
		{
			_nowTime += time;
			if (_nowTime>=_time) 
			{
				//this.removeFromParent();
				Starling.juggler.remove(this);
				return;
			}
			 start()
			
		}
		
	}

}