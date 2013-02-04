package com.xmaser.a_start 
{
	/**
	 * ...
	 * @author 
	 */
	public class Astar
	{
		public var main:*;
		private var _grid:Grid;
		private var _close:Array;
		private var _open:Array;
		private var _startNode:Node;
		private var _endNode:Node;
		private var _path:Array;
		
		public function Astar(grid:Grid) 
		{
			this._grid = grid;
			_open = [];
			_close = [];
			
		}
		public function findPath():void
		{
			_open = [];
			_close = [];
			
			_startNode = _grid.startNode;
			_endNode = _grid.endNode;
			
			_startNode.g = 0;
			_startNode.h = calDisFormEnd(_startNode);
			_startNode.f = _startNode.g + _startNode.h;
			
			search()
		}
		
		private function search():void 
		{
			trace("search");
			var node:Node = _startNode;
			
			trace("_startNode", _startNode.x, _startNode.y);
			trace("_endNode", _endNode.x, _endNode.y);
			
			while (node!=_endNode) 
			{
				var startX:Number = Math.max(0, node.x - 1);
				var endX:Number = Math.min(node.x + 1, _grid.numCols-1);;
				var startY:Number = Math.max(0, node.y-1);
				var endY:Number = Math.min(node.y + 1, _grid.numRows-1);;
				for (var i:int = startX; i <= endX; i++) 
				{
					for (var j:int = startY; j <= endY; j++) 
					{
						var item: Node = _grid.getNode(i, j);
						
						if (item == node || item.walkable == false||_grid.getNode(node.x,item.y).walkable==false||_grid.getNode(item.x,node.y).walkable==false)
						{
							continue;
						}
						var cost:Number =1
						if (item.x != node.x || item.y != node.y ) 
						{
							cost = Math.SQRT2;
						}
						var g:Number=node.g + cost;
						var h:Number= calDisFormEnd(item);
						var f:Number = g + h;
						
						
						if (isOpen(item) || isClose(item))
						{
							if (item.f > f)
							{
								item.g = g; item.f = f; item.h = h;
								item.parent = node;
							}
							
						}else 
						{
							item.g = g; item.f = f; item.h = h;
							item.parent = node;
							_open.push(item);
							
							
						}
					}
					
				}
				_close.push(node);
				if(main)main.drawGrid1(node.x, node.y);
				if (_open.length==0) 
				{
					trace("no path found");
					return 
				}
				_open.sortOn("f", Array.NUMERIC);
				node = _open.shift();
			}
			trace("ok")
			buildPath()
		}
		
		private function buildPath():void 
		{
			var node:Node = _endNode;
			_path = [];
			
			_path.push(node);
			
			while (node!=_startNode) 
			{
				node = node.parent;
				if(main)main.drawGrid2(node.x, node.y);
				_path.unshift(node);
				
			}trace( "_path : " + _path );
		}
		
		private function isClose(item:Node):Boolean 
		{
			for each (var it:Node in _close) 
			{
				if (it == item)
				{
					return true;
				}
			}
			return false;
		}
		
		
		private function isOpen(item:Node):Boolean 
		{
			for each (var it:Node in _open) 
			{
				if (it==item) 
				{
					return true;
				}
			}
			return false;
		}
		
		private function calDisFormEnd(startNode:Node):Number 
		{
			var dx:Number = startNode.x - _endNode.x
			var dy:Number = startNode.y - _endNode.y;
			return Math.sqrt(dx * dx + dy * dy);
		}
		
		public function get path():Array 
		{
			return _path;
		}
		
	}

}