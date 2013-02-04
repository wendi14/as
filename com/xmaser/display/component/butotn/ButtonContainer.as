package com.xmaser.display.component.butotn 
{
	import com.xmaser.display.container.FrameSprite;
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class ButtonContainer extends FrameSprite
	{
		
		public function ButtonContainer() 
		{
			
		}
		
		public function reSet():void
		{
			var i:int = 0;
			var mc:DisplayObject
			while (i < this.numChildren)
			{
				mc = this.getChildAt(i);
				mc.scaleX = mc.scaleY=1;
				;
				i++;
			}
		}
		override public function get height():Number 
		{
			return super.height;
		}
		
		override public function set height(value:Number):void 
		{
			
			//super.height = value;
			var i:int = 0;
			var mc:DisplayObject
			while (i < this.numChildren)
			{
				mc = this.getChildAt(i);
				mc.height = value;
				;
				i++;
			}
		}
		override public function get width():Number 
		{
			return super.width;
		}
		
		override public function set width(value:Number):void 
		{
			
			//super.width = value;
			var i:int = 0;
			var mc:DisplayObject
			while (i < this.numChildren)
			{
				mc = this.getChildAt(i);
				mc.width = value;
				
				i++;
			}
		}
		override public function destory():void 
		{
			super.destory();
			
		}
		
	}

}