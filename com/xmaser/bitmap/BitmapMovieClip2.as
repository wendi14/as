package com.xmaser.bitmap 
{
	import com.xmaser.display.component.ComponentBasic;
	import flash.display.Bitmap;
	import flash.events.Event;
	/**
	 * ...
	 * @author wdc
	 */
	public class BitmapMovieClip2 extends ComponentBasic
	{
		protected var _bitmap:Bitmap;
		private var _bitmapDataArr:Array;
		private var _loop:Boolean=true;
		protected var _nowFrame:int=0;
		private var _fps:int=30;
		private var _tickTime:Number=0
		private var k:int=0;

		public function BitmapMovieClip2() 
		{
			_bitmap = new Bitmap(null, "auto", true);
			addChild(_bitmap);
			_bitmapDataArr = new Array();
			
		}
		
		public function addBitmapDataArray(bds:Array):void 
		{
			_nowFrame = 0;
			_bitmapDataArr = _bitmapDataArr.concat(bds);
			_bitmapDataArr = (bds);
			_bitmap.bitmapData = _bitmapDataArr[0];
		}
		
		public function play():void
		{
			
			this.addEventListener(Event.ENTER_FRAME, _onEnterFrame);
			
		}
		
		public function stop():void
		{
			
			this.removeEventListener(Event.ENTER_FRAME, _onEnterFrame);
		}
		private function _onEnterFrame(e:Event):void 
		{
			
			/*if (k >= 30)
			{
				return;
			}
			k++*/
			if (_nowFrame >= _bitmapDataArr.length)
			{
				onPlayEnd()
				if (_loop) 
				{
					_nowFrame = 0;
					onLoopStart();
				}else
				{
					stop();
					return;
				}
				
			}
			if (!_bitmapDataArr)
			{
				stop()
				trace("_bitmapDataArr null",this);
				return;
			}
			_bitmap.bitmapData = _bitmapDataArr[_nowFrame];
			
			onEnterFrame()
			
			_tickTime += _fps / 30  ;
			if (_tickTime >= 1)
			{
				//trace( "_tickTime : " + _tickTime );
				_nowFrame++;
				_tickTime = ( _tickTime-1)
				
			}
			
			//trace("_nowFrame: " + _nowFrame);
		}
		
		protected function onEnterFrame():void 
		{
			
		}
		
		protected function onPlayEnd():void 
		{
			
		}
		protected function onLoopStart():void 
		{
			
		}
		override public function destory():void 
		{
			stop();
			_bitmapDataArr = null;
			removeChild(_bitmap);
			_bitmap = null;
			
		}
		
		public function gotoAndStop(n:Number):void
		{
			this.stop();
			_nowFrame = n-1;
			_bitmap.bitmapData = _bitmapDataArr[n-1];
		}
		public function gotoAndPlay(n:uint):void
		{
			_nowFrame = n - 1;
			play();
		}
		public function get fps():int 
		{
			return _fps;
		}
		
		public function set fps(value:int):void 
		{
			_fps = value;
		}
		
		public function get loop():Boolean 
		{
			return _loop;
		}
		
		public function set loop(value:Boolean):void 
		{
			_loop = value;
		}
		
	}

}