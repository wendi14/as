package com.xmaser.display.component.tooltip 
{
	
	import com.xmaser.display.component.ComponentBasic;
	import com.xmaser.display.component.IComponent;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class ToolTip extends ComponentBasic implements IComponent
	{
		private var _skin:Class;
		private var _bgMc:Sprite;
		protected var _mc:DisplayObject;
		private var _tip:String;
		private var _tipHeight:Number=0
		private var _tipWidth:Number=0;
		
		protected var _offestPoint:Point = new Point(0,4);
		
		private var _tbGap:int = 4;
		private var _rlGap:int = 4;
		private var _label:TextField;
		private var _texf:TextFormat;
		private var _move:Boolean;

		public function ToolTip(mc:DisplayObject,tip:String,skin:Class=null,texf:TextFormat=null,tipWidth:int=0,move:Boolean=true) 
		{
			_move = move;
			_tipWidth = tipWidth;
			
			_texf = texf;
			if (!_texf) 
			{
				_texf = new TextFormat("_sans", 12, 0xffffff);
			}
			_tip = tip;
			_mc = mc;
			this._skin = skin;
			super();
			
			
		}
		override protected function init():void 
		{
			super.init();
			_mc.addEventListener(MouseEvent.ROLL_OVER, __ROLL_OVER);
			_mc.addEventListener(MouseEvent.ROLL_OUT, __ROLL_OUT);
			if (_move)
			{
				_mc.addEventListener(MouseEvent.MOUSE_MOVE, __MOUSE_MOVE);
			}
			
			createLabel();
			reDraw();
			rePostion()
		}
		
		private function __MOUSE_MOVE(e:MouseEvent):void 
		{
			__ROLL_OVER(e);
		}
		
		private function reDraw():void 
		{
			if (_bgMc)
			{
				removeChild(_bgMc);
				_bgMc = null;
			}
			
			var _tipWidth1:Number = _tipWidth;
			var _tipHeight1:Number = _tipHeight;
			if (_tipWidth == 0)
			{
				_tipWidth1 = _label.width + _rlGap * 2;
			}
			if (_tipHeight==0) 
			{
				_tipHeight1 = _label.height + _tbGap * 2;
			}
			
			if (this._skin) 
			{
				_bgMc = new _skin()
				_bgMc.width = _tipWidth1;
				_bgMc.height = _tipHeight1;
			}else
			{
				_bgMc = new Sprite()
				_bgMc.graphics.beginFill(0, 0.3);
				_bgMc.graphics.drawRect(0, 0,_tipWidth1, _tipHeight1);
				_bgMc.graphics.endFill();
			}
			addChildAt(_bgMc,0);
		}
		
		private function rePostion():void 
		{
			
			if (_tipWidth > 0)
			{
				
			}
			_tipHeight = _label.height + _tbGap * 2;;
			var ww:Number = _label.width;
			var hh:Number = _label.height;
			
			var _tipWidth1:Number = _tipWidth;
			var _tipHeight1:Number = _tipHeight;
			if (_tipWidth == 0)
			{
				_tipWidth1 = _label.width + _rlGap * 2;
			}
			if (_tipHeight==0) 
			{
				_tipHeight1 = _label.height + _tbGap * 2;
			}
			
			_label.x = _tipWidth1 / 2 - ww / 2;
			_label.y = _tipHeight1 / 2 - hh / 2;
			
			
		}
		
		protected function __ROLL_OVER(e:MouseEvent):void 
		{
			
			var po:Point = _mc.localToGlobal(new Point(e.localX, e.localY));
		
			po = po.add(_offestPoint);
			
			if (po.x+this.width > stage.stageWidth) po.x = stage.stageWidth - this.width;
			if (po.y + this.height > stage.stageHeight) 
			{
				//po.y = po.y- this.height-_offestPoint.y;
				po.y = po.y - this.height - _offestPoint.y*2;
				
			}
			this.x = po.x;
			this.y = po.y;
			this.visible = true;
			
			
		}
		
		protected function __ROLL_OUT(e:MouseEvent):void 
		{
			this.visible = false;
		}
		override protected function drawUI():void 
		{
			super.drawUI();
			
			if (this._skin) 
			{
				_bgMc = new _skin()
				
			}else
			{
				_bgMc = new Sprite()
				_bgMc.graphics.beginFill(0, 0.3);
				_bgMc.graphics.drawRect(0, 0,_tipWidth, _tipHeight);
				_bgMc.graphics.endFill();
				
			}
			addChild(_bgMc);
		}
		
		private function createLabel():void 
		{
			
			_label = new TextField();
			
			if(this._texf)_label.defaultTextFormat = this._texf;
			addChild(_label);
			_label.mouseEnabled = false;
			_label.selectable = false;
			_label.autoSize = "left";
			if (_tipWidth>0)
			{
				_label.wordWrap=true;
				_label.width = _tipWidth - _rlGap * 2;;
			}
			if (_tipHeight>0) 
			{
				_label.height = _tipHeight - _tbGap * 2;
			}
			
			
			
			_label.htmlText = _tip;
		}
		override public function destory():void
		{
			
		}
		
		public function get tipWidth():Number 
		{
			return _tipWidth;
		}
		
		public function set tipWidth(value:Number):void 
		{
			_tipWidth = value;
		}
		
		public function get tipHeight():Number 
		{
			return _tipHeight;
		}
		
		public function set tipHeight(value:Number):void 
		{
			_tipHeight = value;
		}
		
		public function get offestPoint():Point 
		{
			return _offestPoint;
		}
		
		public function set offestPoint(value:Point):void 
		{
			_offestPoint = value;
		}
		
		
	}

}