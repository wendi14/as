package hcxm.cn.system {
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import hcxm.cn.event.MouseEvent_;
	import hcxm.cn.system.event.MenuEvent;
	

	public class Mouse_Right_Menu extends EventDispatcher{
		private var menu:ContextMenu;
		public var nowMenu;
		public static var instan
		public function Mouse_Right_Menu(roo:Sprite) {
			menu = new ContextMenu();
			menu.hideBuiltInItems();
			roo.contextMenu = menu;
		}

		/**
		 * 添加菜单
		 * @param	str	叫什么名
		 * @param	root	在哪个影片上面添加
		 * @param	separatorBefore		是否在这行菜单上面添加一条分隔符
		 */
		public function addItem(str:String, separatorBefore:Boolean=false) {
			var custom:ContextMenuItem = new ContextMenuItem(str);
			custom.separatorBefore = separatorBefore;
			nowMenu = str;
			menu.customItems.push(custom);
			custom.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,MENU_ITEM_SELECT)
		}
		
		/**
		 * 对当前所点击的右键菜单发出点击事件。。。。。
		 * @param	e
		 */
		private function MENU_ITEM_SELECT(e:ContextMenuEvent):void {
			var con:ContextMenuItem = e.target as ContextMenuItem;
			dispatchEvent(new MouseEvent_(MouseEvent_.CLICK, [con.caption,e.contextMenuOwner],true));
		}
		
	}
	
}
