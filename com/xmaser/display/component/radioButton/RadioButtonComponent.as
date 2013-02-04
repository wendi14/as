package com.xmaser.display.component.radioButton 
{
	import com.xmaser.assets.asset_radio_normal;
	import com.xmaser.assets.asset_radioButton_disabled;
	import com.xmaser.assets.asset_radioButton_down;
	import com.xmaser.assets.asset_radioButton_over;
	import com.xmaser.assets.asset_radioButton_selected;
	import com.xmaser.assets.asset_radioButton_selected_disabled;
	import com.xmaser.assets.asset_radioButton_selected_down;
	import com.xmaser.assets.asset_radioButton_selected_normal;
	import com.xmaser.assets.asset_radioButton_selected_over;
	import com.xmaser.assets.asset_radioButton_selected_selected;
	import com.xmaser.display.component.butotn.ButtonComponent;
	import com.xmaser.display.component.skin.Skin_Button;
	import com.xmaser.display.container.radioButton.RadioGroupContainer;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class RadioButtonComponent extends ButtonComponent 
	{
		private var _data:String;
		private var _group:RadioGroupContainer;
		public function RadioButtonComponent() 
		{
			
		}
		override protected function drawUI():void 
		{
			_skinSkin = new Skin_Button();
			_skinSkin.normal = asset_radio_normal;
			_skinSkin.over = asset_radioButton_over;
			_skinSkin.down = asset_radioButton_down;
			_skinSkin.selected = asset_radioButton_selected
			_skinSkin.disabled = asset_radioButton_disabled;
			
			_skinSkin.selected_normal = asset_radioButton_selected_normal;
			_skinSkin.selected_over = asset_radioButton_selected_over;
			_skinSkin.selected_down = asset_radioButton_selected_down;
			_skinSkin.selected_selected = asset_radioButton_selected_selected;
			_skinSkin.selected_disabled = asset_radioButton_selected_disabled;
			
			_toggle = true;
			
			super.drawUI();
		}
		override protected function align():void 
		{
			if (_holdSkinSp)
			{
				
				_txt.x = _holdSkinSp.x + _holdSkinSp.width + 4;
			}
		}
		override protected function clickHandler():void 
		{
			super.clickHandler();
			
			_group.update(this)
		}
		public function get group():RadioGroupContainer 
		{
			return _group;
		}
		
		public function set group(value:RadioGroupContainer):void 
		{
			_group = value;
			_group.addItem(this);
		}
		
		public function get data():String 
		{
			return _data;
		}
		
		public function set data(value:String):void 
		{
			_data = value;
		}
		
	}

}