package com.xmaser.map45.display 
{
	import com.xmaser.map45.utils.ISOUtils;
	import com.xmaser.map45.utils.Point3D;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author 
	 */
	public class ISOSprite extends Sprite 
	{
		private var _size:Number;
		private var _position:Point3D;
		private var _walkable:Boolean;

		protected var _overlapX:int;
		protected var _overlapY:int;
		
		public function ISOSprite(size:Number,overlapX:int=1,overlapY:int=1) 
		{
			this._overlapY = overlapY;
			this._overlapX = overlapX;
			if (this._overlapX<1) 
			{
				this._overlapX = 1
			}		if (this._overlapY<1) 
			{
				this._overlapY =1
			}
			this._size = size;
			_position = new Point3D();
		}
		public function showBackGround():void
		{
			var s:Shape = new Shape()
			s.graphics.beginFill(0xff0000, 0.4);
			s.graphics.drawRect(0,0,100, 100);
			s.graphics.endFill()
			addChildAt(s, 0);
		}
		public function debugXY():void
		{
			var t:TextField = new TextField()
			t.autoSize = "left";
			t.x -= 10; t.y -= 10
			addChild(t)
			t.text = XY.toString();
			t.selectable = false;
		}
		
	
		public function get position():Point3D 
		{
			return _position;
		}
		
		public function set position(value:Point3D):void 
		{
			_position = value;
			update()
		}
		public function get XY():Point { return new Point(Math.round(position.x/_size),Math.round(position.z/_size)) }
		private function update():void 
		{
			var screenPo:Point = ISOUtils.iso2screen(_position);
			//trace("screenPo: " + screenPo,_position);
			
			super.x = screenPo.x;
			super.y = screenPo.y;
			
			
		}
		/**
		* 返回形变后的层深
		*/
		public function get depth():Number
		{
			return (_position.x + _position.z) * .866 - _position.y * .707;
		}
		/**
		* 指定其它对象是否可以经过所占的位置
		*/
		public function set walkable(value:Boolean):void
		{
			_walkable = value;
		}
		
		public function get walkable():Boolean 
		{
			return _walkable;
		}
		
		public function get size():Number 
		{
			return _size;
		}
		
		public function set size(value:Number):void 
		{
			_size = value;
		}
		public function debugRect():void
		{
			var s:Shape = new Shape();
			s.graphics.lineStyle(1);
			s.graphics.beginFill(0x00ff00, 0.2);
			s.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
			s.graphics.endFill()
			addChild(s);
			
		}
		public function get rect() :Rectangle{ return new Rectangle(x-size/2,z-size/2,size,size); }
		public function get rect2() :Rectangle{ return new Rectangle(x-size/2,z-size/2,4,4); }
		
		public function get overlapX():int 
		{
			return _overlapX;
		}
		
		public function get overlapY():int 
		{
			return _overlapY;
		}
	}

}