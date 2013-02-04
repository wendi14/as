package com.xmaser.display.container 
{
	import com.xmaser.display.component.butotn.ButtonComponent;
	import com.xmaser.display.component.butotn.VButtonComponent;
	
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class VTab extends Tab
	{
		private var vGap:Number=0;
		
		public function VTab(labs:Array,br:Array) 
		{
			super(labs, br);
		}
		override protected function createButton():ButtonComponent 
		{
			return new VButtonComponent();
		}
		override protected function rePostion():void 
		{
			super.rePostion();
			var hh:Number = 0;
			for (var i:int = 0; i < _buttonArr.length; i++) 
			{
				var item:ButtonComponent = _buttonArr[i];
				item.y = hh; 
				hh += (item.height + vGap)
				
	
				item.x = 0;
			}
		}
		override public function addChildAtIndex(content:*, ind:int):void 
		{
			super.addChildAtIndex(content, ind);
			
			_contentArr[ind].x=contentX+tabButtonWidth
				//_contentArr[ind].y = contentY + tabButtonHeight;
		}
	}

}