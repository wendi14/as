package com.xmaser.particle 
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author 
	 */
	public class Emitter extends Sprite 
	{
		private var _shap:Class;
		private var _number:Number=20;
		private var _radius:Number=100;
		
		public function Emitter() 
		{
			
		}
		public function set shape(value:Class):void 
		{
			_shap = value;
		}
		public function set number(value:Number):void 
		{
			_number = value;
		}
		

		public function start():void
		{
			
			
			var dir:int = 1;
			
			
			
			
			
			for (var i:int = 0; i < _number; i++) 
			{
				var per:Number = 360 / _number * i;
				per = Math.PI * per / 180;
				if (Math.random() > 0.5) dir = -1;
				var ran:Number = Math.random() * 50 * dir +_radius
				var item:* = new _shap();
				addChild(item);
				
				var xx:Number=Math.cos(per*i)*ran;
				var yy:Number = Math.sin(per * i) * ran;
				var sca:Number = 1 + Math.random() * dir;
				//this.scaleX = sca; this.scaleY = sca;
				TweenLite.to(item,1,{x:xx,y:yy,rotation:360,ease:Expo.easeOut,overwrite:0})
				TweenLite.to(item,0.3,{delay:0.5,alpha:0,overwrite:0})
				TweenLite.to(item,1,{delay:0.1,overwrite:0,scaleX:0.1,scaleY:0.1})
				
			}
		}
		
	}

}