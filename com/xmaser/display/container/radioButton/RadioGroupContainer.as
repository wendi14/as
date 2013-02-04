package com.xmaser.display.container.radioButton 
{
	import com.xmaser.display.component.radioButton.RadioButtonComponent;
	import com.xmaser.display.container.radioButton.RadioGroupContainer;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class RadioGroupContainer extends  Object
	{
		private var _slectedItem:RadioButtonComponent;
		private var _ridioButtonArr:Array;
		
		public function RadioGroupContainer() 
		{
			_ridioButtonArr=[]
		}
		
		public function update(radioButtonComponent:RadioButtonComponent):void 
		{
			for each (var item:RadioButtonComponent in _ridioButtonArr ) 
			{
				item.selected = false;
			}
			if (radioButtonComponent.selected == false)
			{
				radioButtonComponent.selected = true;
				_slectedItem = radioButtonComponent;
			}else
			{
				
			}
		}
		
		public function addItem(value:RadioButtonComponent):void 
		{
			_ridioButtonArr.push(value);
			if (_ridioButtonArr.length == 1)
			{
				value.selected = true
			}
		}
		
		public function get slectedItem():RadioButtonComponent 
		{
			return _slectedItem;
		}
		
	}

}