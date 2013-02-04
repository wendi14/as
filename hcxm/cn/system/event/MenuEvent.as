package hcxm.cn.system.event {
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.display.InteractiveObject
	
	/**
	* ...
	* @编写者： wendi(小火柴)
						http://www.hcxm.cn
	*/
	public class MenuEvent extends ContextMenuEvent{
		public static const  SELECT:String = "select";
		public var nowLabel:String;
		public function MenuEvent(type:String,nowLabel:String, bubbles:Boolean = false, cancelable:Boolean = false, mouseTarget:InteractiveObject = null, contextMenuOwner:InteractiveObject = null) {
			super(type, bubbles, cancelable, mouseTarget, contextMenuOwner)
			this.nowLabel = nowLabel;
			
		}
		override public function clone():Event {
			return new MenuEvent(type, nowLabel, bubbles, cancelable, mouseTarget, contextMenuOwner);
		}
		override public function toString():String {
			return "[ContextMenuEvent type="+type+" nowLabel="+nowLabel+" bubbles="+bubbles+" cancelable="+cancelable+" eventPhase="+eventPhase+" mouseTarget"+mouseTarget+" contextMenuOwner"+contextMenuOwner;
		}
		
	}
	
}