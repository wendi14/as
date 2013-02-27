package com.wdcgame.box2d 
{
	import Box2D.Collision.Shapes.b2PolygonShape;
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
		
		public static function createBox(world:b2World,x:Number,y:Number,width:Number,height:Number,isStatic:Boolean):b2Body
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.type = isStatic?b2Body.b2_staticBody:b2Body.b2_dynamicBody;
			bodyDef.position.Set(x / WORLD_SCALE, y / WORLD_SCALE);
			
			
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
		
	}

}