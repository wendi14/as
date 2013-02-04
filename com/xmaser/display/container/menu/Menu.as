package com.xmaser.display.container.menu 
{
	import com.xmaser.assets.asset_menu_bg;
	import com.xmaser.display.component.ComponentBasic;
	import com.xmaser.events.MenuEvent;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class Menu extends ComponentBasic 
	{
		private var _dataProvider:Array;
		private var _bg:MovieClip;
		private var _hh:Number=10;
		private var _vGap:Number=6;
		private var _items:Array=[];
		
		[Event(name="menuSelected",type=" com.xmaser.events.MenuEvent")]
		
		public function Menu() 
		{
			
		}
		override protected function drawUI():void 
		{
			super.drawUI();
			_bg =new asset_menu_bg()
			addChild(_bg);
		}
		override protected function init():void 
		{
			super.init();
			//stage.addEventListener(MouseEvent.MOUSE_UP, __MOUSE_UP);
		}
		
		
		public function addMenuItem(item:MenuItem):void
		{
			addChild(item);
			item.toggle = true;
			item.width = this.width - 8;
			item.addEventListener(MouseEvent.CLICK, __itemCLICK);
			item.addEventListener(MouseEvent.MOUSE_UP, __itemMOUSE_UP);
			item.height = 34
			item.y += _hh;
			item.x = 4
			_hh += item.height + _vGap;
			_items.push(item);
		}
		
		private function __itemMOUSE_UP(e:MouseEvent):void 
		{
			if (MenuItem(e.currentTarget).disabled)
			{
				e.stopImmediatePropagation()
			}
		}
		
		public function disabledByData(arg1:Object):void 
		{
			for each (var item:MenuItem in _items) 
			{
				if (item.data.data == arg1)
				{
					item.disabled = true;
				}
			}
		}
		
		private function __itemCLICK(e:MouseEvent):void 
		{
			if (e.currentTarget.disabled)
			{
				e.stopPropagation();
				return;
			}
			dispatchEvent(new MenuEvent(MenuEvent.MENU_SELECTED, e.currentTarget.data));
		}
		public function get dataProvider():Array 
		{
			return _dataProvider;
		}
		
		public function set dataProvider(value:Array):void 
		{
			_dataProvider = value;
			
			for (var i:int = 0; i < value.length; i++) 
			{
				var item:MenuItem = new MenuItem(value[i]);
				addMenuItem(item);
			}
		}
		override public function get width():Number 
		{
			return super.width;
		}
		
		override public function set width(value:Number):void 
		{
			_bg.width = value;
		}
		override public function get height():Number 
		{
			return super.height;
		}
		
		override public function set height(value:Number):void 
		{
			_bg.height = value;
		}
		
	}

}