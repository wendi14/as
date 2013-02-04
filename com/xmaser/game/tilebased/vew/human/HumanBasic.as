package com.xmaser.game.tilebased.vew.human 
{
	import com.xmaser.game.tilebased.model.TileVO;
	import com.xmaser.game.tilebased.vew.TileItemBasic;
	import com.xmaser.game.tilebased.vew.TileMap;
	import flash.geom.Point;
	
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
	public class HumanBasic extends TileItemBasic 
	{
		public var map:TileMap;
		protected var _speed:Number=4;
		protected var _newXTile:Number;
		protected var _newYTile:Number;
		protected var _upLeft:TileVO;
		protected var _upRight:TileVO;
		protected var _downRight:TileVO;
		protected var _downLeft:TileVO;
		
		protected var _jumpStart:Number = -28; //越小越高
		protected var _gravity:Number = 2;//越大在空中待的时候越短
		protected var _isJumping:Boolean = false;
		protected var _jumpSpeed:Number = 0;
		protected var _xyarr:Array=[];
		protected var _atJumpXYarr:Array=[];
		public function HumanBasic() 
		{
			type = 10000;
		}
		
		/**
		 * 人物行走
		 * @param	dirx	朝左右，１右，－１左
		 * @param	diry	朝上下，１下，－１上
		 * @param	jump		跳跃　１下，－１上
		 */
		public function go(dirx:Number, diry:Number,jump:int):void 
		{
			
			var xx:Number = x;; var yy:Number = y;
			var movespeed:Number = _speed;
			if (Math.abs(jump)==1) 
			{
				movespeed=_jumpSpeed*jump
			}else
			{
				
			}
			
			calCorner(x, y + diry * movespeed);
			if (diry==-1) 
			{
				
				//trace( "向上 : "  );
				
				if (_upLeft.walkable && _upRight.walkable)
				{
					yy+=(diry*movespeed)
				}else
				{
					yy = _upLeft.y+ _upLeft.tileHeight;
					_jumpSpeed = 0;
				}
				
			}
			if (diry==1) 
			{
				//trace( "_downLeft.walkable : " + _downLeft.walkable );
				//trace( "_downRight.walkable : " + _downRight.walkable );
				if (_downLeft.walkable&&_downRight.walkable&&!checkIfOnCloud()) 
				{
					
					
					yy += (diry * movespeed);
					
				}else 
				{
					yy = _downLeft.y - tileHeight ;
					
					_isJumping = false;
				}
			}
			
			calCorner(x+dirx*movespeed, y );
			
			if (dirx==-1) 
			{
				if (_upLeft.walkable&&_downLeft.walkable) 
				{
					xx += (dirx * movespeed);
					
				}else 
				{
					xx = _upLeft.x + _upLeft.tileWidth;
				}
				fall()
			}
			if (dirx==1) 
			{
				if (_upRight&&_upRight.walkable&&_downRight.walkable) 
				{
					xx+=(dirx*movespeed)
				}else 
				{
					try 
					{
						xx = _upRight.x - tileWidth;
					}catch (err:Error)
					{
						
					}
				}
				fall();
				
			}
			
			updatePosition(xx, yy,dirx,diry);
			
			
			_atJumpXYarr.push(new Point(x, y))
		}
		
		protected function updatePosition(xx:Number,yy:Number,dirx:int,diry:int):void 
		{
			x = xx
			y = yy;
			
			if (dirx == -1)
			{
				xTile = Math.floor(x / tileWidth);
			}else
			{
				xTile = Math.floor((x+tileWidth-1)/ tileWidth);
			}
			if (diry==-1) 
			{
				yTile = Math.floor(y / tileHeight);
			}else 
			{
				yTile = Math.floor((y+tileHeight-1) / tileHeight);
			}
				
		}
		
		public function fall():void 
		{
			if (_isJumping == false)
			{
				calCorner(x, y + 1);
				
				if (_downRight.walkable&&_downLeft.walkable&&!checkIfOnCloud()) 
				{
					_isJumping = true;
					_jumpSpeed = 0;
				}
			}
		}
		private function checkIfOnCloud():Boolean
		{
			return _downLeft.isCloud || _downRight.isCloud;
		}
		public function calCorner(newX:Number, newY:Number):void 
		{
			//trace( "newX : " + newX );
			//trace( "newY : " + newY );
			//在新位置的时候，计算出四个角的相对应区块
			
		
			
			var leftX:Number = Math.floor(newX / tileWidth);
			//trace( "leftX : " + leftX );
			var rightX:Number = Math.floor((newX + tileWidth-1) / tileWidth);
			//trace( "rithX : " + rightX );
			var upY:Number = Math.floor(newY / tileHeight);
			//trace( "upY : " + upY );
			var downY:Number = Math.floor((newY + tileHeight-1) / tileHeight);
			//trace( "downY : " + downY );
			 if (downY >= map.tiles.length)
			{
				die()
				return;
			}
  			_upLeft = map.tiles[upY][leftX];
			_upRight=map.tiles[upY][rightX];;
			_downLeft=map.tiles[downY][leftX];;
			_downRight=map.tiles[downY][rightX];;
		
			
		}
		
		protected function die():void 
		{
			
		}
		
		public function jump():void 
		{
			_jumpSpeed += _gravity;
			if (_jumpSpeed > tileHeight)
			{
				_jumpSpeed = tileHeight;
				
			}
			if (_jumpSpeed<0) 
			{
				go(0, -1,-1);
			}else if (_jumpSpeed>0) 
			{
				go(0,1,1)
			}
			
		}
		
		public function get speed():Number 
		{
			return _speed;
		}
		
		public function set speed(value:Number):void 
		{
			_speed = value;
		}
		
		public function get isJumping():Boolean 
		{
			return _isJumping;
		}
		
		public function set isJumping(value:Boolean):void 
		{
			_isJumping = value;
		}
		
		public function get jumpSpeed():Number 
		{
			return _jumpSpeed;
		}
		
		public function set jumpSpeed(value:Number):void 
		{
			_jumpSpeed = value;
		}
		
		public function get jumpStart():Number 
		{
			return _jumpStart;
		}
		
		public function get xyarr():Array 
		{
			return _xyarr;
		}
		
		public function get atJumpXYarr():Array 
		{
			return _atJumpXYarr;
		}
		
	}

}