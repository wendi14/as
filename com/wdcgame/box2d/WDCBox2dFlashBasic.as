package com.wdcgame.box2d 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class WDCBox2dFlashBasic extends Sprite 
	{
		protected var _world:b2World;
		
		public function WDCBox2dFlashBasic(gravity:b2Vec2) 
		{
			_world = WDCBox2DFactory.createWorld(gravity);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			init();
		}
		
		protected function init():void 
		{
			
			debugDraw();
			startRender()
		}
		
		protected function startRender():void 
		{
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		
		
		protected function createBox(x:Number,y:Number,width:Number,height:Number,isStatic:Boolean):b2Body
		{
			return WDCBox2DFactory.createBox(_world, x, y, width, height, isStatic);
		}
				
		protected function createCircle(x:Number,y:Number,radius:Number,isStatic:Boolean):b2Body
		{
			return WDCBox2DFactory.createCircle(_world, x, y, radius, isStatic);
		}
		
		private function onEnterFrame(e:Event):void 
		{
			_world.Step(1 / WDCBox2DFactory.WORLD_SCALE, 10, 10);
			onRender();
			_world.ClearForces();
			_world.DrawDebugData();
		}
		
		protected function onRender():void 
		{
			
		}
		
		private function debugDraw():void
		{
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			var debugSprite:Sprite = new Sprite();
			addChild(debugSprite);
			debugDraw.SetSprite(debugSprite);
			debugDraw.SetDrawScale(WDCBox2DFactory.WORLD_SCALE);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit|b2DebugDraw.e_jointBit);
			debugDraw.SetFillAlpha(0.5);
			_world.SetDebugDraw(debugDraw);
		}
		
		
	}

}