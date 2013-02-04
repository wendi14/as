package com.xmaser.bitmap 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import view.component.MagicEffect;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class BitmapMovieClip extends Sprite 
	{
		protected var _bitmap:Bitmap;
		protected var _bitmapDataArr:Array;
		private var _nowFrame:int=0;
		private var _fps:int=30;
		private var _timer:Timer;
		private var _loop:Boolean=false;
		private var _plyaEndFunction:Function;
		private var _stopFrame:Number=-1;
		private var _frameFunction:Array;
		public function BitmapMovieClip() 
		{
			_bitmap = new Bitmap(null, "auto", true);
			addChild(_bitmap);
			_bitmapDataArr = new Array();

		}
		
		
		public function addBitmapDataArray(bds:Array):void
		{
			_bitmapDataArr = _bitmapDataArr.concat(bds);
			_bitmapDataArr =(bds);
		}
		public function addBitmapData(bd:BitmapData):void
		{
			_bitmapDataArr.push(bd);
		}
		
		public function play():void
		{
			_nowFrame = 0;
			clearTimer();
			
			var delay:int = 1000 / _fps;
			_timer = new Timer(delay);
			_timer.addEventListener(TimerEvent.TIMER, onTimer)
			
			_bitmap.bitmapData = _bitmapDataArr[_nowFrame];
			
			
			_timer.start()
		}
		
		private function clearTimer():void 
		{
			if (this._timer) 
			{
				_timer.reset()
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER, onTimer);
				
			}
			_timer = null;
		}
		public function stop():void
		{
			
			_timer.stop();
		}
		private function onTimer(e:TimerEvent):void 
		{
			_nowFrame++;
			//trace("_nowFrame: " + _nowFrame);
			
			if (_nowFrame >= _bitmapDataArr.length)
			{
				if (_loop) 
				{
					_nowFrame = 0;
					onLoopStart();
				}else
				{
					stop();
					if (_plyaEndFunction != null)
					{
						_plyaEndFunction.call();
					}
					return;
					
				}
				
				
			}
			if (_frameFunction&&_frameFunction.length>0)
			{
				if(_frameFunction[_nowFrame]!=null)_frameFunction[_nowFrame].call(null);
			}
			//if(this is MagicEffect)trace("onTimer: " + this.name, this._timer,e.currentTarget.);
			if (!this._timer)
			{
				return;
			}
			if (_stopFrame != -1&&_nowFrame==_stopFrame)
			{
				_nowFrame--
				return;
			}
			_bitmap.bitmapData = _bitmapDataArr[_nowFrame];
		}
		public function stopAt(number:Number):void 
		{
			_stopFrame = number
			;
		}
		protected function onLoopStart():void 
		{
			
		}
		
		public function destory():void 
		{
			//trace("destory: " + this.name);
			
			clearTimer()
			_bitmapDataArr = null;
			removeChild(_bitmap);
			_bitmap = null;
			this.parent.removeChild(this)
		}
		
		public function get loop():Boolean 
		{
			return _loop;
		}
		
		public function set loop(value:Boolean):void 
		{
			_loop = value;
		}
		
		public function get fps():int 
		{
			return _fps;
		}
		
		public function set fps(value:int):void 
		{
			_fps = value;
		}
		
		public function get bitmap():Bitmap 
		{
			return _bitmap;
		}
		
		public function set plyaEndFunction(value:Function):void 
		{
			_plyaEndFunction = value;
		}
		
		public function get frameFunction():Array 
		{
			return _frameFunction;
		}
		
		public function set frameFunction(value:Array):void 
		{
			_frameFunction = value;
		}
	}

}