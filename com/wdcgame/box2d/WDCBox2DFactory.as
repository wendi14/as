package com.wdcgame.box2d 
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	/**
	 * ...
	 * @author wdc
	 */
	public class WDCBox2DFactory 
	{
		static public const WORLD_SCALE:uint = 30;
		
		public function WDCBox2DFactory() 
		{
			
		}
		public static function createWorld(gravity:b2Vec2=null):b2World
		{
			if (!gravity) 
			{
				gravity = new b2Vec2(0, 9.8);
			}
			var world:b2World = new b2World(gravity,true);
			return world;
		}
		
		public static function createBox(world:b2World,x:Number,y:Number,width:Number,height:Number,isStatic:Boolean):b2Body
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.type = isStatic?b2Body.b2_staticBody:b2Body.b2_dynamicBody;
			bodyDef.position.Set(x / WORLD_SCALE, y / WORLD_SCALE);
			bodyDef.linearDamping = 0;
			bodyDef.userData = "aa";
			
			var shape:b2PolygonShape = new b2PolygonShape();
			shape.SetAsBox(width / 2 / WORLD_SCALE, height / 2 / WORLD_SCALE);
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = shape;
			fixtureDef.density = 2;
			fixtureDef.restitution = 0.4;
			fixtureDef.friction = 0.5;
			 
			
			var b:b2Body = world.CreateBody(bodyDef);
			b.CreateFixture(fixtureDef);
			
			return b;
		}
		
		static public function createCircle(world:b2World, x:Number, y:Number, radius:Number, isStatic:Boolean):b2Body 
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.type = isStatic?b2Body.b2_staticBody:b2Body.b2_dynamicBody;
			bodyDef.position.Set(x / WORLD_SCALE, y / WORLD_SCALE);
			bodyDef.userData = "cc";
			
			var shape:b2CircleShape = new b2CircleShape(radius / WORLD_SCALE);
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = shape;
			
			var b:b2Body = world.CreateBody(bodyDef);
			b.CreateFixture(fixtureDef);
			return b;
		}
		
	}

}