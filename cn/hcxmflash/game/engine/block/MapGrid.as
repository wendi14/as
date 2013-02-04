package  cn.hcxmflash.game.engine.block
{
	import cn.hcxmflash.game.comm.component.Grid;
	import flash.events.MouseEvent;
	
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class MapGrid extends Sprite 
	{
		private var _holdGrid:Sprite;
		protected var _gridArr:Array;
		private var GridClass:Class;
	
		public function get gridArr():Array 
		{
			return _gridArr;
		}
		
		public function set gridArr(value:Array):void 
		{
			_gridArr = value;
		}
		protected var _oldGridArr:Array;
		public function MapGrid(_gridClass:Class) 
		{
			GridClass = _gridClass;
			
		}
		public function init(ar:Array):void
		{
			clearOld()
			_gridArr = []; _oldGridArr = [];
			_holdGrid = new Sprite()
			addChild(_holdGrid);
		
			for (var i:int = 0; i <ar.length; i++) 
			{
				_gridArr[i] = [];
				for (var j:int = 0; j <ar[i].length; j++) 
				{
					var grid:* = new GridClass();
					
					grid.name = "g_" + i + "_" + j;
					_holdGrid.addChild(grid);
					grid.x = j * grid.width;
					grid.y = i * grid.height;
					grid.xx = j; grid.yy = i;
					grid.type = ar[i][j];
					_gridArr[i].push(grid);
					_holdGrid.addChild(grid);
					
					grid.addEventListener(MouseEvent.MOUSE_OVER, __gridMOUSE_OVER);
					grid.addEventListener(MouseEvent.MOUSE_OUT, __gridMOUSE_OUT);
					grid.addEventListener(MouseEvent.CLICK, __gridCLICK);
					
					_oldGridArr.push(grid);
					
					
				}
				
			}
			
			rePosition()		
		}
		
		private function clearOld():void 
		{
			if (_oldGridArr)
			{
				for (var i:int = 0; i <_oldGridArr .length; i++) 
				{
					var grid: Grid= _oldGridArr[i];
					grid.removeEventListener(MouseEvent.MOUSE_OVER, __gridMOUSE_OVER);
					grid.removeEventListener(MouseEvent.MOUSE_OUT, __gridMOUSE_OUT);
					grid.removeEventListener(MouseEvent.CLICK, __gridCLICK);
					_holdGrid.removeChild(grid);
				}
			}
			while (this.numChildren)
			{
				this.removeChildAt(0);
			}
		}
		
		protected function __gridMOUSE_OVER(e:MouseEvent):void 
		{
			
		}
		
		protected function __gridMOUSE_OUT(e:MouseEvent):void 
		{
			
		}
		
		protected function __gridCLICK(e:MouseEvent):void 
		{
			
		}
		public function initFromWW_HH(ww:int,hh:int):void
		{
			_gridArr = [];
			_holdGrid = new Sprite()
			addChild(_holdGrid);
			for (var i:int = 0; i <hh; i++) 
			{
				_gridArr[i] = [];
				for (var j:int = 0; j <ww; j++) 
				{
					var grid:* =new GridClass()
					
					grid.name = "g_" + i + "_" + j;
					_holdGrid.addChild(grid);
					grid.x = j * grid.width;
					grid.y = i * grid.height;
					grid.xx = j; grid.yy = i;

					_gridArr[i].push(grid);
					_holdGrid.addChild(grid);
				}
				
			}
			
			rePosition()
		}
		
		protected function rePosition():void 
		{
			
		}
		
		
	}

}