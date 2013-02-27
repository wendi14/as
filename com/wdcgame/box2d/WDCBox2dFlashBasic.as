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
			
			debugDraw();
			startRender()
		}
		
		protected function startRender():void 
		{
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected function onRender():void 
		{
			
		}
		
		protected function createBox(x:Number,y:Number,width:Number,height:Number,isStatic:Boolean):b2Body
		{
			return WDCBox2DFactory.createBox(_world, x, y, width, height, isStatic);
		}
		
		private function onEnterFrame(e:Event):void 
		{
			onRender();
			_world.Step(1 / WDCBox2DFactory.WORLD_SCALE, 10, 10);
			_world.DrawDebugData();
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