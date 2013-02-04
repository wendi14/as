package com.xmaser.display.container 
{
	import com.xmaser.display.component.ComponentBasic;
	import com.xmaser.display.container.render.GridRender;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class GridContainer extends ComponentBasic
	{
		private var _gridWidth:Number=30;
		private var _gridHeight:Number = 30;
		
		private var _gridCol:int = 4;
		private var _gridRow:int = 4;
		
		private var _hGap:Number=2
		private var _wGrap:Number=2
		private var _itemsArr:Array;
		private var _nowAddedIndex:int=0;
		private var _itemRender:*=GridRender;
		public function GridContainer() 
		{
			_itemsArr = []
			super()
		}
		override protected function drawUI():void 
		{
			clearOld();
			_itemsArr = [];
			_nowAddedIndex = 0;
			for (var i:int = 0; i <_gridRow; i++) 
			{
				for (var j:int = 0; j <_gridCol ; j++) 
				{
					var item:* = new _itemRender()
					item.data={width:_gridWidth,height:_gridHeight}
					item.x = (item.width + _wGrap) * j;

					item.y = (item.height + _hGap) * i;
					addChild(item);
					_itemsArr.push(item)
				}
			}
		}
		public function set itemRender(value:*):void 
		{
			_itemRender = value;
			reDraw()
		}
		public function get itemRender():* 
		{
			return _itemRender;
		}
		
		private function clearOld():void 
		{
		
			for (var i:int = 0; i < _itemsArr.length; i++) 
			{
				var item: *= _itemsArr[i];
				removeChild(item);
				
			}
		}
		private function reDraw():void
		{
			drawUI()
		}
		public function addItems(ar:Array):void
		{
			for (var i:int = 0; i < ar.length; i++) 
			{
				var item:* = ar[i];
				if(_itemsArr[i])_itemsArr[i].addChild(item);
			}
		}
		public function addItem(item:*):void
		{
			
			_itemsArr[_nowAddedIndex].addChild(item);
			_nowAddedIndex++;
			
		}
		
		public function get gridWidth():Number 
		{
			return _gridWidth;
		}
		
		public function set gridWidth(value:Number):void 
		{
			_gridWidth = value;
			reDraw()
		}
		
		public function get gridHeight():Number 
		{
			return _gridHeight;
		}
		
		public function set gridHeight(value:Number):void 
		{
			_gridHeight = value;
			reDraw()
		}
		
		public function get gridCol():int 
		{
			return _gridCol;
		}
		
		public function set gridCol(value:int):void 
		{
			_gridCol = value;
			reDraw()
		}
		
		public function get gridRow():int 
		{
			return _gridRow;
		}
		
		public function set gridRow(value:int):void 
		{
			_gridRow = value;
			reDraw()
		}
		
		
	}

}