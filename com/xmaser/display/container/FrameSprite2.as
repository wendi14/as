package com.xmaser.display.container 
{
	import com.xmaser.display.component.IComponent;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class FrameSprite2 extends Sprite implements IComponent
	{
		private var _frame:Object={};
		private var _nowFrame:DisplayObject;
		private var _mcPlayEndFunc:Function;
		
		public function FrameSprite2() 
		{
			
		}
		public function addFrame(frameName:String,mc:DisplayObject):void
		{
			_frame[frameName] = mc;
			//addChild(mc);
			mc.visible = false;
		}
		public function goto(frameName:String,mcPlayEndFunc:Function=null):void
		{
			if (_nowFrame)
			{
				removeChild(_nowFrame);
				_nowFrame.visible = false;
			}
			_frame[frameName].visible = true;
			
			
			
			_nowFrame = _frame[frameName];
			addChild(_nowFrame);
			
			MovieClip(_nowFrame).gotoAndPlay(1);
			addEventListener(Event.ENTER_FRAME, function(e:Event):void {
				trace(MovieClip(_nowFrame).currentFrame);
				if (MovieClip(_nowFrame).currentFrame == MovieClip(_nowFrame).totalFrames)
				{
					removeEventListener(e.type, arguments.callee);
					if(mcPlayEndFunc!=null)mcPlayEndFunc.call();
				}
				
			}
			)
		}
		
		
		override public function get width():Number 
		{
			return super.width;
		}
		
		override public function set width(value:Number):void 
		{
			for each (var item:* in _frame) 
			{
				item.width = value;
			}
		}
		override public function get height():Number 
		{
			return super.height;
		}
		
		override public function set height(value:Number):void 
		{
			for each (var item:* in _frame) 
			{
				item.height = value;
			}
		}
		public function destory():void
		{
			var i:int = 0;
			while (this.numChildren>0) 
			{
				
				this.removeChildAt(i);
			}
		}
		
	}

}