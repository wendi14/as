package com.xmaser.map45.utils 
{
	import com.xmaser.map45.display.DrawnTile;
	import com.xmaser.map45.display.ISOSprite;
	import com.xmaser.map45.display.MapWorld;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class MapItemDrager 
	{
		private var _world:MapWorld;
		private var _oldFloor:DrawnTile;
		
		public function MapItemDrager(world:MapWorld) 
		{
			this._world = world;
			
		}
		public function dragItem(item:ISOSprite):void
		{
			this._world.addChild(item);
			item.startDrag(true);
			this._world.addEventListener(MouseEvent.MOUSE_MOVE, __mouseMove);
		}
		
		private function __mouseMove(e:MouseEvent):void 
		{
			if (_oldFloor) 
			{
				_oldFloor.filters = [];
				_oldFloor = null;
			}
			var po:Point3D = ISOUtils.screen2iso(new Point(this._world.mouseX, this._world.mouseY));
			po.x = Math.round(po.x/this._world.size)*this._world.size;
			po.y = Math.round(po.y/this._world.size)*this._world.size;
			po.z = Math.round(po.z / this._world.size) * this._world.size;
			
			var floor:DrawnTile = this._world.getFloorByPositioin(po);
			if (floor && floor.hasItem == false)
			{
				_oldFloor = floor;
				floor.filters=[new BlurFilter()]
			}
		}
		
	}

}