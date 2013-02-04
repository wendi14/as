package com.xmaser.game.puz 
{
	import cn.hcxmflash.component.LabelComponent;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class GridItemPUZ extends Sprite 
	{
		private var _searched:Boolean;
		protected var _type:int;
		private var _xx:Number = 0;
		private var _yy:Number = 0;
		private var _label:LabelComponent;
		private var _ww:Number=0;
		private var _hh:Number = 0;
		private var _oldX:Number;
		private var _oldY:Number;
		private var _canDelFlag:Boolean;
		protected var _test:Boolean = true;
		public function GridItemPUZ() 
		{
			this.mouseChildren = false;
			_label = new LabelComponent("");
			addChild(_label);
			
		}
		public function drawBg():void
		{
			this.graphics.clear()
			this.graphics.lineStyle(1, 0);
			if (this.searched)
			{
				this.graphics.lineStyle(2, 0xff0000);
			}
			var co:uint;
			switch (_type) 
			{
				case 0:
					co = 0x000000;
				break;
				case 1:
					co = 0xff0000;
				break;
				case 2:
					co = 0x00ff00;
				break;
				case 3:
					co = 0x0000ff;
				break;
				default:
					
				break;
			}
			this.graphics.beginFill(co,0.4);
			this.graphics.drawRect(0, 0, ww, hh);
			this.graphics.endFill();
		}
		public function get xx():Number 
		{
			return _xx;
		}
		
		public function set xx(value:Number):void 
		{
			_xx = value;
			if(_test)_label.text = _yy + "_" + _xx;
		}
		
		public function get yy():Number 
		{
			return _yy;
		}
		
		public function set yy(value:Number):void 
		{
			_yy = value;
			if(_test)_label.text = _yy + "_" + _xx;
		}
		
		public function get type():int 
		{
			return _type;
		}
		
		public function set type(value:int):void 
		{
			_type = value;
			drawBg()
		}
		
		public function get ww():Number 
		{
			return _ww;
		}
		
		public function set ww(value:Number):void 
		{
			_ww = value;
			drawBg()
		}
		
		public function get hh():Number 
		{
			return _hh;
		}
		
		public function set hh(value:Number):void 
		{
			_hh = value;
			drawBg()
		}
		
		public function get oldX():Number 
		{
			return _oldX;
		}
		
		public function set oldX(value:Number):void 
		{
			_oldX = value;
		}
		
		public function get oldY():Number 
		{
			return _oldY;
		}
		
		public function set oldY(value:Number):void 
		{
			_oldY = value;
		}
		
		public function get searched():Boolean 
		{
			return _searched;
		}
		
		public function set searched(value:Boolean):void 
		{
			_searched = value;
			
			//drawBg()
		}
		public function set canDelFlag(value:Boolean):void 
		{
			_canDelFlag = value;
			addDelFlg()
		}
		
		public function get canDelFlag():Boolean 
		{
			return _canDelFlag;
		}
		
		protected function addDelFlg():void 
		{
			var s:Shape = new Shape()
			s.graphics.beginFill(0xff0000);
			s.graphics.drawRect(0, 0, 10, 10);
			s.graphics.endFill();
			addChild(s);
		}
		override public function toString():String 
		{
			return yy+   "_" + xx+" type:" + _type + "" ;
		}
		
		public function saveOld():void 
		{
			
			
			_oldX = x;
			_oldY = y;
			//trace(this,"saveOld: " + _oldX+"_"+_oldY);
		}
		public function getDisFromOld():Point
		{
			return new Point(_oldX-x,_oldY-y)
		}
		public function clone():GridItemPUZ
		{
			var item:GridItemPUZ = new GridItemPUZ()
			item.type = this.type;
			item.ww = this.ww;
			item.hh = this.hh;
			
			return item;
		}
		
	}

}