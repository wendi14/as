package com.xmaser.display.component.tooltip 
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextFormat;
	import flash.utils.setTimeout;
	/**
	 * ...
	 * @author 小火柴
	 */
	public class StallToolTip extends ToolTip 
	{
		protected var _isRollOver:Boolean;
		
		protected var _time:int = 400;
		
		public static var nowToolTip:StallToolTip
		public function StallToolTip(mc:DisplayObject,tip:String,skin:Class=null,texf:TextFormat=null,tipWidth:int=0) 
		{
			super(mc, tip, skin, texf, tipWidth, false);
			
			this.addEventListener(MouseEvent.ROLL_OVER, __thisROLL_OVER);
			this.addEventListener(MouseEvent.ROLL_OUT, __thisROLL_OUT);
		}
		
		protected function __thisROLL_OUT(e:MouseEvent):void 
		{
			_isRollOver = false;
			setTimeout(__timeover,10)
		}
		
		private function __thisROLL_OVER(e:MouseEvent):void 
		{
			_isRollOver = true;
		}
		override protected function __ROLL_OVER(e:MouseEvent):void 
		{
			trace( "e : " + e );
			var po:Point = _mc.localToGlobal(new Point(_mc.x, _mc.height));
			po = po.add(_offestPoint);
			
			if (po.x+this.width > stage.stageWidth) po.x = stage.stageWidth - this.width;
			if (po.y + this.height > stage.stageHeight) 
			{
				po.y = po.y- this.height-_offestPoint.y;
			}
			this.x = po.x;
			this.y = po.y;
			this.visible = true;
			
			
				
			
		}
		override protected function __ROLL_OUT(e:MouseEvent):void 
		{
			
			setTimeout(__timeover,_time)
		}
		
		protected function __timeover():void 
		{
			if (_isRollOver)
			{
				
			}else
			{
				super.__ROLL_OUT(null)
			}
		}
	}

}