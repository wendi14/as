package com.xmaser.game.tilebased.vew 
{
	import com.xmaser.game.tilebased.model.TileVO;
	import com.xmaser.game.tilebased.vew.human.HumanBasic;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author 
	 */
	public class TileMap extends Sprite 
	{
		private var _tileWidth:Number;
		private var _tileHeight:Number;
		protected var _mapar:Array;
		protected var _player:HumanBasic;
		private var _tiles:Array;
		protected var prevTile:TileItemBasic;
		protected var _tileItemRender:Class = TileItemBasic;
		public function TileMap() 
		{
			
		}
		public function buildMap(mapar:Array):void
		{
			if (!_tileWidth) 
			{
				throw new Error('_tileWidth 不能为0');
			}
			this._mapar = mapar;
			
			var mapW:Number = mapar[0].length;
			var mapH:Number = mapar.length;
			_tiles=[]
			for (var i:int = 0; i <mapH; i++) 
			{
				_tiles[i] = [];
				for (var j:int = 0; j < mapW; j++) 
				{
					
					var item:TileVO = new TileVO();
					item.type = mapar[i][j];
					//trace( "item.type : " + item.type );
					item.xTile = j;
					item.yTile = i;
					item.x = j * _tileWidth;
					item.y = i * _tileHeight;
					item.tileWidth = _tileWidth;
					item.tileHeight = _tileHeight;
					_tiles[i][j] = item;
				
					if (needDrawItem(_mapar[i][j]))
					{
						drawItem(item)
					}
					
				}
				
			}
		
		}
		
		protected function drawItem(item:TileVO):void 
		{
			var tile:TileItemBasic = new _tileItemRender();
			
			addChild(tile);
			tile.name = "tile" + tile.yTile + "_" + tile.xTile;
			tile.vo = item;
			tile.x = item.x; tile.y = item.y;
			tile.drawTestBg(item.tileWidth, item.tileHeight);
			item.realTile = tile;
			drawItemAfter(tile,prevTile);
			prevTile = tile;
		}
		
		protected function drawItemAfter(tile:TileItemBasic, prevTile:TileItemBasic):void 
		{
			
		}
		public function getTileItemFromXY(xx:Number,yy:Number):TileVO
		{
			var vo:TileVO
			try 
			{
				xx = Math.floor(xx / _tileWidth);
				yy = Math.floor(yy / _tileWidth);
				vo= tiles[yy][xx];
			}catch (err:Error)
			{
				
			}
			
			
			return vo;
		}
		protected function needDrawItem(itemType:int):Boolean 
		{
			return true;
		}
		
		public function addPlayer(man:HumanBasic):void 
		{
			_player = man;
			man.map = this;
			_player.drawTestBg(_tileWidth, _tileHeight);
			addChild(_player);
			_player.x = man.xTile * _tileWidth;
			_player.y = man.yTile * _tileHeight;
			
		}
		public function calPlayerCorner(man:HumanBasic,newX:Number,newY:Number):void
		{
			man.calCorner(newX, newY);
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
		
		public function get tiles():Array 
		{
			return _tiles;
		}
		
		public function set tiles(value:Array):void 
		{
			_tiles = value;
		}
		
		public function traceMap():String
		{
			var s:String=''
			for (var i:int = 0; i < _mapar.length; i++) 
			{
				
				s+=(_mapar[i]+"\n");

				
			}
			return s;
		}
		public function destory():void
		{
			while (this.numChildren>0) 
			{
				this.removeChildAt(0);
			}
		}
		
	}

}