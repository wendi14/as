package  cn.hcxmflash.utils
{
	
	import flash.accessibility.Accessibility;
	import flash.accessibility.AccessibilityProperties;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.text.*;

	public class ToolTip extends Sprite	{
		private static var instance:ToolTip = null;
		private var label:TextField;		
		private var area:DisplayObject;
		public var labelText:String
		
		public static  var ownerArr:Array = [];
		public static  var mesageArr:Array = [];
		public function ToolTip() {
			label = new TextField();
			label.autoSize = TextFieldAutoSize.LEFT;
			label.selectable = false;
			label.multiline = false;
			label.wordWrap = false;
			label.defaultTextFormat = new TextFormat("宋体", 12, 0x666666);
			label.text = "提示信息";
			label.x = 5;
			label.y = 2;
			addChild(label);
			redraw(0,0);
			visible = false;
			mouseEnabled = mouseChildren = false;
		}
		
		private function redraw(xx, yy) {
			
			
			var po = this.globalToLocal(new Point(xx, yy));
			xx = po.x;
			yy = po.y;
		//trace( "xx : " + xx );
			var w:Number = 10 + label.width;
			var h:Number = 4 + label.height;			
			this.graphics.clear();
			this.graphics.beginFill(0x000000, 0.4);
			this.graphics.drawRoundRect(3, 3, w, h, 5, 5);				
			//this.graphics.moveTo(6, 3 + h);
			//this.graphics.lineTo(12, 3 + h);
			//this.graphics.lineTo(9, 8 + h);
			//this.graphics.lineTo(6, 3 + h);
			//this.graphics.endFill();
			
			this.graphics.beginFill(0xffffff);
			this.graphics.drawRoundRect(0, 0, w, h, 5, 5);
			//this.graphics.moveTo(xx-3, h);
			//this.graphics.lineTo(xx+3, h);
			//this.graphics.lineTo(xx, 5 + h);
			//this.graphics.lineTo(xx, h);
			//this.graphics.endFill();
		}
		
		public static function init(base:DisplayObjectContainer) {
			if (instance == null) {
				instance = new ToolTip();
				base.addChild(instance);				
			}
		}
		
		public static function register(area:DisplayObject, message:String):void {
			if (instance != null) {
				ownerArr.push(area.name);
				
				mesageArr.push(message) ;
				var prop:AccessibilityProperties = new AccessibilityProperties();
				prop.description = message;
				area.accessibilityProperties = prop;
				instance.labelText = message;
				//Accessibility.updateProperties();
				area.addEventListener(MouseEvent.MOUSE_OVER, instance.handler);
			}
		}
		
		public static function unregister(area:DisplayObject):void {
			if (instance != null) {
				area.removeEventListener(MouseEvent.MOUSE_OVER, instance.handler);
			}
		}
		
		public function show(area:DisplayObject, xx, yy):void {
	
			this.area = area;
			this.area.addEventListener(MouseEvent.MOUSE_OUT, this.handler);
			this.area.addEventListener(MouseEvent.MOUSE_MOVE, this.handler);
			
			if (area.accessibilityProperties) 
			{
				label.text = area.accessibilityProperties.description;
			}else 
			{
				var laind:int = ownerArr.indexOf(area.name);
				labelText = mesageArr[laind];
				label.text = labelText;
			}
			redraw(xx, yy);			
			ToolTip.instance.parent.setChildIndex(ToolTip.instance, ToolTip.instance.parent.numChildren - 1);
		}

		
		public function hide():void	{
			this.area.removeEventListener(MouseEvent.MOUSE_OUT, this.handler);
			this.area.removeEventListener(MouseEvent.MOUSE_MOVE, this.handler);
			this.area = null;
			visible = false;
		}
		
		public function move(point:Point):void {			 
			var lp:Point = this.parent.globalToLocal(point);
			this.x = lp.x - 6;			
			this.y = lp.y - label.height - 12;
			if(!visible){
				visible = true;
			}
			if (this.x+this.width>stage.stageWidth) 
			{
				this.x = stage.stageWidth - this.width;
			}
		}
		
		private function handler(event:MouseEvent):void	
		{
			switch(event.type) {
				case MouseEvent.MOUSE_OUT:
					this.hide();
					break;
				case MouseEvent.MOUSE_MOVE:
					this.move(new Point(event.stageX, event.stageY));					
					break;
				case MouseEvent.MOUSE_OVER:
					
					this.show(event.currentTarget as DisplayObject, event.stageX, event.stageY);
					this.move(new Point(event.stageX, event.stageY))
					break;
			}
		}
		
	}
}