package com.xmaser.display.component 
{
	import com.xmaser.assets.asset_checkbox_disabled;
	import com.xmaser.assets.asset_checkbox_down;
	import com.xmaser.assets.asset_checkbox_normal;
	import com.xmaser.assets.asset_checkbox_over;
	import com.xmaser.assets.asset_checkbox_selected;
	import com.xmaser.assets.asset_checkbox_selected_disabled;
	import com.xmaser.assets.asset_checkbox_selected_down;
	import com.xmaser.assets.asset_checkbox_selected_normal;
	import com.xmaser.assets.asset_checkbox_selected_over;
	import com.xmaser.assets.asset_checkbox_selected_selected;
	import com.xmaser.display.component.butotn.ButtonComponent;
	import com.xmaser.display.component.skin.Skin_Button;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class CheckBoxComponent extends ButtonComponent 
	{
		private var _labelWidth:Number=0;
		
		public function CheckBoxComponent() 
		{
			
			
			this.addEventListener(MouseEvent.CLICK, __CLICK);
			
		}
		
		private function __CLICK(e:MouseEvent):void 
		{
			this.selected = !this.selected;
		}
		override protected function drawUI():void 
		{
			_skinSkin = new Skin_Button();
			_skinSkin.normal = asset_checkbox_normal
			_skinSkin.over = asset_checkbox_over
			_skinSkin.down = asset_checkbox_down;
			_skinSkin.selected = asset_checkbox_selected
			_skinSkin.disabled = asset_checkbox_disabled;
			
			_skinSkin.selected_normal=asset_checkbox_selected_normal
			_skinSkin.selected_over = asset_checkbox_selected_over;
			_skinSkin.selected_down = asset_checkbox_selected_down;
			_skinSkin.selected_selected = asset_checkbox_selected_selected
			_skinSkin.selected_disabled = asset_checkbox_selected_disabled
			
			_toggle = true;
			super.drawUI();
		}
		public function set labelWidth(value:Number):void 
		{
			_labelWidth = value;
			
		}
		override protected function createLabel():void 
		{
			super.createLabel();
			if (_labelWidth > 0)
			{
				_txt.autoSize = "none"
				_txt.width = _labelWidth;
			}
		}
		override protected function align():void 
		{
			if (_holdSkinSp)
			{
				
				if(_txt)_txt.x = _holdSkinSp.x + _holdSkinSp.width + 4;
			}
		}
	
		
		
	}

}