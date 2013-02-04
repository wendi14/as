package com.xmaser.display.container 
{
	
	import com.greensock.TweenLite;
	import com.xmaser.const_.AlignConst;
	import com.xmaser.display.component.ComponentBasic;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class HBox extends ComponentBasic 
	{
		private var _vGap:int=6;
		private var _hGap:Number=6;
		
		private var _topGap:int = 6;
		private var _bottomGap:int = 6;
		private var _leftGap:int = 6;
		private var _rightGap:int = 6;
		private var _align:String = AlignConst.LEFT;
		private var _verticalAlign:String=AlignConst.TOP;
		private var _ww:Number=0;
		private var _hh:Number=0;
		private var _width:Number=0;
		private var _itemWidth:Number;
		public function HBox() 
		{
			addEventListener(Event.RENDER, __RENDER);
			
		}
		override protected function init():void 
		{
			super.init();
			stage.addEventListener(Event.RESIZE, __RESIZE);
		}
		
		private function __RESIZE(e:Event):void 
		{
			//trace("__RESIZE: " + __RESIZE);
			width = stage.stageWidth;
			
			if (_itemWidth) 
			{
				vGap = 12;
				calHgap(_itemWidth);
			}
			rePosition()
		}
		
		private function __RENDER(e:Event):void 
		{
			 drawUI()
			 
			
		}
		override protected function drawUI():void 
		{
			super.drawUI();
			
			
			
		}
		override public function addChild(child:DisplayObject):DisplayObject 
		{
		
			if (_hh == 0)
			{
				_hh =0
			}
			if (_align==AlignConst.LEFT) 
			{
				//_ww += _hGap;
				if (_ww == 0)
				{
					_ww =0
				}else
				{
					
				}
				alignLeft(child);
				
			}else if (_align == AlignConst.RIGHT)
			{
				if (_ww == 0)
				{
					_ww = _width ;
					
				}
				alignRight(child);
			}
		
		/*	child.x = _ww;
			child.y = _hh;
			
			
			
			
			if (_align == AlignConst.LEFT)
			{
				if (_ww+child.width+_hGap>=_width) 
				{
					_hh += child.height + _vGap;
					_ww = 0;
					
				}
			}*/
			
			
			
		
			//redrawUI()
			return super.addChild(child);
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject 
		{
			_ww -= (child.width + _hGap);
			return super.removeChild(child);
		}
		override public function removeChildAt(index:int):DisplayObject 
		{
			var child:DisplayObject = getChildAt(index);
			_ww -= (child.width + _hGap);
			return super.removeChildAt(index);
		}
		/**
		 * 计算要间距多少
		 * @param	number
		 */
		public function calHgap(number:Number):void 
		{
			_itemWidth = number;
			_hGap = int((_width - 10) / (number + 10));
			var num:Number = _hGap;
			//trace( "_hGap : " + _hGap );
			//_hGap = (_width -6- (_hGap * number)) / _hGap;
			_hGap = number * _hGap;
			//trace("_hGap: " + _hGap);
			
			_hGap = _width - _hGap;
			//trace("_hGap: " + _hGap);
			
			_hGap = _hGap / (num + 1);
			//trace( "_hGap : " + _hGap );
		}
		public function vertialAlign(valign:String):void
		{
			
			_verticalAlign = valign;
			if (valign==AlignConst.CENTER) 
			{
				var hh:Number = this.height + _vGap;
				for (var i:int = 0; i < numChildren; i++) 
				{
					var child:DisplayObject = getChildAt(i);
					child.y = hh / 2 - child.height / 2;
				}
			}
		}
		private function redrawUI():void 
		{
			this.graphics.clear();
			this.graphics.lineStyle(1,0,1);
			this.graphics.beginFill(0xffffff, 0);
			this.graphics.drawRect(0, 0, _ww+_rightGap, _hh+_topGap+_bottomGap);
			this.graphics.endFill();
		}
		public function rePosition():void
		{
			_ww = _hh = 0;
			if (_align == AlignConst.RIGHT)
			{
				_ww = _width;
				_hh = _hGap;
			}
			for (var i:int = 0; i < numChildren; i++) 
			{
				var child:DisplayObject = getChildAt(i);
				if (_align == AlignConst.LEFT)
				{
					alignLeft(child);
				}else if (_align==AlignConst.RIGHT) 
				{
					alignRight(child);
				}
		
			}
			vertialAlign(_verticalAlign);
			//redrawUI()
		}
		
		private function alignRight(child:DisplayObject):void 
		{
			_ww =_ww- _hGap - child.width;
			child.x = _ww;
			//trace( "_ww : " + _ww );
			child.y = _hh;	
			
			//_ww = _ww - child.width - _hGap;
			
		}
		
		private function alignLeft(child:DisplayObject):void 
		{
			child.x = _ww + _hGap;
			
				child.y = _hh + _vGap;
				_ww += child.width + _hGap;
				//trace("_ww: " + _ww,_width);
				
				if (_ww+child.width>=_width) 
				{
					_hh += child.height + _vGap;
					_ww = 0;
					
				}
		}
		
		public function get align():String 
		{
			return _align;
		}
		
		public function set align(value:String):void 
		{
			_align = value;
			
		}
		
		override public function get width():Number 
		{
			return super.width;
		}
		
		override public function set width(value:Number):void 
		{
			//super.width = value;
			_width = value;
		}
		
		public function get hGap():int 
		{
			return _hGap;
		}
		
		public function set hGap(value:int):void 
		{
			_hGap = value;
		}
		
		public function get vGap():int 
		{
			return _vGap;
		}
		
		public function set vGap(value:int):void 
		{
			_vGap = value;
		}
		override public function destory():void 
		{
			super.destory();
			while (this.numChildren>0) 
			{
				removeChildAt(0);
			}
			_ww = _hh = 0;
			if(stage)stage.removeEventListener(Event.RESIZE, __RESIZE);
		}
		
		public function closeChild(child:DisplayObject):void 
		{
			child.visible = false;
			var ind:int = getChildIndex(child);
			ind++;
			while (ind<this.numChildren) 
			{
				var otherChild:DisplayObject = this.getChildAt(ind);
				ind++;
				var xx:Number = otherChild.x - child.width + _hGap
				;
				TweenLite.to(otherChild, 0.4, { x:xx} );
			}
		}
		
		public function open(child:DisplayObject):void 
		{
			child.visible = true;
			var ind:int = getChildIndex(child);
			ind++;
			while (ind<this.numChildren) 
			{
				var otherChild:DisplayObject = this.getChildAt(ind);
				ind++;
				var xx:Number = otherChild.x + child.width + _hGap
				;
				TweenLite.to(otherChild, 0.4, { x:xx} );
			}
		}
		
		
		
	}

}