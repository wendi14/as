package cn.hcxmflash.component
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * ...
	 * @author 小火柴
	 */
	public class Tab extends Sprite
	{
		public static const SELECTED:String="SELECTED"
		protected var _buttonArr:Array
		private var _selectedIndex:int = 0;
		public function get selectedIndex():int { return _selectedIndex; }
		public function set selectedIndex(value):void 
		{
			_selectedIndex = value;
			
			for (var i:int = 0; i < _buttonArr.length; i++) 
			{
				ButtonComponent(_buttonArr[i]).selected = false;
				
				if(i==value)ButtonComponent(_buttonArr[i]).selected = true
				
				
			}
		}
		public function Tab(labs:Array,br:Array) 
		{
			var ar:Array =labs
			_buttonArr = [];
			var startx;
			var starty;
			for (var i:int = 0; i < labs.length; i++) 
			{
				var b1:ButtonComponent = new ButtonComponent(br,4,ar[i]);
				b1.addEventListener(MouseEvent.CLICK, __bCLICK)
				b1.width
				if (i == 0)
				{
					b1.selected = true;
				}
				//trace("b1.width : " + b1.width);
				b1.isOverZoom = false;
				addChild(b1);
				if (!startx) startx = b1.width / 2;
				if (!starty) starty = b1.height / 2;
				b1.x =startx+ i * (b1.width);
				b1.y =starty;
				_buttonArr.push(b1)
			}
			rePostion()

		}
		protected function rePostion():void
		{
			
		}
		
		private function __bCLICK(e:MouseEvent):void 
		{
			
			for (var i:int = 0; i < _buttonArr.length; i++) 
			{
				if (ButtonComponent(_buttonArr[i]) == e.currentTarget)
				{
					ButtonComponent(_buttonArr[i]).selected = true
					_selectedIndex = i;
					dispatchEvent(new Event(SELECTED));
				}else
				{
					ButtonComponent(_buttonArr[i]).selected = false;
				}
			}
		}
		
	}

}