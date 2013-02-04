package com.xmaser.display.component.butotn 
{
	import com.xmaser.assets.asset_tabButton_disabled;
	import com.xmaser.assets.asset_tabButton_down;
	import com.xmaser.assets.asset_tabButton_left_disabled;
	import com.xmaser.assets.asset_tabButton_left_down;
	import com.xmaser.assets.asset_tabButton_left_normal;
	import com.xmaser.assets.asset_tabButton_left_over;
	import com.xmaser.assets.asset_tabButton_left_selected;
	import com.xmaser.assets.asset_tabButton_normal;
	import com.xmaser.assets.asset_tabButton_over;
	import com.xmaser.assets.asset_tabButton_right_disabled;
	import com.xmaser.assets.asset_tabButton_right_down;
	import com.xmaser.assets.asset_tabButton_right_normal;
	import com.xmaser.assets.asset_tabButton_right_over;
	import com.xmaser.assets.asset_tabButton_right_selected;
	import com.xmaser.assets.asset_tabButton_selected;
	import com.xmaser.display.component.skin.Skin_Button;
	import com.xmaser.display.container.Tab;
	
	/**
	 * ...
	 * 
	 * @author 
	 */
	public class TabButton extends Tab 
	{
		
		public function TabButton() 
		{
			skins = [
			new Skin_Button(asset_tabButton_left_normal, asset_tabButton_left_over, asset_tabButton_left_down,asset_tabButton_left_selected, asset_tabButton_left_disabled),
			new Skin_Button(asset_tabButton_normal, asset_tabButton_over, asset_tabButton_down, asset_tabButton_selected,asset_tabButton_disabled),
			new Skin_Button(asset_tabButton_right_normal, asset_tabButton_right_over, asset_tabButton_right_down, asset_tabButton_right_selected,asset_tabButton_right_disabled)]
			
			
			
		}
		override protected function createButton():ButtonComponent 
		{
			var b1:ButtonComponent = new ButtonComponent();
			b1.textFormat = _textFormat;
			b1.overTextFormat = _textFormat;
			b1.tbGap = 0
			b1.lrGap = 4;
			return b1;
		}
		override protected function addNewContent():void 
		{
			
		}
		override protected function removeOldContent():void 
		{
			
		}
		
	}

}