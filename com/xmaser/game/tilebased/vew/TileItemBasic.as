package com.xmaser.game.tilebased.vew 
{
	import com.xmaser.game.tilebased.model.TileVO;
	import flash.display.Sprite;
	
	/**
	 * ...规则

让我们列一下关于梯子的规则：

1. 通过上下方向键，英雄可以在梯子上上下移动
2. 当英雄和梯子接触时，他可以爬上去
3. 当英雄和梯子接触，且下方也有梯子时，他可以爬下来
4. 当英雄在梯子上，且左右没有墙时，他可以左右移动
5. 英雄不能在梯子上跳跃

	 * @author 
	 */
	public class TileItemBasic extends Sprite 
	{
		private var _type:int;
		private var _walkable:Boolean=false;
		private var _data:*;
		private var _xTile:Number;
		private var _yTile:Number;
		private var _tileWidth:Number;
		private var _tileHeight:Number;
		
		private var _isCloud:Boolean = false;
		private var _isLadder:Boolean = false;
		
		private var _vo:TileVO;
		public function TileItemBasic() 
		{
			
		}
		
		public function drawTestBg(tileWidth:Number, tileHeight:Number):void 
		{
			this._tileHeight = tileHeight;
			this._tileWidth = tileWidth;
			this.graphics.clear();
			this.graphics.lineStyle(0.1);
			this.graphics.beginFill(getColor());
			this.graphics.drawRect(0, 0, tileWidth, tileHeight);
			this.graphics.endFill();
			
		}
		
		protected function getColor():uint 
		{
			var co:uint;
			switch (_type) 
			{
				case 0:
					co=0xffffff
				break;
				case 1:
					co=0x000000
				break;
				case 10000:
					co=0xff0000
				break;
				default:
					co = 0xcccccc;
				break;
			}
			return co;
		}
		
		public function get type():int 
		{
			return _type;
		}
		
		public function set type(value:int):void 
		{
			_type = value;
			
			
		}
		
		public function get xTile():Number 
		{
			return _xTile;
		}
		
		public function set xTile(value:Number):void 
		{
			_xTile = value;
		}
		
		public function get yTile():Number 
		{
			return _yTile;
		}
		
		public function set yTile(value:Number):void 
		{
			_yTile = value;
		}
		
		public function get tileHeight():Number 
		{
			return _tileHeight;
		}
		
		public function set tileHeight(value:Number):void 
		{
			_tileHeight = value;
		}
		
		public function get tileWidth():Number 
		{
			return _tileWidth;
		}
		
		public function set tileWidth(value:Number):void 
		{
			_tileWidth = value;
		}
		
		public function get walkable():Boolean 
		{
			return _walkable;
		}
		
		public function set walkable(value:Boolean):void 
		{
			_walkable = value;
		}
		
		public function get isCloud():Boolean 
		{
			return _isCloud;
		}
		
		public function set isCloud(value:Boolean):void 
		{
			_isCloud = value;
		}
		
		public function get vo():TileVO 
		{
			return _vo;
		}
		
		public function set vo(value:TileVO):void 
		{
			_vo = value;
			
			type = _vo.type;
			walkable = _vo.walkable;
			isCloud = _vo.isCloud;
			_isLadder = _vo.isLadder;
			xTile = _vo.xTile;
			yTile = _vo.yTile;
			
		}
		
		public function destory():void
		{
			while (this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
		}
	}

}