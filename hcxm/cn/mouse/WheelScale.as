package hcxm.cn.mouse {
	import fl.transitions.easing.Strong;
	import fl.transitions.Tween;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import hcxm.cn.event.Event_;
	import flash.utils.*
	
	/**
	* ...鼠标滚轮
	* @author 小火柴(http://www.hcxm.cn)
	*/
	public class WheelScale extends EventDispatcher {
		private var adminindex = 0;
		public var Mc:Sprite
		public static const ONSCALE:String = "onscale"
		public static const OnBig:String = "onbig";
		public static const onSmall:String = "onsmall";
		private static var mc1
		private static var mc2
		private static var mc3
		
		private static var mcn1
		private static var mcn2
		private static var mcn3
		private static var sp:Sprite
		public function WheelScale(mc:Sprite) {
			this.Mc = mc;
			mc.addEventListener(MouseEvent.MOUSE_WHEEL,MOUSE_WHEEL)
		}
		
		private function MOUSE_WHEEL(e:MouseEvent):void {
			
			if (e.delta>1) {
				adminindex++;
				if (adminindex>2) {
					adminindex = 2;
					dispatchEvent(new Event_(OnBig, adminindex, true));
				}
			}else {
				adminindex--
				if (adminindex<-2) {
					adminindex = -2;
					dispatchEvent(new Event_(onSmall, adminindex, true));
				}
			}
			//Mc.scaleX = Mc.scaleY = 1 + index * .2;
			duringScale(Mc.scaleX,1+adminindex*0.3)
			dispatchEvent(new Event_(ONSCALE, adminindex, true));
		}
		
		private function duringScale(now, target):void {
			var time=0.5
			var tween1:Tween = new Tween(Mc, "scaleX", Strong.easeOut, now, target, time, true)
			var tween2:Tween = new Tween(Mc, "scaleY", Strong.easeOut, now, target, time, true)
		}
		public static function ScaleMore(mcn1:String, mcn2:String, mcn3:String, spp):void {
			
			WheelScale.mcn1= getDefinitionByName(mcn1);
			WheelScale.mcn2 = getDefinitionByName(mcn2)	
			WheelScale.mcn3 = getDefinitionByName(mcn3);
			
			
			WheelScale.sp = spp;
			WheelScale.mc1 = mc1
			//hcxm.cn.mouse.WheelScale.mc2 = mc2;
			//WheelScale.mc3 = mc3;
			
			addMc1()
			
			
		}
		static function addMc1() {
			mc1 = new mcn1();
			sp.addChild(mc1)
			onFadeIn(mc1)		


			var whe:WheelScale = new WheelScale(mc1);
			whe.addEventListener(WheelScale.OnBig,OnBig1)
		}
		static function addMc2() {
			mc2 = new WheelScale.mcn2()
			sp.addChild(mc2)
			onFadeIn(mc2)

			var whe:WheelScale = new WheelScale(mc2);
			whe.addEventListener(WheelScale.onSmall, onSmall2);
			whe.addEventListener(WheelScale.OnBig,onBig2)
		}
		static function addMc3() {
			mc3 = new WheelScale.mcn3();
			sp.addChild(mc3)
			onFadeIn(mc3)
			mc3.x = mc2.x;
			mc3.y = mc2.y;
			var whe:WheelScale = new WheelScale(mc3);
			whe.addEventListener(WheelScale.onSmall, onSmall3);
		}
		
		static private function onSmall3(e:Event_):void {
			sp.removeChild(mc3);
			addMc2();
		}
		static private function onBig2(e:Event_):void {
			sp.removeChild(mc2);
			addMc3();
		}
		static private function onSmall2(e:Event_):void {
			//trace( "e : " + e );
			sp.removeChild(mc2)
			addMc1()
		}
		
		static private function OnBig1(e:Event_):void {
			sp.removeChild(mc1);
			addMc2();
		}
		static function onFadeIn(mc:Sprite) {
			mc.alpha = 0;
			mc.addEventListener(Event.ENTER_FRAME,ENTER_FRAMEFadeIn)
		}
		
		static private function ENTER_FRAMEFadeIn(e:Event):void {
			var m:Sprite = e.target as Sprite
			m.alpha += 0.1;
			if (m.alpha>=1) {
				m.removeEventListener(Event.ENTER_FRAME, ENTER_FRAMEFadeIn);
			}
		}
		public function get INDEX() { return adminindex; }
		
	}
	
}