package hcxm.cn.shape
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import hcxm.cn.debug.Debug;
	import hcxm.cn.shape.VO.LineAndFillColorVO;
	import hcxm.cn.shape.VO.TextVO;
	import hcxm.cn.shape.manager.DrawManager;
	
	import mx.controls.Button;


	public class DrawBasic extends EventDispatcher
	{
		public var canvaMc:Sprite;//在这个影片上画
		public var thickness:Number=4;//线条宽度
		public var linecolor:uint=0x000000;//线条颜色
		public var linealpha:Number=1;//线条的透明度
		
		public var LFVO:LineAndFillColorVO=new LineAndFillColorVO()
		public var TEXTVO:TextVO=new TextVO()
		public function DrawBasic(mc:Sprite)
		{
			canvaMc=mc;
			createEvent()
			//mc.addEventListener(Event.ADDED_TO_STAGE,_ADDED_TO_STAGE)
			LFVO.fillAlpha=1;
			LFVO.lineThickness=this.thickness;
		}
		public static var _ins:DrawBasic;
		
		public static function getIns(mc:Sprite):DrawBasic
		{
			if(_ins==null)
			{
				_ins=new DrawBasic(mc)
			}
			return _ins;
		}

		private function _ADDED_TO_STAGE(e:Event):void
		{
			createEvent()
		}
		private function createEvent():void
		{
			canvaMc.stage.addEventListener(MouseEvent.MOUSE_DOWN,_MOUSE_DOWN);
			canvaMc.stage.addEventListener(MouseEvent.MOUSE_UP,_MOUSE_UP);
			canvaMc.stage.addEventListener(MouseEvent.MOUSE_MOVE,_MOUSE_MOVE);
			canvaMc.stage.addEventListener(KeyboardEvent.KEY_DOWN,_KEY_DOWN);
			canvaMc.stage.addEventListener(KeyboardEvent.KEY_UP,_KEY_UP);
		}
		protected var isDraw:Boolean=false;
		protected var ga:Graphics
		protected function _MOUSE_DOWN(e:MouseEvent):void
		{
			var ta=e.target;
			isDraw=true;
			if(!DrawManager.stageEnabled)
			{
				if(ta is DragedSprite )
				{
					Debug.trace_(e.target)
					if(ta&&ta.owner)
					{
						
						canvaMc.removeChild(ta);
						ta=null;
					}
				}
				isDraw=false;
				return;
			}
			
			if(ta==canvaMc)
			{
				trace("点到舞台")
				DrawManager.dragedSprite=null
				DrawManager.isModi=false;
			}
			if(ta.hasOwnProperty("isController"))return;
			if(DrawManager.isModi)return;
			if(ta is DragedSprite )
			{
				Debug.trace_(ta);
				trace(this+"=this.isEnabledDraw="+this.isEnabledDraw)
				//只有在自已不能画和画布中没有画笔的时候才能选中已画的物体
				if(!this.isEnabledDraw&&DrawManager.isDraw==false)
				{
					isDraw=false;
					var dad:DragedSprite=ta as DragedSprite;
					DrawManager.dragedSprite=dad;
					if(dad.isSelect)return;
					dad.showKuan();
					
					
				}
				for(var i:int=0;i<canvaMc.numChildren;i++)
				{
					var o=canvaMc.getChildAt(i);
					if(o is Button)continue;
					if(o is DragedSprite&&o!=dad)
					{
						var ds1:DragedSprite=o
						ds1.hideKuan();
					}
				}

				
				
			}else
			{
				DrawManager.root.spt.visible=false;
				//DrawManager.dragedSprite=null
				for(var i:int=0;i<canvaMc.numChildren;i++)
				{
					var o=canvaMc.getChildAt(i);
					if(o is Button)continue;
					if(o is DragedSprite&&o!=dad)
					{
						var ds1:DragedSprite=o
						ds1.hideKuan();
					}
				}
			}
			
		}
		
		protected function _MOUSE_MOVE(e:MouseEvent):void
		{
			
		}
		protected function _MOUSE_UP(e:MouseEvent):void
		{
			isDraw=false;
			
		}
		protected function _KEY_DOWN(e:KeyboardEvent):void
		{
			shiftKeyIsPress=e.shiftKey
		}
		protected function _KEY_UP(e:KeyboardEvent):void
		{
			shiftKeyIsPress=false;
		}
		protected var shiftKeyIsPress:Boolean=false;	
		private var _isEnabledDraw:Boolean=false;
		public function set isEnabledDraw(boo:Boolean):void
		{
			
			_isEnabledDraw=boo;
			
			if(!_isEnabledDraw)
			{
				DrawManager.NowDrawingCursor=DrawManager.NoCursor
				enabledDraw(boo)
			}else
			{
				
				//DrawManager.DrawCursor()
				DrawManager.NowDrawingCursor=DrawManager.DrawCursor;
				
			}			
			
			
		}
		public function get isEnabledDraw():Boolean
		{
			return _isEnabledDraw;
		}
		
		public function enabledDraw(boo:Boolean):void
		{
			
			/* for(var i:int=0;i<canvaMc.numChildren;i++)
			{
				var o=canvaMc.getChildAt(i);
				if(o is DragedSprite)
				{
					var ds:Draw_arc_dragSprite=o;
					
					
				}
			} */
			
		}		
		public function manualDraw():void
		{
			var lvo=this.LFVO
			ga.clear();
			ga.lineStyle(lvo.lineThickness,lvo.lineColor,lvo.lineAlpha/100);
		}
	}
}