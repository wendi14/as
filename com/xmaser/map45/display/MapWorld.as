package com.xmaser.map45.display 
{
	import com.greensock.TweenLite;
	import com.xmaser.a_start.Astar;
	import com.xmaser.a_start.Grid;
	import com.xmaser.a_start.Node;
	import com.xmaser.bitmap.AnimationBitmap;
	import com.xmaser.map45.human.Human;
	import com.xmaser.map45.human.Player;
	import com.xmaser.map45.model.ItemVO;
	import com.xmaser.map45.utils.ISOUtils;
	import com.xmaser.map45.utils.Point3D;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author 
	 */
	public class MapWorld extends Sprite 
	{
		public var world_width:Number;
		public var world_height:Number;
		private var _world:Sprite;
		private var _terrain :Sprite
		private var _floor:Sprite;
		private var _objList:Array=[];
		private var _floorList:Array=[];
		private var _size:Number;
		private var _grid:Grid;
		private var _player:Player;
		private var pathA:Array;
		
		//[Embed(source = "../../../../../../../个人作品/2.5D_45度地图/bin/xinpingyuand",mimeType="application/")]
		private var fcla:Class
		private var astar:Astar;
		private var _testSeekTarget:LoaderTile;
		public function MapWorld() 
		{
			_world = new Sprite();
			_terrain =new Sprite()
			_floor = new Sprite();
			addChild(_floor);
			addChild(_terrain);
			addChild(_world);
			
			
			
			addEventListener(MouseEvent.CLICK, __click);
			
		}
		
	
		public function createFloor():void
		{
			//size = 64;
			for (var i:int = 0; i < world_width; i++) 
			{
				
				for (var j:int = 0; j < world_height; j++) 
				{
					var item:DrawnTile = new DrawnTile(size, 0x009966);
					item.position = new Point3D(i * size, 0, j * size);
					item.debug(i,j)
					
					_floor.addChild(item);
					_floorList[item.position] = item;
					//item.debugXY()
					//item.debugRect();
				}
			}
			_grid = new Grid(world_width, world_height);
			astar = new Astar(_grid);
			astar.main = this;
		}
		public function addChildToWorld(child:ISOSprite,layer:Sprite=null,layerName:String="world"):void
		{
			if (!layer) 
			{
				layer = _world;
			}
			
			if (layerName!="world")
			{
				layer.addChild(child);
			}else 
			{
				//child.alpha=0.2
				_world.addChild(child);
				//trace( "child : " + child );
				_objList.push(child);
				var n:Node = _grid.getNode(child.XY.x, child.XY.y);
				
				//trace( "child.XY.x : " ,child.XY.x,child.XY.y );
				//if (!n) return;
				n.walkable = false;
				
				for (var i:int = 0; i < child.overlapX; i++) 
				{
					_grid.getNode(child.XY.x, child.XY.y-i).walkable = false;
					
				}
				for (var j:int = 0; j < child.overlapY; j++) 
				{
					_grid.getNode(child.XY.x+j, child.XY.y).walkable = false;
					
				}
				//trace(child.XY);
				sort()
			}
			
		}
		
		public function sort():void 
		{
			_objList.sortOn("depth", Array.NUMERIC);
			for (var i:int = 0; i < _objList.length; i++) 
			{
				_objList[i].parent.setChildIndex(_objList[i], i);
				
			}
		}
		
		
		public function getFloorByPositioin(po:Point3D):DrawnTile 
		{
			return _floorList[po];
		}
		
		public function buildScene(maparr:Array,layerName:String='world'):void 
		{
			var sp:Sprite = this[layerName];
			
			for each (var item:ItemVO in maparr) 
			{
				//trace("item: " + item.x,item.y);
				
				var loaderTile:LoaderTile = new LoaderTile(size, item);
				var po:Point3D =new Point3D()
				po.x = item.x*size
				po.y =0
				po.z = item.y*size;
				loaderTile.position = po;
				addChildToWorld(loaderTile,sp,layerName);
				DrawnTile(_floorList[po]).hasItem = true;
				
				if (item.type == 3)
				{
					_testSeekTarget = loaderTile;
				}
				
				
				/*var item2:DrawnTile = new DrawnTile(size, 0xff3966);
					item2.position = new Point3D(item.x * size, 0, item.y * size)
					
					
				addChildToWorld(item2);*/	
			}
		}
		public function buildTmx(maparr:Array):void
		{
			for (var i:int = 0; i < maparr.length; i++) 
			{
				for (var j:int = 0; j < maparr[i].length; j++) 
				{
					var item:int = maparr[i][j];
					if(item>0){}
				}
				
			}
		}
		public function addPlayerTOWorld(p:Player):void 
		{
			
			_player = p;
			addChildToWorld(_player, _world);
			_player.mapWorld = this;
			var astar:Astar = new Astar(_grid);
			astar.main = this;
			return;
			for (var i:int = 0; i < 1; i++) 
			{
				//var p:Player = new Player(size);
				_player = p
				p.mapWorld = this;
				addChildToWorld(_player,_world);
				p.loadMod("101.mod");
				
				var astar:Astar = new Astar(_grid);
			astar.main = this;
			
			
			
			/*_grid.setStartNode(_player.XY.x, _player.XY.y);
			//_grid.setStartNode(3, 2);
			
			var po:Point3D = ISOUtils.screen2iso(new Point(stage.stageWidth*Math.random()/2, stage.stageHeight*Math.random()/2));
			po.x = Math.random()*10//*size;
			po.y = Math.round(po.y/size)//*size;
			po.z =  Math.random()*10 //* size;
			
		
			//po.x = 2;po.z=1
			_grid.setEndNode(po.x, po.z);
			
			astar.findPath()
			
			
				pathA = astar.path;
				trace(pathA);
			if (!pathA) continue;
			_player.goPath(pathA);*/
			
			
			
			
				
			}
			
			//return _player;
		}
		
		public function get size():Number 
		{
			return _size;
		}
		
		public function set size(value:Number):void 
		{
			_size = value;
		}
		
		public function get terrain():Sprite 
		{
			return _terrain;
		}
		
		public function get world():Sprite 
		{
			return _world;
		}
		
		public function get testSeekTarget():LoaderTile 
		{
			return _testSeekTarget;
		}
		public function drawGrid1(x:int,y:int):void
		{
			//return;
			 var position:Point3D=new Point3D(x * size, 0, y * size);
			_floorList[position].alpha = 0.2;
			TweenLite.to(_floorList[position], 2, { alpha:1 } );
		}
		public function drawGrid2(x:int,y:int):void
		{
			return;
			var position:Point3D=new Point3D(x * size, 0, y * size);
			_floorList[position].alpha = 0.2;
			setTimeout(a1111,3000,_floorList[position])
		}
		
		private function a1111(aa:*):void 
		{
			aa.alpha = 1;
		}
		private function __click(e:MouseEvent):void 
		{
			
			var s:Point = new Point()
			s.x = _player.XY.x;
			s.y = _player.XY.y
			
			var end:Point = new Point();
				var po:Point3D = ISOUtils.screen2iso(new Point(mouseX, mouseY));
			po.x = Math.round(po.x/size)//*size;
			po.y = Math.round(po.y/size)//*size;
			po.z = Math.round(po.z / size) //* size;
			end.x = po.x; end.y = po.z;
			
			seekPath(s, end);
			
			
		}
		public function seekPath(startNode:Point,endNode:Point):void
		{
			_grid.setStartNode(startNode.x,startNode.y);
			_grid.setEndNode(endNode.x, endNode.y);
			
			astar.findPath()
			
			
			pathA = astar.path;
			trace(pathA);
			if (!pathA) return;
			_player.goPath(pathA);
		}
		
		private function gogo():void 
		{
			if (pathA.length == 0) 
			{
				
				return;
			}
			var no:Node = pathA.shift();
			var po:Point3D = new Point3D();
			
			//var po:Point3D = ISOUtils.screen2iso(new Point(mapw.mouseX, mapw.mouseY));
			po.x = Math.round(no.x)*size;
			//po.y = Math.round(no.y)*size;
			po.z = Math.round(no.y ) * size;
			
			_player.position=po;
		}
	}

}