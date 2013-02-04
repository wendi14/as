package com.xmaser.bitmap 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author 
	 */
	public class AnimationBitmap extends Sprite 
	{
		static public const LOADED:String = "loaded";
		private var _timer:Timer;
		private var _bitmapArr:Array;
		private var _nowFrame:Number;
		private var _totalFrame:uint;
		private var _loaded:Boolean=false;
		private var _isPlaying:Boolean = false;
		public function AnimationBitmap(ar:Array = null, dir:int = 1 , width:Number = 0 ) 
		{
				_hold.scaleX = dir;
				_hold.x = width;
				
				_bitmapArr=[]
			if (ar) 
			{
				for (var i:int = 0; i < ar.length; i++) 
				{
					_bitmapArr.push(new Bitmap(ar[i]))
				}
				
				
				init();
			}
		}
		public function addBitmapData(bd:BitmapData,o:Object=null,ind:int=-1):void
		{
			var b:Bitmap = new Bitmap(bd);
			b.x = o.x; b.y = o.y;
			b.name = "b" + ind;
			_bitmapArr.push(b);
			_bitmapArr.sortOn("name", Array.NUMERIC);
		}
		private var _hold:Sprite = new Sprite();
		private var _drawRec:Rectangle;
		private function init():void 
		{
			
			_nowFrame = 0
			_totalFrame = _bitmapArr.length;
		
			addChild(_hold)
			_hold.addChild(_bitmapArr[_nowFrame]);
			
			if (	_hold.scaleX == -1)
				{
					_hold.x = _hold.width;
				}
				//showBackGround()
			if (_totalFrame == 1) return;
			_timer = new Timer(50);
			_timer.addEventListener(TimerEvent.TIMER, __TIMER);
			
			
			_loaded = true;
			
		}
		public function showBackGround():void
		{
			var s:Shape = new Shape()
			s.graphics.beginFill(0xff0000, 0.4);
			s.graphics.drawRect(0,0,this.width, this.height);
			s.graphics.endFill()
			addChildAt(s, 0);
		}
		private function __TIMER(e:TimerEvent):void 
		{
			_nowFrame++;
			if (_nowFrame>=_totalFrame) 
			{
				_nowFrame = 0;
			}
			_hold.removeChildAt(0);
			
			_hold.addChild(_bitmapArr[_nowFrame]);
			
		}
		public function stop():void
		{
			_timer.stop()
		}
		public function play():void
		{
			_timer.start()
			_isPlaying = true;
		}
		public function destory():void
		{
			_timer.stop()
			_timer.removeEventListener(TimerEvent.TIMER, __TIMER);
			_timer = null;
			try 
			{
				removeChildAt(0);
			}catch (err:Error)
			{
				
			}
		}
		
		public function loadPic(pic:String,rec:Rectangle):void 
		{
			_drawRec = rec;
			var l:Loader = new Loader()
			l.load(new URLRequest(pic));
			l.contentLoaderInfo.addEventListener(Event.COMPLETE,__lll)
		}
		
	
		private function __lll(e:Event):void 
		{
			var c:*= e.target.content;
			var ar:Array = BitmapUtils.buildRows(c.bitmapData, _drawRec);
			_bitmapArr = ar;
			
			init();
			dispatchEvent(new Event(LOADED))
			
		}
		
		public function get loaded():Boolean 
		{
			return _loaded;
		}
		
		public function get isPlaying():Boolean 
		{
			return _isPlaying;
		}
		
		public function set isPlaying(value:Boolean):void 
		{
			_isPlaying = value;
		}
		
	}

}