package com.xmaser.map45.display 
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author 
	 */
	public class DrawnTile extends ISOSprite 
	{
		private var _color:uint;
		private var _hasItem:Boolean = false;
		public function DrawnTile(size:Number,color:uint,height:Number=0) 
		{
			super(size);
			this._color = color;
			draw()
		}
		
		public function debug(i:int, j:int):void 
		{
			var t:TextField = new TextField()
			t.autoSize = "left";
			t.text = i + "_" + j;
			t.selectable = false;
			addChild(t);
			t.setTextFormat(new TextFormat(null, 9));
			t.x -= 4;
			t.y -= 4;
		}
		
		private function draw():void 
		{
			graphics.clear()
			graphics.beginFill( _color);
			graphics.lineStyle(0, 0, 0.4);
			graphics.moveTo( -size , 0);
			graphics.lineTo(0, -size / 2) ;
			graphics.lineTo(size, 0) ;
			graphics.lineTo(0, size/2) ;
			graphics.lineTo( -size, 0) ;
			graphics.endFill();
		}
		
		public function get hasItem():Boolean 
		{
			return _hasItem;
		}
		
		public function set hasItem(value:Boolean):void 
		{
			_hasItem = value;
		}
		
	}

}