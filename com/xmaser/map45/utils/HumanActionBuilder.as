package com.xmaser.map45.utils 
{
	import cn.hcxmflash.container.render.ItemRender;
	import com.xmaser.bitmap.AnimationBitmap;
	import com.xmaser.bitmap.ImageDecoder;
	import com.xmaser.map45.human.Action;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author 
	 */
	public class HumanActionBuilder extends EventDispatcher 
	{
		private var _obj:Object;
		private var _action:Action;
		private var testT:Number;
		public function get animations():Object { return _obj; }
		
		public function get obj():Object 
		{
			return _obj;
		}
		
		public function get action():Action 
		{
			return _action;
		}
		public function HumanActionBuilder(arr:Object=null) 
		{
			_obj = { };
			if (arr == null) 
			{
				return;
			}
			for  (var item:String in arr) 
			{
				
				//ani.name = name;
				var ac:Action=new Action()
				obj[item] = ac
				
				for (var name:String in arr[item]) 
				{
					var ani:AnimationBitmap = new AnimationBitmap();
					ac[name] = ani;
					ani.loadPic(arr[item][name],null)
					
				}
			}
			trace("a")
		}
		public function buildMod(url:String):void
		{
			var u:URLStream = new URLStream()
			u.endian = Endian.LITTLE_ENDIAN;
			var re:URLRequest = new URLRequest(url);
			u.addEventListener(Event.COMPLETE, __c)
			u.addEventListener(SecurityErrorEvent.SECURITY_ERROR, __se_);
			u.load(re)
		}
		
		private function __se_(e:SecurityErrorEvent):void 
		{
			
		}
		public function parse(bytes:ByteArray):void
		{
			testT=getTimer()
			_action = new Action();
			
			var o:Object = bytes.readObject();
			
			var ab:ByteArray = o._unitObj.idle[0][0];
			var j:int = 0;
			var n:int = 0;
			
			
			function onC(bd:*,ar:*):void
			{
				//trace("n");
				//testT = getTimer() - testT;
				//trace(testT)
				//testT= getTimer() 
				AnimationBitmap(ar[0]).addBitmapData(bd,ar[1],ar[2]);
				n--
				if (n == 0)
				{
					parseComplete()
				}
			}
			
			for (var name:String in o._unitObj) 
			{
				_action[name] = [];
				j = 0;
				//walk
				for each (var item:* in o._unitObj[name]) 
				{
					
					var itemss:Array = [];
					var k:int = 0;
					_action[name][j]=new AnimationBitmap()
					for each (var item2:* in item) 
					{
						/*var l:Loader = new Loader();
						var oo:Object = o._unitRectObj[name][j][k];
						l.x = oo.x;
						l.y = oo.y;
						l.loadBytes(item2);
						itemss.push(l);*/
						var oo:Object = o._unitRectObj[name][j][k];
						//ImageDecoder.bytesToBitmapData(item2,onC, [_action[name][j], oo, k])
						
						if (name == "walk")
						{
							new ImageDecoder(item2, onC, [_action[name][j], oo, k]);
							k++;
							n++;
						}
						
						//trace("n",n);
						
					}
					
					j++;
					
					
				}
				
				
				/*var jaa:Array=[7,5,6]
				for (var i:int = j; i < 8; i++) 
				{
					item = o._unitObj[name][i - 4];
					itemss = []
					k = 0;
					for each (var item2:* in item) 
					{
						
						var l:Loader = new Loader();
						var oo:Object = o._unitRectObj[name][i-4][k];
						l.x = oo.x;
						l.y = oo.y;
						//l.x += oo.width;
						//l.scaleX  = -1;
						
						l.loadBytes(item2);
						itemss.push(l);
						k++
					}
				}*/
				
			}
			testT = getTimer() - testT;
			testT = getTimer() - testT;
		}
		
		private function parseComplete():void 
		{
			testT = getTimer() - testT;
			dispatchEvent(new Event(Event.COMPLETE))
		}
		private function __c(e:Event):void 
		{
			_action = new Action();
			var u:URLStream = e.target as URLStream;
			var o:Object = u.readObject();
			
			var ab:ByteArray = o._unitObj.idle[0][0];
			var j:int = 0;
			var item2:*
			for (var name:String in o._unitObj) 
			{
				_action[name] = [];
				j = 0;
				//walk
				for each (var item:* in o._unitObj[name]) 
				{
					
					var itemss:Array = [];
					var k:int = 0;
					for each (item2 in item) 
					{
						var l:Loader = new Loader();
						var oo:Object = o._unitRectObj[name][j][k];
						l.x = oo.x;
						l.y = oo.y;
						l.loadBytes(item2);
						itemss.push(l);
						k++;
						
					}
					_action[name][j]=new AnimationBitmap(itemss)
					j++;
					
					
				}
				var jaa:Array=[7,5,6]
				for (var i:int = j; i < 8; i++) 
				{
					item = o._unitObj[name][i - 4];
					itemss = []
					k = 0;
					for each (item2 in item) 
					{
						
						var l2:Loader = new Loader();
						var oo2:Object = o._unitRectObj[name][i-4][k];
						l2.x = oo2.x;
						l2.y = oo2.y;
						//l.x += oo.width;
						//l.scaleX  = -1;
						
						l2.loadBytes(item2);
						itemss.push(l2);
						k++
						
					}
					if ((i - 4) == 1)
					{
						_action[name][7]=new AnimationBitmap(itemss,-1,o._width)
					}else if ((i - 4) == 2)
					{
							_action[name][6]=new AnimationBitmap(itemss,-1,o._width)
					}else if ((i - 4) == 3)
					{
							_action[name][5]=new AnimationBitmap(itemss,-1,o._width)
						
					}
						
						
					//_action[name][jaa[i-5]]=new AnimationBitmap(itemss)
				}
			}
			_action.width = o._width;
			_action.height = o._height;
			dispatchEvent(new Event(Event.COMPLETE))
		}
	}

}