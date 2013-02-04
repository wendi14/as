package com.xmaser.map45.display 
{
	/**
	 * ...
	 * @author 
	 */
	public class GraphicTile extends ISOSprite 
	{
		protected var _graphic:*;
		
		public function GraphicTile(size:Number,graphic:*,overlapX:int=1,overlapY:int=1) 
		{
		
			super(size,overlapX,overlapY);
			this._graphic = graphic;
			if (_graphic)
			{
				addChild(_graphic)
				updateGraphicPosition();
				
			}
		}
		
		protected function updateGraphicPosition():void 
		{
			_graphic.x =-_graphic.width / 2;
			_graphic.y=-(_graphic.height) + size / 2;
			return;
			
			
			//showBackGround();
			//_graphic.alpha=0.2
			_graphic.x = -size;
			if (_overlapY == 1&&_overlapX==1)
			{
				_graphic.x = -_graphic.width / 2;
			}
			_graphic.y = -( _graphic.height - (_overlapY * size-size / 2)) - size / 2*(_overlapY-1);
			if (_overlapX==1&&_overlapY==1) 
			{
					_graphic.y = -(_graphic.height) + size / 2;
			}
			if (_overlapY==2 )
			{
				//trace(_graphic.y,_graphic.height, _overlapY, size,_overlapY * size-size / 2);
			}
		}
		
	}

}