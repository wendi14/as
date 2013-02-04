package com.xmaser.bitmap 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * 从一张位图中生成数字，位置中有0到9的数字；
	 * @author hcxmflash.cn
	 */
	public class NumberBitmap extends Sprite 
	{
		private var _bitmapdata:BitmapData;
		private var _number:String;
		private var _oldBitmapArr:Array=[];
		private var _divide_width:Number;
		private var _divide_height:Number;
		
		public function NumberBitmap(number:String,bitmapdata:BitmapData,divide_width:Number,divide_height:Number) 
		{
			_bitmapdata = bitmapdata.clone();
			_number = number;
			_divide_width = divide_width;
			_divide_height = divide_height;
			
			create();
		}
		private function create():void
		{
			var k:int = 0;
			while (_number.charAt(k))
			{
				var n:String = _number.charAt(k);
				var bitmap:Bitmap = getNumberBitmap(n, _bitmapdata, _divide_width, _divide_height);
				addChild(bitmap);
				bitmap.x = k * bitmap.width;
				_oldBitmapArr.push(bitmap);
				k++;
			}
		}
		private function getNumberBitmap(n:String,bitmapdata:BitmapData,divide_width:Number,divide_height:Number):Bitmap 
		{
			var n2:Number = Number(n);
			var b:BitmapData = new BitmapData(divide_width, divide_height);
			b.copyPixels(bitmapdata, new Rectangle(n2 * divide_width, 0, divide_width, divide_height), new Point());
			var bitmap:Bitmap = new Bitmap(b,"auto",true);
			return bitmap;
				
		}
		/**
		 * 更新为当前的数字
		 * @param	nNew
		 */
		public function updateNum(nNew:String):void
		{
			clear()
			_number = nNew;
			create();
		}
		
		/**
		 * 添加数字，带滚动效果的，注意数字的位数要固定的，不然不好滚
		 * @param	addN  加上或者减少多少数值
		 */
		public function addNum(addN:Number=100):void
		{
			_number = String(Number(_number) + addN)
			trace( "_number : " + _number );
			
			var ti:Timer = new Timer(100, 100);
			ti.start()
			ti.addEventListener(TimerEvent.TIMER, __TIMER);
		}
		
		private function __TIMER(e:TimerEvent):void 
		{
			var lastN:Number = Number(_number.charAt(_number.length - 1) )+ Timer(e.target).currentCount;
			trace( "lastN : " + lastN );
			lastN = lastN % 10;
			var lastB:Bitmap = _oldBitmapArr[_oldBitmapArr.length - 1];
			var b:BitmapData = new BitmapData(_divide_width, _divide_height);
			b.copyPixels(_bitmapdata, new Rectangle((lastN) * _divide_width, 0, _divide_width, _divide_height), new Point());
			lastB.bitmapData = b;
			
			var count:int=Timer(e.target).currentCount
			for (var i:int = 0; i <_oldBitmapArr .length; i++) 
			{
				var item: Bitmap = _oldBitmapArr [i];
				
				Math.pow(10, i + 1)
				
			}
			
			
		}
		private function clear():void 
		{
			
			for (var i:int = 0; i < _oldBitmapArr.length; i++) 
			{
				var item:Bitmap = _oldBitmapArr[i];
				item.bitmapData.dispose();
				removeChild(item);
			}
			_oldBitmapArr = [];
		}
	}

}