package  cn.hcxmflash.game.comm.component
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class Grid extends Sprite 
	{
		private var _color:uint;
		private var _lock:Boolean = false;
		public function get color():uint { return _color; }
		public function set color(value:uint):void 
		{
			_color = value
			draw()
		}
		
		private var _type:int;
		
		
		private var _visited:Boolean;
		private var _xx:int;
		private var _yy:int;
		private var _colorAlpha:Number=1;
		protected var lineThickness:Number=1;
		protected var lineAlpha:Number=1;
		protected var lineColor:uint=0;
		protected var _ww:int;
		protected var _hh:int;
		
		private var _test:Boolean = false;
		private var t:TextField;
		public function get visited():Boolean 
		{
			return _visited;
		}
		
		public function set visited(value:Boolean):void 
		{
			_visited = value;
		}
		
		public function get xx():int 
		{
			return _xx;
		}
		
		public function set xx(value:int):void 
		{
			_xx = value;
		}
		
		public function get yy():int 
		{
			return _yy;
		}
		
		public function set yy(value:int):void 
		{
			_yy = value;
		}
		
		public function get type():int 
		{
			return _type;
		}
		
		public function set type(value:int):void 
		{
			_type = value;
		}
		
		public function get colorAlpha():Number 
		{
			return _colorAlpha;
		}
		
		public function set colorAlpha(value:Number):void 
		{
			_colorAlpha = value;
		}
		
		public function get lock():Boolean 
		{
			return _lock;
		}
		
		public function set lock(value:Boolean):void 
		{
			_lock = value;
		}
		
		public function get test():Boolean 
		{
			return _test;
		}
		
		public function set test(value:Boolean):void 
		{
			_test = value;
			if (value)
			{
				t = new TextField()
				t.selectable = false;
				addChild(t)
				t.text = yy + "_" + xx;
			}
		}
		public function  hideTxt():void
		{
			if (t)
			{
				removeChild(t);
			}
		}
		
		public function Grid() 
		{
			draw() ;
		}
		
		protected function draw():void 
		{
		
			if (this._ww != 0 && this._hh != 0)
			{
				graphics.clear();
				graphics.lineStyle(lineThickness, lineColor,lineAlpha);
				graphics.beginFill(_color,_colorAlpha);
				
				
				graphics.drawRect(0, 0, this._ww, this._hh);
				graphics.endFill();
			}
		}
	
		
		override public function toString():String 
		{
			return super.toString()+" "+_yy+"_"+_xx;
		}
	}

}