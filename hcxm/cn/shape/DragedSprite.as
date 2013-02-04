package hcxm.cn.shape
{
	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import gs.TweenMax;
	
	import hcxm.cn.event.Event_;
	import hcxm.cn.mouse.Drag;
	import hcxm.cn.mouse.Mouse_Right_Menu;
	import hcxm.cn.shape.controlClass.RichTextArea;
	import hcxm.cn.shape.controlClass.ScaleControler;
	import hcxm.cn.shape.manager.DrawManager;
	
	import mx.core.UIComponent;

	public class DragedSprite extends UIComponent
	{
		
		public function DragedSprite()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE,_ADDED_TO_STAGE);
			addChild(tu);
			 tu.mouseEnabled=false;
			tu.mouseChildren=false;
			tu.addChild(tu1);
			this.Pen=tu1.graphics;
			var mou:Mouse_Right_Menu=new Mouse_Right_Menu(this);
			mou.addItem("删除",_rightMouseDelThis)
		}
		private function _rightMouseDelThis(e):void
		{
			trace(e);
			this.owner.removeChild(this);
		}
		public var Pen:Graphics;
		public var tu:Sprite=new Sprite();
		public var tu1:Sprite=new Sprite();
		public var Ower:DrawBasic;
		//标记 画完了
		public var textarea:RichTextArea;
		public var isDrawOver:Boolean=false;
		public var isShowImageText:Boolean=false;
		public static const  SELECT_EVENT:String="select_event";
		
		
		private function _ADDED_TO_STAGE(e:Event):void
		{
		 	this.addEventListener(MouseEvent.MOUSE_DOWN,_MOUSE_DOWN);
			this.addEventListener(MouseEvent.MOUSE_UP,_MOUSE_UP);
			this.addEventListener(MouseEvent.MOUSE_MOVE,_MOUSE_MOVE) ;
			this.addEventListener(MouseEvent.MOUSE_OVER,_MOUSE_OVER) ;
			this.addEventListener(MouseEvent.MOUSE_OUT,_MOUSE_OUT) ;
			
			drag=new Drag(this)
			//drag.enabledDrag(false)
		}
		private var _enabledMove:Boolean=false;
		public var  bitmap:Bitmap;
		
		public function set enabledMove(b:Boolean):void
		{
			_enabledMove=b;
		}
		public function get enabledMove():Boolean
		{
			return _enabledMove;
		}
		public var drag:Drag
		
		private var _isScale:Boolean=false;//是否在做缩放等编辑的操作
		public function set isScale(b:Boolean):void
		{
			_isScale=b;
			drag.enabledDrag(!_isScale);
		}
		public function get isScale():Boolean
		{
			return _isScale;
		}
				
		private var isDrag:Boolean=false;
		
		
		protected function _MOUSE_DOWN(e:MouseEvent):void
		{
			
		}
		protected function _MOUSE_MOVE(e:MouseEvent):void
		{
			
		}
		protected function _MOUSE_UP(e:MouseEvent):void
		{
			
		}
		protected function _MOUSE_OVER(e:MouseEvent):void
		{
			var ta=e.target
			if(isSelect&&!ta.hasOwnProperty("isController"))
			{
				DrawManager.MoveSelectCursor();
			}
		}
		protected function _MOUSE_OUT(e:MouseEvent):void
		{
			if(isSelect)
			{
				DrawManager.NoCursor();
			}
		}
		private var _isSelect:Boolean=false;
		public function set isSelect(bo:Boolean)
		{
			_isSelect=bo;
			enabledMove=bo;
			if(_isSelect)
			{
				DrawManager.MoveSelectCursor();
				
			}
			if(DrawManager.isModi)
			{
				DrawManager.NoCursor();
			}
			//drag.enabledDrag(bo)
			
		}
		public function get isSelect():Boolean
		{
			return _isSelect;
		}
		private var di:Sprite;
		public function endfill(xx,yy):void
		{
			var di=new Sprite()
			addChild(di);
			di.graphics.lineStyle(1,0x605CA8)
			di.graphics.beginFill(0,0.1)
			di.graphics.drawRect(0,0,this.width,this.height);
			di.graphics.endFill();
			

			
		}
		public function endDrag():void
		{
			tu1.x=-tu1.width/2;
			tu1.y=-tu1.height/2;
			tu.x=tu1.width/2
			tu.y=tu1.height/2
		}
		public var kxx;//用于画控制器的x
		public var kyy
		public var rx;//中心点的位置
		public var ry
		private function _diMOUSE_OVER(e:MouseEvent):void
		{
			
		}
		private function _diMOUSE_OUT(e:MouseEvent):void
		{
			
		}
		public function showKuan():void
		{
			isSelect=true;
			if(di)
			{
				removeChild(di)
				di=null;
			}
			DrawManager.root.spt.visible=true;
			if(this.bitmap)
			{
				//是文字
				DrawManager.root.spt.currentState="txt";
			}else
			{
				DrawManager.root.spt.currentState=""
			}
			this.addController(new ScaleControler())
			dispatchEvent(new Event_(SELECT_EVENT));
		}
		public function hideKuan():void
		{
			//DrawManager.root.spt.visible=false;
			isSelect=false;
			if(di)
			{
				removeChild(di)
				di=null;
			}
			if(_scaleControler)
			{
				this.removeChild(_scaleControler)
				_scaleControler=null;
			}
			
			
		}
		//添加控制器
		private var _scaleControler
		public function addController(mc:ScaleControler):void
		{
			
			if(_scaleControler)
			{
				this.removeChild(_scaleControler)
				_scaleControler=null;
			}
			_scaleControler=mc
			this.addChild(mc)
			mc.Ower=this;
			mcshow(mc)
			
		}
		protected function mcshow(mc:ScaleControler):void
		{
			if(this.textarea)
			{
				mc.show(this.kxx,this.kyy,this.textarea.width,this.textarea.height,rx,ry)
			}else
			{
				mc.show(this.kxx,this.kyy,this.tu.width,this.tu.height,rx,ry)
			}
		}
		//改变大小等
		public function chageScae(o:Object):void
		{
			
			if(!textarea)
			{
				for(var i:String in o)
				{
					//trace(i+"="+o[i])
					this.tu[i]=o[i]
				}	
			}else
			{
				for(var i:String in o)
				{
					//trace(i+"="+o[i])
					this.textarea[i]=o[i]
				}	
				
			}

			
			//var rec:Rectangle=this.transform.pixelBounds;
			//trace(rec)
			//kxx=rec.x
			//kyy=rec.y
			addController(new ScaleControler())
		}
		//改变中心点
		public function chageCenter(o:Object):void
		{
			tu1.x=-o.x
			tu1.y=-o.y
			tu.x=o.x
			tu.y=o.y
			rx=o.x
			ry=o.y
/* 		 	this.kxx=tu.x
			this.kyy=tu.y
			addController(new ScaleControler())  */
		}
		public function saveAnimation(sx,sy,ex,ey,degree,dura,path:Boolean=false,paharr:Array=null):void
		{
				//gs.TweenMax.to1(testmc,duration1,{x:x1,y:y1,rotation:degree.value});
			this.animation_duration=dura;
			this.animation_ex=ex;
			this.animation_ey=ey;
			this.animation_ration=degree;
			this.animation_sx=sx;
			this.animation_sy=sy;
			hasAnimation=true;
			
			this.animation_path=path;
			this.animation_pathArr=paharr;
			outAnimation();
			
		}
		public function playAnimation():void
		{
			this.x=this.animation_sx;
			this.y=this.animation_sy;
			if(!this.animation_path)
			{
				gs.TweenMax.to1(this,animation_duration,{x:animation_ex,y:animation_ey,rotation:animation_ration});
			}else
			{
				gs.TweenMax.to1(this,animation_duration,{x:animation_ex,y:animation_ey,rotation:animation_ration,
				bezierThrough:animation_pathArr });
			}
			
		}
		private var animation_duration:Number=10
		private var animation_sx:Number=0
		private var animation_sy:Number=0
		private var animation_ex:Number=100
		private var animation_ey:Number=100
		private var animation_ration:Number=0
		
		private var animation_path:Boolean;
		private var animation_pathArr:Array;
		
		
		//在进入到编辑状态之前的一些参数记录
		
		private var inain_oldx:Number;
		private var  inain_oldy:Number;
		private var  inain_oldscalex:Number;//在进入到动画编辑的时候的 scaleX
		private var  inain_oldscaley:Number;//在进入到动画编辑的时候的 scaleY
		private var  inain_oldrotation:Number;
		private var  inain_owner:*;
		[Bindable]
		public var hasAnimation:Boolean=false;
		public function saveOld():void
		{
			this.inain_oldrotation=this.rotation
			this.inain_oldscalex=this.scaleX
			this.inain_oldscaley=this.scaleY
			this.inain_oldx=this.x
			this.inain_oldy=this.y
			this.inain_owner=this.owner;
			
		}
		public function outAnimation():void
		{
			this.rotation=this.inain_oldrotation
			this.scaleX=this.inain_oldscalex
			this.scaleY=this.inain_oldscaley
			this.x=this.inain_oldx
			this.y=this.inain_oldy
			this.inain_owner.addChild(this);
			this.mouseEnabled=true;
		}
		
	}
}