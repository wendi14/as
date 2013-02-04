package com.xmaser.bitmap 
{
	/**
	 * ...
	 * @author wdc
	 */
	public class AnimationBitmapMovieClip extends BitmapMovieClip2 
	{
		private var _playEndFunc:Function;
		private var _frameFunction:Array;
		
		public function AnimationBitmapMovieClip() 
		{
			
		}
		override protected function onEnterFrame():void 
		{
			if (_frameFunction&&_frameFunction.length>0)
			{
				if(_frameFunction[_nowFrame]!=null)_frameFunction[_nowFrame].call(null);
			}
			
			
		}
		override protected function onPlayEnd():void 
		{
			if (_playEndFunc != null)
			{
				_playEndFunc();
			}
		}
		
		public function get playEndFunc():Function 
		{
			return _playEndFunc;
		}
		
		public function set playEndFunc(value:Function):void 
		{
			_playEndFunc = value;
		}

		
		public function set frameFunction(value:Array):void 
		{
			_frameFunction = value;
		}
	}

}