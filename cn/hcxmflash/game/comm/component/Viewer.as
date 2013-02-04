package  cn.hcxmflash.game.comm.component
{
	import cn.hcxmflash.container.HcxmSprite;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author 
	 */
	public class Viewer extends  HcxmSprite
	{
		private var _uiClass:Class;
		protected var _mc:*;
		
		private var _clickArr:Array
		public function Viewer(uiClass:Class) 
		{
			_uiClass = uiClass;
			_clickArr = [];
			
			draw()
			
			
			
			
		}
		
	
		public function destory():void
		{
			for (var i:int = 0; i < _clickArr.length; i++) 
			{
				var value:* = _clickArr[i];
				
				try 
				{
					_mc[value[0]].removeEventListener(MouseEvent.CLICK, __CLICK);
				}catch (err:Error)
				{
					this[value[0]].removeEventListener(MouseEvent.CLICK, __CLICK);
				}
				
				
				
			}
			_clickArr = null;
			_uiClass = null;
			
			
		}
		private function draw():void
		{
			if (!_uiClass) 
			{
				trace(this + ":_uiClass为空");
				drawComplete();
				return;
			}
			_mc = (new _uiClass());
			addChild(_mc);
			drawComplete();
		}
		
		public function drawComplete():void 
		{
			
		}
		/**
		 * @param value  第一个元素是实例名，第二个是点击后要执行的函数
		 */
		public function set clickFunction(value:Array):void 
		{
			//trace( "value : " + value );
			
			
			_clickArr.push(value);
			
				//trace( "_mc : " + _mc );
				//trace( "_mc[value[0]] : " + _mc[value[0]] );
				
			try 
			{
				if (this[value[0]])
			{
				this[value[0]].addEventListener(MouseEvent.CLICK, __CLICK);
				return;
			}
			}catch (err:Error)
			{
				if (_mc[value[0]] is Sprite) 
			{
				
				_mc[value[0]].buttonMode = true;
			}
			_mc[value[0]].addEventListener(MouseEvent.CLICK, __CLICK);
			}
			
			
		}
		
		public function get uiClass():Class 
		{
			return _uiClass;
		}
		
		public function set uiClass(value:Class):void 
		{
			_uiClass = value;
			draw()
		}
		
		public function get mc():* 
		{
			return _mc;
		}
		
		private function __CLICK(e:MouseEvent):void 
		{
			for (var i:int = 0; i < _clickArr.length; i++) 
			{
				if (e.currentTarget.name == _clickArr[i][0])
				{
					
					if (_clickArr[i].length > 2)
					{
						_clickArr[i][1](_clickArr[i][2]);
					}else
					{
						_clickArr[i][1]();
					}
					
					break;
				}
			}
		}
		
	}

}