package com.xmaser.f3d.a3d 
{
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.Resource;
	import alternativa.engine3d.core.View;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.primitives.Box;
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class Alternativa3DBasic extends Sprite 
	{
		private var _camera:Camera3D;
		protected var _scene:Object3D=new Object3D();
		protected var _stage3D:Stage3D;
		private var box:Box;
		public function Alternativa3DBasic(width:Number,height:Number) 
		{
			_camera = new Camera3D(0.1, 10000);
			_camera.view = new View(width, height, true);
			_camera.rotationX = -120*Math.PI/180;
			_camera.y=-1000
			_camera.z = 500
			
			addChild(_camera.view);
			
			_scene.addChild(_camera);
			
			if (stage) 
			{
				init()
			}else 
			{
				addEventListener(Event.ADDED_TO_STAGE,init)
			}
		}
		
		private function init():void 
		{
			atInit()
			createState3D()
		}
		
		private function createState3D():void 
		{
			_stage3D = stage.stage3Ds[0];
			_stage3D.addEventListener(Event.CONTEXT3D_CREATE, __CONTEXT3D_CREATE);
			_stage3D.requestContext3D();
		}
		
		private function __CONTEXT3D_CREATE(e:Event):void 
		{
			for each (var item:Resource in _scene.getResources(true)) 
			{
				item.upload(_stage3D.context3D);
			}
			
			startEnterFrame();
		}
		
		private function startEnterFrame():void 
		{
			stage.addEventListener(Event.ENTER_FRAME, __ENTER_FRAME);
		}
		
		private function __ENTER_FRAME(e:Event):void 
		{
			atRender()
			_camera.render(_stage3D);
		}
		
		/**
		 * 子类覆写
		 */
		protected function atRender():void 
		{
			box.rotationZ -= 0.1;
		}
		/**
		 * 子类覆写
		 */
		protected function atInit():void 
		{
			box = new Box();
			var ma:FillMaterial = new FillMaterial(0xFF7700);
			box.setMaterialToAllSurfaces(ma);
			_scene.addChild(box);
			box.rotationZ=45
			
		}
		public function uploadResource(obj3d:Object3D):void
		{
			for each (var item:Resource in obj3d.getResources(true)) 
			{
				item.upload(_stage3D.context3D);
			}
		}
		public function get camera():Camera3D 
		{
			return _camera;
		}
		
		public function get stage3D():Stage3D 
		{
			return _stage3D;
		}
		
	}

}