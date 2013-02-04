package com.xmaser.a_start 
{
	/**
	 * ...
	 * @author 
	 */
	public class Grid 
	{
		private var _nodes:Array=[];
		private var _endNode:Node;
		private var _startNode:Node;
		private var _numCols:Number;
		private var _numRows:Number;
		
		/**
		 * 
		 * @param	numCols   横的有几个
		 * @param	numRows	竖的有几个
		 */
		public function Grid(numCols:Number,numRows:Number) 
		{
			this._numRows = numRows;
			this._numCols = numCols;
			_nodes=[]
			for (var i:int = 0; i < numRows; i++) 
			{
				_nodes[i]=[]
				for (var j:int = 0; j <numCols; j++) 
				{
					var node:Node = new Node();
					node.x =j
					node.y = i;
					_nodes[i][j] = node;
				}
				
			}
		}
		public function setStartNode(x:int,y:int):void 
		{
			_startNode = _nodes[y][x];
		}
		public function setEndNode(x:int,y:int):void 
		{
			_endNode = _nodes[y][x];
		}
		public function getNode(x:int, y:int):Node
		{
			return _nodes[y][x] as Node;
		}
		
		/**
		 * _nodes[x][y].walkable = value;
		 * @param	x  
		 * @param	y
		 * @param	value
		 */
		public function setWalkable(x:int, y:int, value:Boolean):void
		{
			_nodes[y][x].walkable = value;
		}
		
		public function get numCols():Number 
		{
			return _numCols;
		}
		
		public function get numRows():Number 
		{
			return _numRows;
		}
		
		public function get startNode():Node 
		{
			return _startNode;
		}
		
		public function get endNode():Node 
		{
			return _endNode;
		}
		
	}

}