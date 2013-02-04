package com.xmaser.mybox2d 
{
	import Box2D.Collision.b2AABB;
	import Box2D.Collision.Shapes.b2CircleDef;
	import Box2D.Collision.Shapes.b2PolygonDef;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class Box2dBasic extends Sprite 
	{
		static public const PHY_SCALE:Number = 30;
		protected var _world:b2World
		protected var _aabb:b2AABB;
		protected var _gravity:b2Vec2;
		protected var _doSleep:Boolean;
		protected var _debug:Boolean;
		protected var _debugDrawSprite:Sprite=new Sprite();
		protected var _ground:b2Body
		public function Box2dBasic(aabb:b2AABB = null, gravity:b2Vec2 = null, doSleep:Boolean = true, debug_:Boolean = true ) 
		{
			
			if (aabb)
			{
				_aabb = aabb;
			}else 
			{
				_aabb = new b2AABB()
				_aabb.lowerBound.Set( -100, -100);
				_aabb.upperBound.Set(100, 100);
			}
			if (gravity) 
			{
				_gravity = gravity;
			}else 
			{
				_gravity = new  b2Vec2(0, 10);
			}
			_doSleep = doSleep;
			
			
			
			
			_world = new b2World(_aabb, _gravity, _doSleep);
			
			addChild(_debugDrawSprite);
			debug = debug_
			
			_ground = _world.GetGroundBody();
			
			addEventListener(Event.ENTER_FRAME, onRender);
		}
		public function clearRender():void
		{
			removeEventListener(Event.ENTER_FRAME, onRender);
		}
		protected function onRender(e:Event):void 
		{
			_world.Step(1 / PHY_SCALE*2, 10);
		}
		public function set debug(value:Boolean):void 
		{
			_debug = value;
			if (_debug) 
			{
				setDebug()
			}
		}
		
		private function setDebug():void 
		{
			var debugDraw:b2DebugDraw = new b2DebugDraw()
			debugDraw.m_sprite = _debugDrawSprite;
			debugDraw.m_drawFlags = b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit;
			debugDraw.m_drawScale = PHY_SCALE;
			debugDraw.m_fillAlpha = 0.3;
			debugDraw.m_lineThickness =1;
			_world.SetDebugDraw(debugDraw);
		}
		/**
		 * 创建一个盒子
		 * @param	w	宽
		 * @param	h	高
		 * @param	x	坐标x
		 * @param	y
		 * @param density	密度
		 */
		public function createBox(w:Number,h:Number,x:Number,y:Number, friction:Number=0.3,density:Number=0,restitution:Number=0.2):b2Body
		{
			var body:b2Body
			var bodyDef:b2BodyDef = new b2BodyDef()
			bodyDef.position.Set(x/PHY_SCALE, y/PHY_SCALE);
			bodyDef.fixedRotation = true;
			
			var boxDef:b2PolygonDef = new b2PolygonDef()
			boxDef.friction =friction
			boxDef.SetAsBox(w/(PHY_SCALE*2), h/(PHY_SCALE*2));
			boxDef.density = density;
			boxDef.restitution=restitution
			bodyDef.allowSleep = true;
			body = _world.CreateBody(bodyDef);
			body.CreateShape(boxDef)
			body.SetMassFromShapes();
			
			return body;
		}
		/**
		 * 
		 * @param	radius
		 * @param	x
		 * @param	y
		 * @param friction 摩擦力
		 * @param	density 密集, 稠密2〈物〉〈化〉密度（固体、液体或气体单位体积的质量）
		 * @return
		 */
		public function createCircle(radius:Number, x:Number, y:Number, friction:Number=0.3,density:Number = 0,restitution:Number=0.2):b2Body
		{
			var body:b2Body
			var bodyDef:b2BodyDef = new b2BodyDef()
			bodyDef.position.Set(x/PHY_SCALE, y/PHY_SCALE);
			
			
			var boxDef:b2CircleDef = new b2CircleDef()
			boxDef.friction =friction
			boxDef.radius = radius/(PHY_SCALE*2);
			boxDef.density = density;
			boxDef.restitution = restitution;
			bodyDef.fixedRotation = true;
		
			
			body = _world.CreateBody(bodyDef);
			body.CreateShape(boxDef)
			body.SetMassFromShapes();
			
			return body;
		}
		/**
		 * 建立墙壁和地板
		 * @param	stageW	场景的宽度
		 * @param	stageH	场景的高度
		 */
		public function createWall(stageW:int=800,stageH:int=600,friction:Number=1,density:Number = 0,restitution:Number=0.2):void
		{
			//left
			createBox(10, stageH, 5, stageH / 2,friction,density,restitution);
			//right
			createBox(10, stageH, stageW - 5, stageH / 2,friction,density,restitution);
			//bottom
			createBox(stageW, 10, stageW / 2, stageH - 5,friction,density,restitution);
			
		}
		public function createTopWall(stageW:int=800,stageH:int=600):void
		{
			createBox(stageW, 10,stageW/2, 5);
		}
		
	}

}