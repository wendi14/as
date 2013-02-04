package com.xmaser.game.tilebased.model 
{
	import com.xmaser.game.tilebased.vew.TileItemBasic;
	/**
	 * ...
	 * @author 
	 */
	public class TileVO extends Object 
	{
		private var _type:int;
		public var walkable:Boolean=false;
		public var data:*;
		public var xTile:Number;
		public var yTile:Number;
		public var tileWidth:Number;
		public var tileHeight:Number;
		
		public var isCloud:Boolean = false;
		public var isLadder:Boolean = false;
		public var x:Number;
		public var y:Number;
		
		public var width:Number;
		public var height:Number;
		
		public var realTile:TileItemBasic
		public function TileVO() 
		{
			
		}
		
		public function get type():int 
		{
			return _type;
		}
		
		public function set type(value:int):void 
		{
			_type = value;
			
			if (_type == 1)
			{
				walkable = false;
			}else if(_type==0)
			{
				walkable = true;
				
			}else if (_type==10000)
			{
				
			}
			else
			{
				walkable = true;
			}
		}
		
	}

}