package com.xmaser.display.component.butotn 
{
	/**
	 * ...
	 * @author 小火柴
	 */
	public class VIconButtonComponent extends IconButtonComponent 
	{
		
		public function VIconButtonComponent() 
		{
			
		}
		override protected function resizeHoldSkinSp():void 
		{
			super.resizeHoldSkinSp();
			if (!_holdSkinSp || !_icon) return;
			
			
			var maxW:Number = Math.max(_txt.width, _icon.width);
			_holdSkinSp.width = _lrGap * 2 + maxW + _iconHGap;
			
			var maxH:Number = Math.max(_txt.height, _icon.height);
			maxH=_txt.height+ _icon.height
			_holdSkinSp.height = _tbGap * 2 + maxH+_iconVGap;
		}
		override protected function alignText():void 
		{
			super.alignText();
			if (!_holdSkinSp||!_icon) return;
			_icon.x = _lrGap;
			_icon.x = _holdSkinSp.width / 2 - _icon.width / 2;
			_icon.y = _tbGap;
			
			_txt.x = _holdSkinSp.width / 2 - _txt.width / 2;
			//_txt.y = _holdSkinSp.height / 2 - _txt.height / 2;
			
			
			_txt.y = _icon.y + _icon.height + _iconVGap;
			
			
		}
	}

}