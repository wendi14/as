package com.xmaser.a_start 
{
	/**
	 * ...
	 * @author 
	 */
	public class Node 
	{
		public var x:int
		public var y:int
		public var walkable:Boolean = true;
		public var f:Number;//：特定节点的全部代价。由g+h决定。
		public var g:Number//从起点到当前点的代价。
		public var h:Number//从当前点到终点的估计代价
		public var parent:Node;
		public function Node() 
		{
			
		}
		public function toString():String
		
		{
			return x + "," + y;
		}
		
	}

}