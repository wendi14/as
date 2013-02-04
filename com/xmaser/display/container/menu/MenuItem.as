package com.xmaser.display.container.menu 
{
	import com.xmaser.assets.asset_menu_b_disabled;
	import com.xmaser.assets.asset_menu_b_disabled_over;
	import com.xmaser.assets.asset_menu_b_down;
	import com.xmaser.assets.asset_menu_b_normal;
	import com.xmaser.assets.asset_menu_b_over;
	import com.xmaser.assets.asset_menu_b_selected;
	import com.xmaser.display.component.butotn.IconButtonComponent;
	import com.xmaser.display.component.skin.Skin_Button;
	import flash.display.Shape;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class MenuItem extends IconButtonComponent 
	{
		private var _menuLabel:String;
		private var _menuData:*;
		private var _data:Object;
		
		public function MenuItem(da:Object) 
		{
			_data = da;
			_menuLabel = da.label;
			_menuData = da.data;
			_lrGap = 0;
			_iconHGap=10
			this.autoSize = false;
			this.label = _menuLabel;
			if (da.icon == null)
			{
				
				var iconmc:Shape = new Shape()
				iconmc.graphics.beginFill(0, 0.1);
				iconmc.graphics.drawRect(0, 0, 32, 32);
				iconmc.graphics.endFill();
				this.icon = iconmc;
			}else
			{
				this.icon = da.icon;
			}
			
		}
		
		override protected function initSkin():void 
		{
			_skinSkin = new Skin_Button(asset_menu_b_normal, asset_menu_b_over, asset_menu_b_down, asset_menu_b_selected, asset_menu_b_disabled,asset_menu_b_normal,asset_menu_b_disabled_over,asset_menu_b_disabled_over,asset_menu_b_disabled_over,asset_menu_b_disabled_over);
		}
		override protected function align():void 
		{
			if(_icon)this._icon.width = this._icon.height = 32;
			super.align();
		}
		public function get data():Object 
		{
			return _data;
		}
		
		
	}

}