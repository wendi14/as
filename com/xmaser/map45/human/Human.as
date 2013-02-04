package com.xmaser.map45.human 
{
	import com.xmaser.a_start.Node;
	import com.xmaser.bitmap.AnimationBitmap;
	import com.xmaser.map45.display.DrawnTile;
	import com.xmaser.map45.display.ISOSprite;
	import com.xmaser.map45.display.MapWorld;
	import com.xmaser.map45.resource.ModManager;
	import com.xmaser.map45.utils.HumanActionBuilder;
	import com.xmaser.map45.utils.Point3D;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author 
	 */
	public class Human extends  ISOSprite 
	{
		private var _animationArr:Object;
		private var _pathA:Array;
		private var _nowNode:Node;
		private var _speed:Number=2;
		private var _speedX:Number;
		private var _speedY:Number;
		private var _nowAnimation:AnimationBitmap;
		private var _face:int;
		private var _animationHolder:Sprite;
		private var _action:String;
		private var _actionManager:HumanActionManager;
		/*public static const FACE_TOP:int = "top";
		public static const FACE_TOP_RIGHT:String = "FACE_TOP_RIGHT";
		public static const FACE_RIGHT:String = "FACE_RIGHT";
		public static const FACE_RIGHT_BOTTOM:String = "FACE_RIGHT_BOTTOM";
		public static const FACE_BOTTM:String = "FACE_BOTTM";
		public static const FACE_BOTTOM_LEFT:String = "FACE_BOTTOM_LEFT";
		public static const FACE_LEFT:String = "FACE_LEFT";
		public static const FACE_LEFT_TOP:String = "FACE_LEFT_TOP";*/
		public static const FACE_FRONT:int = 0;
		public static const FACE_FRONT_LEFT:int = 1;
		public static const FACE_LEFT:int = 2;
		public static const FACE_BOTTOM_LEFT:int = 3;
		public static const FACE_BOTTOM:int = 4;
		public static const FACE_BOTTOM_RIGHT:int = 5;
		public static const FACE_RIGHT:int = 6;
		public static const FACE_FORNT_RIGHT:int = 7;
		
		public var mapWorld:MapWorld;
		
		private var _defaultFace:int = 1;
		private var _seekTarget:ISOSprite;
		private var _characterStats:CharacterStats=new CharacterStats();
		public function Human(size:Number) 
		{
			super(size);
			addEventListener(Event.ENTER_FRAME, __ENTER_FRAME);
			//debugRect()
			//showBackGround();
		}
		public function setAnmation(ar:Object):void
		{
			_animationHolder = new Sprite();
			addChild(_animationHolder);
			/**
			 * 
			 *  {0:action,1:action}
			 * 
			 * 
			 */
			_animationArr = ar;
			
			_action = 'walk';
			setFace(_defaultFace);
			
		}
		/**
		 * 加载人物模型数据
		 * @param	arg1
		 */
		public function loadMod(modUrl:String):void 
		{
		/*	var m:HumanActionBuilder = ModManager.getIns()._modS[modUrl];
			setAnmation(m.action);
			return;*/
			var _builder:HumanActionBuilder = new HumanActionBuilder();
			_builder.buildMod(modUrl);
			_builder.addEventListener(Event.COMPLETE, __buildcomplete);
		}
		/**
		 * 加载人物模型URL
		 * @param	arg1
		 */
		public function setActionManager(am:HumanActionManager):void 
		{
			_actionManager = am;
			setAnmation(_actionManager.faces);
			
			
		}
		public function seekTarget(target:ISOSprite):void
		{
			var n:Point = new Point();
			n.x = target.XY.x;
			n.y = target.XY.y;
			n.x+=1
			mapWorld.seekPath(this.XY, n);
			_seekTarget = target;
		}
		
		private function __buildcomplete(e:Event):void 
		{
			var ac:Action = e.target.action;
			setAnmation(ac);
		}
		private function setFace(face:int):void 
		{
			if (_nowAnimation) 
			{
				while (_animationHolder.numChildren>0) 
				{
					_animationHolder.removeChildAt(0);
				}
				
			}
			if (!_animationArr) return;
			var an:AnimationBitmap = _animationArr[face][_action];
			if (an.isPlaying)
			{
				
			}else 
			{
				an.play()
			}
			
			_nowAnimation = an;
			 _animationHolder.addChild(an);

			_face = face;
			
			
			
			if (an.loaded)
			{
				//an.x = -28 / 2;
				//an.y = size-an.height;
				
				an.x =  -_actionManager.rect.width / 2;// -_actionManager.rect.width / 2;
				an.y = -_actionManager.rect.height;// +size / 2 ;// -_actionManager.rect.height / 2 - 20;
			}else 
			{
				an.addEventListener(AnimationBitmap.LOADED,__anLoaded)
			}
			
		}
		private function setAction(action:String):void 
		{
			if (_nowAnimation) 
			{
				while (_animationHolder.numChildren>0) 
				{
					_animationHolder.removeChildAt(0);
				}
				
			}
			if (!_animationArr) return;
			var an:AnimationBitmap = _animationArr[_face][action];
			if (an.isPlaying)
			{
				
			}else 
			{
				an.play()
			}
			
			_nowAnimation = an;
			 _animationHolder.addChild(an);

			_action = action;
			
			
			
			if (an.loaded)
			{
				//an.x = -28 / 2;
				//an.y = size-an.height;
				
				an.x =  -_actionManager.rect.width / 2;// -_actionManager.rect.width / 2;
				an.y = -_actionManager.rect.height;// +size / 2 ;// -_actionManager.rect.height / 2 - 20;
			}else 
			{
				an.addEventListener(AnimationBitmap.LOADED,__anLoaded)
			}
			
		}
		
		private function __anLoaded(e:Event):void 
		{
			_nowAnimation.removeEventListener(AnimationBitmap.LOADED,__anLoaded)
			_animationHolder.x = -28 / 2;
			_animationHolder.y =-51
		}
		
		
			
		public function goPath(pathA:Array):void 
		{
			_action = "walk";
			_pathA = pathA;
			_nowNode = _pathA.shift();
			
			startEnterFrame()
			//var node:Node = _pathA.shift();
			
			//go(node);
		}
		
		private function go(node:Node):void 
		{
			var po:Point3D = new Point3D();
			
			//var po:Point3D = ISOUtils.screen2iso(new Point(mapw.mouseX, mapw.mouseY));
			po.x = Math.round(node.x)*size;
			//po.y = Math.round(no.y)*size;
			po.z = Math.round(node.y ) * size;
			
			
		}
		
		private function __ENTER_FRAME(e:Event):void 
		{
			if (_pathA&&_nowNode)
			{
				
				var dis:Point3D = new Point3D()
				var _nexPos:Point3D = new Point3D()
				_nexPos.x=Math.round(_nowNode.x)*size;
				_nexPos.z = Math.round(_nowNode.y) * size;
				
				
				var xx:Number =  _nexPos.x-this.position.x ;
				var yy:Number =  _nexPos.z - this.position.z;
				
				var disLen:Number = Math.sqrt(xx * xx + yy * yy);
				if (disLen < _speed) 
				{
					var _oldNode:Node = _nowNode;
					_nowNode = _pathA.shift();
					if (_nowNode)
					{
						calFace(_nowNode.x - _oldNode.x, _nowNode.y - _oldNode.y);
					}
					return;
				}
				
				
				var perX:Number = xx / disLen;
				var perY:Number = yy / disLen;
			
				_speedX = perX * _speed;
				_speedY = perY * _speed;
				//trace(_speedX, _speedY);
				this.position.x +=_speedX
				this.position.z += _speedY
				
				this.position = this.position;
				mapWorld.sort();
				
			}else
			{
				if (_seekTarget)
				{
					//trace( "_seekTarget : " + _seekTarget );
					//到达目的地
					checkInAttackRange(_seekTarget);
					
				}
			}

		}
		/**
		 * 检查是否在攻击范围内
		 */
		private function checkInAttackRange(target:ISOSprite):void 
		{
			_characterStats;
			
			var dis:Point3D = target.position;
			
			
			
			var xx:Number =  dis.x-this.position.x ;
			var yy:Number =  dis.z - this.position.z;
				
				var disLen:int = Math.sqrt(xx * xx + yy * yy);
				//trace( "disLen : " + disLen );
				if (disLen <=_characterStats.attack_range )
				{
					trace('在攻击范围内')
					stopEnterFrame();
					attack(target);
				}
				
		}
		
		private function attack(target:ISOSprite):void 
		{
			setAction(ActionConst.ATTACK);
		}
		private function stopEnterFrame():void
		{
			this.removeEventListener(Event.ENTER_FRAME, __ENTER_FRAME);
		}
		private function startEnterFrame():void
		{
			this.addEventListener(Event.ENTER_FRAME, __ENTER_FRAME);
		}
		
		private function calFace(xx:Number, yy:Number):void 
		{
			trace(xx, yy);
			if (xx==1&&yy==1) 
			{
				setFace(FaceConts.FRONT);
			}else if (xx==0&&yy==1) 
			{
				setFace(FaceConts.FRONT_LEFT);
			}
			else if (xx==-1&&yy==1) 
			{
				setFace(FaceConts.LEFT);
			}
			else if (xx==-1&&yy==0) 
			{
				setFace(FaceConts.LEFT_TOP)
			}
			else if (xx==-1&&yy==-1) 
			{
				setFace(FaceConts.TOP)
			}
			else if (xx==0&&yy==-1) 
			{
				setFace(FaceConts.TOP_RIGHT)
			}
			else if (xx==1&&yy==-1) 
			{
				setFace(FaceConts.RIGHT)
			}
			else if (xx==1&&yy==0) 
			{
				setFace(FaceConts.RIGTH_FRONT)
			}
			
			return
			if (xx==-1&&yy==-1) 
			{
				setFace(FACE_BOTTOM);
			}else if (xx==0&&yy==-1) 
			{
				setFace(FACE_BOTTOM_RIGHT);
			}
			else if (xx==1&&yy==-1) 
			{
				setFace(FACE_BOTTOM_RIGHT);
			}
			
			else if (xx==1&&yy==0) 
			{
				setFace(FACE_FORNT_RIGHT);
			}
			else if (xx==1&&yy==1) 
			{
				setFace(FACE_FRONT);
			}
			
			else if (xx==0&&yy==1) 
			{
				setFace(FACE_FRONT_LEFT)
			}else if (xx==-1&&yy==1) 
			{
				setFace(FACE_LEFT)
			}
			else if (xx==-1&&yy==0) 
			{
				setFace(FACE_BOTTOM_LEFT)
			}
			trace("face", _face);
		}
		
		private function getSpeed(xx:Number, disLen:Number):Number 
		{
			var k:Number = xx / disLen;
			var sp:Number = k * _speed;
			return sp;
		}
		public function getRunOffset(dis:Number):Number 
		{ 
			var d:int =_speed
			if (d < 0) d = -_speed
			if(dis==0)d=0
			return d
			
			}
			
			public function get defaultFace():int 
			{
				return _defaultFace;
			}
			
			public function set defaultFace(value:int):void 
			{
				_defaultFace = value;
			}
			
	}

}