package hcxm.cn.mouse {
	import flash.display.InteractiveObject;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	

	public class Mouse_Right_Menu extends EventDispatcher{
		private var menu:ContextMenu;
		public var nowMenu:String;
		public static var instan:*
		private var arr:Array = []
		private var roo:*
		public static const BeforeClick:String="beforeclick"
		public function Mouse_Right_Menu(roo:InteractiveObject) {
			menu = new ContextMenu();
			menu.hideBuiltInItems();
			roo.contextMenu = menu;
			this.roo = roo;
			menu.addEventListener(ContextMenuEvent.MENU_SELECT,MENU_SELECT)
		}
		private function MENU_SELECT(e:ContextMenuEvent):void
		{
			//trace("准备菜单之前")
			dispatchEvent(new Event(BeforeClick,true))
		}
		/**
		 * 添加菜单
		 * @param	str	叫什么名
		 * @param	func	处理点击当前菜单的函数，它可以带一个参数，类型是ContextMenuItem
		 * @param	separatorBefore		是否在这行菜单上面添加一条分隔符
		 */
		public function addItem(str:String, func:Function=null,separatorBefore:Boolean=false,enabled:Boolean=false):void
		{
			removeItem(str)
			var custom:ContextMenuItem = new ContextMenuItem(str,separatorBefore,enabled);
			custom.separatorBefore = separatorBefore;
			nowMenu = str;
			menu.customItems.push(custom);
			arr.push([str, func]);
			if (func != null)
			{
				custom.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,MENU_ITEM_SELECT)
			}
		}
		//禁用
		public function enabledItem(adminindex:int):void
		{
			menu.customItems[adminindex].enabled=false;
		}
		public function removeItem(itemLabel:String):void
		{
			for(var i:int=0;i<menu.customItems.length;i++)
			{
				var item:ContextMenuItem=menu.customItems[i];
				if(item.caption==itemLabel)
				{
					menu.customItems.splice(i,1);
					//menu.removeItem(item);//air才能用
				}
			}
		}
		public function rest():void{
			for(var i:int=0;i<menu.customItems.length;i++){
				menu.customItems[i].enabled=true;
			}
		}
		
		/**
		 * 对当前所点击的右键菜单发出点击事件。。。。。
		 * @param	e
		 */
		private function MENU_ITEM_SELECT(e:ContextMenuEvent):void {
			var con:ContextMenuItem = e.target as ContextMenuItem;
			for (var i:int = 0; i < arr.length; i++) {
				if (con.caption == arr[i][0]) {
					var fun:Function = arr[i][1];
					//fun.call(roo);
					fun.apply(roo,[con])
					break;
				}
			}
			//dispatchEvent(new MouseEvent_(MouseEvent_.CLICK, [con.caption,e.contextMenuOwner],true));
		}
		public function get menuG():ContextMenu
		
		{
			return this.menu;
		}
		
	}
	
}
