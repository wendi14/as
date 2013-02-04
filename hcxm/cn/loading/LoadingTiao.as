package hcxm.cn.loading {
	import fl.transitions.easing.Strong;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class LoadingTiao extends MovieClip {
		var tween:Tween
		var tiao:MovieClip
		public function LoadingTiao() {
		}
		public  function move(x:Number):void {
			tiao.scaleX = x;
		}
		public function comple():void {
			tiao.play()
			tween= new Tween(this, "scaleY", Strong.easeOut, 1, 0, 1, true);
			tween.addEventListener(TweenEvent.MOTION_FINISH,MOTION_FINISH)
		}
		
		private function MOTION_FINISH(e:TweenEvent):void {
			this.parent.removeChild(this)
		}
	}
	
}