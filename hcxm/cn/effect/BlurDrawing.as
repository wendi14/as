package hcxm.cn.effect {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	
	/**
	* ...
	* @author Default
	*/
	public class BlurDrawing extends Sprite {
		private var draging:Boolean;
		private var filter:DropShadowFilter;
		private var fiArr:Array;
		private var zd:Boolean;
		private var zdx:Number;
		private var zdy:Number;
		private var speed:Number = 10;
		public var strt:Boolean;
		public var hightDepth;
		public var isDouble:Boolean = false;//如果是双击的话,就不会跟随鼠标
		public function BlurDrawing() {
			
			this.draging = false;
			this.zd = false;
			this.fiArr = [];
			this.filter = new DropShadowFilter(4, 45, 0x666666, .6, 10, 10, 1, 3, false, false, false);
			this.fiArr.push(filter);
			//trace("滤镜是"+fiArr);
			this.filters = fiArr;
			this.strt = false;
			this.addEventListener(MouseEvent.MOUSE_DOWN, MOUSE_DOWN);
			
		}
		
		private function MOUSE_DOWN(e:MouseEvent):void {
			this.parent.setChildIndex(this,hightDepth);
			
			strt = true;
			draging = true;
			zd = false;
			this.stage.addEventListener(MouseEvent.MOUSE_UP, MOUSE_UP)
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, MOUSE_MOVE)
			this.addEventListener(Event.ENTER_FRAME, ENTER_FRAME)
		}
		
		private function ENTER_FRAME(e:Event):void {
			if (strt&&!isDouble) {
				if (zd) {

					
					this.x += (zdx-this.x)/speed;
					this.y += (zdy-this.y)/speed;
					this.filter.blurX = this.filter.blurY=Math.abs((this.x-zdx)/2);
					this.filter.distance = (this.x-zdx)/1.5;
					this.filters = fiArr;
				} else {
					//mo.call(this);
					//trace( "mo : " + mo );
					//this.stage.removeEventListener(Event.ENTER_FRAME,ENTER_FRAME)
				}
			}			
		}
		
		private function MOUSE_MOVE(e:MouseEvent):void {
			if (draging&&!isDouble) {
				mo.call(this);
			} else {
				this.filters = null;
			}			
		}
		
		private function MOUSE_UP(e:MouseEvent):void {
			
			draging = false;
			if (zd) {
				
			}else {
				zdx = stage.mouseX;
				zdy = stage.mouseY;				
			}
			zd = true;
		}
		private function mo() {
			this.x += (stage.mouseX-this.x)/speed;
			this.y += (stage.mouseY-this.y)/speed;
			if (this.x == stage.mouseX && this.y == stage.mouseY) {
				zd = false;
			}
			this.filter.blurX = this.filter.blurY=Math.abs((this.x-stage.mouseX)/2);
			this.filter.distance = (this.x-stage.mouseX)/1.5;
			this.filters = fiArr;
		}		
		
	}
	
}