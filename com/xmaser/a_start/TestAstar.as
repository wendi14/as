package  com.xmaser.a_start
{
	import com.xmaser.a_start.Astar;
	import com.xmaser.a_start.Grid;
	import com.xmaser.a_start.Node;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author 
	 */
	public class TestAstar extends Sprite 
	{
		private var _grid:Grid;
		private var _cellSize:Number=20;
		private var _player:Sprite;
		private var shape:Shape;
		
		public function TestAstar() 
		{
			var g:Grid = new Grid(30, 9);
			_grid = g;
			shape = new Shape();
			
			for (var i:int = 0; i < 300; i++) 
			{
				//g.setWalkable(Math.floor(Math.random() * 30), Math.floor(Math.random() * 30), false);
				
				
			}
			drawGrid()
			makePlayer();
			stage.addEventListener(MouseEvent.CLICK, onGridClick);
		}
		public function drawGrid():void
		{
			graphics.clear();
			for(var i:int = 0; i < _grid.numCols; i++)
			{
				for(var j:int = 0; j < _grid.numRows; j++)
				{
					
					if (j <5)
				{
					_grid.setWalkable(i, j, true);
				}else
				{
					_grid.setWalkable(i, j, Math.random()>0.5?false:true);
					
				}
				if (i == _grid.numCols - 1)
				{
					_grid.setWalkable(i, j, true);
				}
					var node:Node = _grid.getNode(i, j);
					graphics.lineStyle(0);
					graphics.beginFill(getColor(node));
					graphics.drawRect(i * _cellSize, j * _cellSize, _cellSize, _cellSize);
				}
				
			}
			_grid.setWalkable(1 ,1, false);
		}
		private function getColor(node:Node):uint
		{
			if(!node.walkable) return 0;
			if(node == _grid.startNode) return 0xcccccc;
			if(node == _grid.endNode) return 0xcccccc;
			return 0xffffff;
		}
		
		private function makePlayer():void
		{
			_player = new Sprite();
			_player.graphics.beginFill(0xff0000);
			_player.graphics.drawCircle(0, 0, 10);
			_player.graphics.endFill();
			_player.x =30
			_player.y =30
			addChild(_player);
		}
		private function onGridClick(event:MouseEvent):void
		{
			var xpos:int = Math.floor(mouseX / _cellSize);
			var ypos:int = Math.floor(mouseY / _cellSize);
			_grid.setEndNode(xpos, ypos);
			
			xpos = Math.floor(_player.x / _cellSize);
			ypos = Math.floor(_player.y / _cellSize);
			_grid.setStartNode(xpos, ypos);
			
			//drawGrid();
			//graphics.clear();
			shape.graphics.clear();
			findPath();
		}
		
		private function findPath():void 
		{
			var astar:Astar = new Astar(_grid);
			astar.main = this;
			astar.findPath()
		}
		public function drawGrid1(x,y):void
		{
			//trace(x, y);
			graphics.lineStyle(0);
					graphics.beginFill(0xcccccc);
			graphics.drawRect(x* _cellSize, y * _cellSize, _cellSize, _cellSize);
		}
		public function drawGrid2(x,y):void
		{
			
			//trace(x, y);
			shape.graphics.lineStyle(0);
			shape.graphics.beginFill(0xff0000);
			shape.graphics.drawRect(x * _cellSize, y * _cellSize, _cellSize, _cellSize);
			addChild(shape);
			
		}
		
		
	}

}