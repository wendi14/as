package  cn.hcxmflash.container
{
	import cn.hcxmflash.container.Menu;
	import cn.hcxmflash.managers.PopUpManager;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class Menu extends ListBasic 
	{
		private var _xPos:int=0;
		private var _yPos:int=0;
		private var _realParent:DisplayObjectContainer
		public function Menu() 
		{
			addEventListener(Event.ADDED_TO_STAGE, __ADDED_TO_STAGE);
		}
		
		private function __ADDED_TO_STAGE(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, __ADDED_TO_STAGE);
			
			_realParent.stage.addEventListener(MouseEvent.MOUSE_UP,__stageCLICK)
		}
		public static function createMenu(inParent:DisplayObjectContainer,dp:Object = null):Menu
		{
			var m:Menu = new Menu()
			m._realParent = inParent;
			m.dataProvider = createDataObj(dp)
			
			popUpMenu(m, inParent, dp);
			
			return m;
		}
		public static function removeMenu(m:Menu):void
		{
			
		}
		static private function createDataObj(dp:Object):Array 
		{
			var res:Array = [];
			var item:*
			var o:Object
			if (dp is Array)
			{
				for (var i:int = 0; i < dp.length; i++) 
				{
					item = dp[i];
					if (typeof(item) != "object")
					{
						o = { label:String(item), data:item };
					}else 
					{
						o = { label:(item).label, data:item };
					}
					
					res.push(o);
				}
			}else if (dp is Object) 
			{
				for each (var item1:* in res) 
				{
					if (item1.label == null)
					{
						throw new Error("找不到label属性");
					}
					res.push(item1);
				}
			}
			
			return res;
		}
		
		static private function popUpMenu(m:Menu, inParent:DisplayObjectContainer, dp:Object):void 
		{
			
		}
		public function show(xPos:int=0,yPos:int=0):void
		{
			_xPos = xPos; _yPos = yPos;
			
			
			init()
			
		}
		public function destory():void
		{
			PopUpManager.removePopUp(this);
			_realParent.stage.removeEventListener(MouseEvent.MOUSE_UP, __stageCLICK)
			_realParent = null;
		}
		private function init():void 
		{
			var p:DisplayObjectContainer
			if (this.parent)
			{
				p = this.parent;
			}else if (this._realParent) 
			{
				p = this._realParent;
				
			}
			var pt:Point = p.globalToLocal(new Point(_xPos, _yPos))
			this.x = pt.x; this.y = pt.y;
			PopUpManager.addPopUp(this, p);
			
			
		}
		
		private function __stageCLICK(e:MouseEvent):void 
		{
			if (e.target is Stage == false)
			{
				//e.stopImmediatePropagation()
			//	return;
			}
			destory()
		}
		
		private function __CLICK(e:MouseEvent):void 
		{
			
		}
	}

}