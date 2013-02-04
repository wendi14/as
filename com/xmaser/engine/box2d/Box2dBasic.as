package com.xmaser.engine.box2d 
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class Box2dBasic extends Sprite 
	{
		static public const PHY_SCALE:Number = 30;
		public var m_velocityIterations:int = 10;
		public var m_positionIterations:int = 10;
		public var m_timeStep:Number = 1.0/30.0;
		private var _world:b2World
		public function Box2dBasic(gravity:b2Vec2,doSleep:Boolean=true) 
		{
			_world = new b2World(gravity, doSleep);
			
			
			
		}
		
		public function startRender():void 
		{
			addEventListener(Event.ENTER_FRAME, __ENTER_FRAME);
		}
		protected function __ENTER_FRAME(e:Event):void 
		{
			_world.Step(m_timeStep, m_velocityIterations, m_positionIterations);
			
			for (var bb:b2Body = _world.GetBodyList(); bb;bb=bb.GetNext() ) 
			{
				if (bb.GetUserData() is Sprite){
					var sprite:Sprite = bb.GetUserData() as Sprite;
					sprite.x = bb.GetPosition().x * 30;
					sprite.y = bb.GetPosition().y * 30;
					sprite.rotation = bb.GetAngle() * (180 / Math.PI);
					//trace( "bb.GetPosition().x : " + bb.GetPosition().x );
				}
				
			}
			_world.DrawDebugData();
		}

		/**
		 * 建立方形
		 * @param	uiClass	flash图形
		 * @param	width
		 * @param	height
		 * @param	pos
		 * @param	bodyType	0不动的，2动的
		 * @param	density	质量
		 * @param	friction	密集, 稠密2〈物〉〈化〉密度（固体、液体或气体单位体积的质量）
		 * @return
		 */
		public function createBox(uiClass:Class,width:Number,height:Number,pos:b2Vec2,bodyType:uint=2,density:Number=1,friction:Number=0.3,groupIndex:int=0):b2Body
		{
			var boxShape:b2PolygonShape = new b2PolygonShape();
			boxShape.SetAsBox(width / 2/PHY_SCALE, height / 2/PHY_SCALE);
			
			var fixDef:b2FixtureDef = new b2FixtureDef();
			fixDef.density = density;
			fixDef.friction = friction;
			fixDef.shape = boxShape;
			fixDef.filter.groupIndex = groupIndex;
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.fixedRotation = true;
			if (uiClass) 
			{
				bodyDef.userData = new uiClass();
				bodyDef.userData.width = width;
				bodyDef.userData.height = height;
			}
			pos.Multiply(0.03);
			bodyDef.position.SetV(pos);
			bodyDef.type = bodyType;
			
			var body:b2Body = _world.CreateBody(bodyDef);
			body.CreateFixture(fixDef);
			
			return body;
		}
		public function createCircle(uiClass:Class,radius:Number,pos:b2Vec2,bodyType:uint=2,density:Number=1,friction:Number=0.3,groupIndex:int=0):b2Body
		{
			var boxShape:b2CircleShape = new b2CircleShape();
			boxShape.SetRadius(radius / PHY_SCALE);
			
			
			var fixDef:b2FixtureDef = new b2FixtureDef();
			fixDef.density = density;
			fixDef.friction = friction;
			fixDef.shape = boxShape;
			fixDef.filter.groupIndex = groupIndex;
			
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			
			bodyDef.fixedRotation = true;
			if (uiClass) 
			{
				bodyDef.userData = new uiClass();
				bodyDef.userData.width = width;
				bodyDef.userData.height = height;
			}
			pos.Multiply(0.03);
			bodyDef.position.SetV(pos);
			bodyDef.type = bodyType;
			
			var body:b2Body = _world.CreateBody(bodyDef);
			body.CreateFixture(fixDef);
			
			return body;
		}
		public function debug():void
		{
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			debugDraw.SetSprite(this);
			debugDraw.SetDrawScale(30.0);
			debugDraw.SetFillAlpha(0.3);
			debugDraw.SetLineThickness(1.0);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
			_world.SetDebugDraw(debugDraw);
			_world.DrawDebugData();
		}
		
		public function get world():b2World 
		{
			return _world;
		}
		
	}

}