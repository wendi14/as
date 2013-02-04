package hcxm.cn.shape.manager
{
	import flash.ui.Mouse;
	
	import hcxm.cn.debug.Debug;
	import hcxm.cn.mouse.MouseICNO;
	import hcxm.cn.shape.DragedSprite;
	import hcxm.cn.shape.DrawBasic;
	import hcxm.cn.shape.controlClass.ControlDiComponent;
	
	import mx.managers.CursorManager;
	import mx.managers.PopUpManager;
	
	import view.bottomTools.ShapePropertiesTitleWindow;
	
	public class DrawManager
	{
		
		public function DrawManager()
		{
		
		}
		public static var root
		public static var drawCanvs;//画布
		[Bindable]
		public static var dragedSprite:DragedSprite;//现在选中的是哪个
		private static var _isModi:Boolean=false;//鼠标移到属性面板，就为 ture,移开就为 false;
		
		
		private static var _stageEnabled:Boolean=true;//舞台还能不能画?不能画说明在使用放大，移动等工具

		public static function set stageEnabled(v):void
		{
			_stageEnabled=v;
			dragedSprite=null;
		}
		public static function get stageEnabled():Boolean
		{
			return _stageEnabled
		}
		
		public static var hasArc:Boolean=false;//是不是在场景中移动鼠标的时候有碰到可以画弧形的;如果有的话，把鼠标改回来;
		public static function set  isModi(bo:Boolean):void
		{
			_isModi=bo
			if(_isModi)
			{
				if(dragedSprite)
				{
					dragedSprite.showKuan();
				}
			}
		}
		public static function get  isModi():Boolean
		{
			return _isModi;
		}
		
		public static var isDraw:Boolean=false;
		private static var _drawer:DrawBasic;
		private static var _drawserArr:Array=[]
		public static function set drawer(d:DrawBasic):void
		{
			_drawer=d;
			
			

			if(_drawserArr.length>0)
			{
			var isin:Boolean=false
				for(var i:int=0;i<_drawserArr.length;i++)
				{
					var dd:DrawBasic=_drawserArr[i];
					if(_drawserArr[i]==d)
					{
						isin=true
					}else
					{
						dd.isEnabledDraw=false;
					}
				}
			}else
			{
				_drawserArr.push(d);
			}
			if(!isin)
			{
				_drawserArr.push(d);
			}
			
		}
		public static function get drawer():DrawBasic
		{
			return _drawer;
		}
		
		private static var _ins:DrawManager
		public static function getIns():DrawManager
		{
			if(_ins==null)
			{
				_ins=new DrawManager()
			}
			return _ins;
		}
		public static  function DrawCursor()
		{			
			Mouse.hide();
			CursorManager.removeAllCursors();
			CursorManager.setCursor(MouseICNO.Shi,2,-8,-8)
			clearDiSprite()
		}			
		public static  function HuxianCursor():void
		{			
			Mouse.hide();
			CursorManager.removeAllCursors();
			CursorManager.setCursor(MouseICNO.Hu);
			hasArc=true;
		}			
		public static  function MoveSelectCursor():void
		{			
			Debug.trace_("鼠标指针=SelectCursor")
			Mouse.hide();
			CursorManager.removeAllCursors();
			CursorManager.setCursor(MouseICNO.Move) 
			
		}
		//			
		public static  function NoCursor()
		{	
			Debug.trace_("鼠标指针=removeAllCursors")		
			Mouse.show()
			CursorManager.removeAllCursors();
			clearDiSprite()
		}
		//放大			
		public static  function ZoomInCursor():void
		{	
			Debug.trace_("鼠标指针=ZoomInCursor")		
			Mouse.hide();
			CursorManager.removeAllCursors();
			CursorManager.setCursor(MouseICNO.zooIn)
			diSprite(ZoomInCursor)	
		}
		private static var _di:ControlDiComponent
		//像放大等操作，在场景中建立一个遮的UIcom，这样就点不到画布中的物体
		private static function diSprite(fc):void
		{
			if(_di)
			{
				root.removeChild(_di)
				_di=null;
			}
			_di=new ControlDiComponent()
			_di.graphics.beginFill(0,0.1);
			_di.graphics.drawRect(0,0,root.width,root.height);
			_di.graphics.endFill();
			_di.tools=fc;
			root.addChildAt(_di,1);
		}			
		private static function clearDiSprite():void
		{
			if(_di)
			{
				root.removeChild(_di)
				_di=null;
			}
		}			
		//缩小
		public static  function ZoomOutCursor():void
		{	
			Debug.trace_("鼠标指针=ZoomOutCursor")		
			Mouse.hide();
			CursorManager.removeAllCursors();
			CursorManager.setCursor(MouseICNO.zooOut);
			
			diSprite(ZoomOutCursor)	
		}		
		//手形移动	
		public static  function HandMoveCursor():void
		{	
			Debug.trace_("鼠标指针=HandMoveCursor")		
			Mouse.hide();
			CursorManager.removeAllCursors();
			CursorManager.setCursor(MouseICNO.handMove) ;
			
			diSprite(HandMoveCursor)	
		}	
		//橡皮擦
		public static  function XianPiChaCursor():void
		{	
			Debug.trace_("鼠标指针=XianPiChaCursor")		
			Mouse.hide();
			CursorManager.removeAllCursors();
			CursorManager.setCursor(MouseICNO.xianPicha) ;
			
		}	
		//文字鼠标
		public static  function HandTextCursor():void
		{	
			Debug.trace_("鼠标指针=HandMoveCursor")		
			Mouse.hide();
			CursorManager.removeAllCursors();
			CursorManager.setCursor(MouseICNO.handText) ;
			clearDiSprite()
		}		
		private static var _NowDrawingCursor:Function=NoCursor
		public static function set NowDrawingCursor(v:Function):void
		{
			_NowDrawingCursor=v
		}
		public static function get NowDrawingCursor():Function
		{
			return _NowDrawingCursor;
		}
		
		static var properWin:ShapePropertiesTitleWindow
		public static function openProperiesWindows():void
		{
			properWin=ShapePropertiesTitleWindow(PopUpManager.createPopUp(root,ShapePropertiesTitleWindow,false));
			
		}
	}
}