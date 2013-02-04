package com.xmaser 
{
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.Resource;
	import alternativa.engine3d.core.View;
	import alternativa.engine3d.loaders.TexturesLoader;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.primitives.Box;
	import alternativa.engine3d.resources.ExternalTextureResource;
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class Alternativa3DBasic extends Sprite 
	{
		private var _camera:Camera3D;
		private var _scene:Object3D=new Object3D();
		protected var _stage3D:Stage3D;
		private var box:Box;
		
		public function Alternativa3DBasic(width:Number=800,height:Number=600) 
		{
			_camera = new Camera3D(0.1, 10000);
			_camera.view = new View(width, height);
			addChild(_camera.view);
			_camera.rotationX = -120*Math.PI/180;
			_camera.y=-1000
			_camera.z=500
			
			_scene.addChild(_camera);
			
			
			if (stage) 
			{
				init()
			}else 
			{
				addEventListener(Event.ADDED_TO_STAGE,init)
			}
			
		}
		
		private function init(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			
			atInit()
			createState3D()
			
		}
		protected function createState3D():void
		{
			_stage3D = stage.stage3Ds[0];
			_stage3D.addEventListener(Event.CONTEXT3D_CREATE, __CONTEXT3D_CREATE);
			_stage3D.requestContext3D();
		}
		
		protected function atInit():void 
		{
			box = new Box(100, 100, 100, 5, 5, 5);
			var ma:FillMaterial = new FillMaterial(0xFF7700);
			box.setMaterialToAllSurfaces(ma);
			scene.addChild(box)
		}
		
		private function __CONTEXT3D_CREATE(e:Event):void 
		{
			var textures:Vector.<ExternalTextureResource> = new Vector.<ExternalTextureResource>;
			for each (var item:Resource in _scene.getResources(true)) 
			{
				if (item is ExternalTextureResource)
				{
					textures.push(item)
				}else 
				{
					item.upload(_stage3D.context3D);
				}
				
			}
			var textureLoader:TexturesLoader = new TexturesLoader(_stage3D.context3D);
			textureLoader.loadResources(textures);
			adPreRender()
			
			addEventListener(Event.ENTER_FRAME,__ENTER_FRAME)
		}
		
		protected function adPreRender():void 
		{
			
		}
		
		private function __ENTER_FRAME(e:Event):void 
		{
			atRender();
			_camera.render(_stage3D);
		}
		
		protected function atRender():void 
		{
			box.rotationX+=0.1
		}
		
		public function get scene():Object3D 
		{
			return _scene;
		}
		
		public function get camera():Camera3D 
		{
			return _camera;
		}
		
	}

}