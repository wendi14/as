package hcxm.cn.loading {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import hcxm.cn.shape.Shape;
	
	import mx.effects.Tween;
	import mx.effects.easing.Circular;
	import mx.events.TweenEvent;
	
	/**
	* ...用纯as来画进度条;
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class LoadingTiao_As extends MovieClip {
		var tween:Tween
		var tiao:Sprite
		var tt:TextField
		var loading:Boolean = false;
		public function LoadingTiao_As() {
			tiao = new Sprite();
			Shape.rec(0, 0, 100, 10, tiao, 1,false,0,0xF0F0F0);
			addChild(tiao)
			tiao.scaleX = 0;
			

			
			tt = new TextField()
			//tt.text = "正在连接..."
			addChild(tt)
		}
		public  function move(x:Number):void {
			if (!loading) {
				loading = true;
				removeChild(tt);
			var kuan = new Sprite()
			Shape.rec(0, 0, 100, 10, kuan, 1,true);
			addChild(kuan);				
			}
			tiao.scaleX = x;
		}
		public function comple():void {
			this.parent.removeChild(this)
			//tween= new Tween(this, "scaleY",mx.effects.easing.Circular.easeInOut, 1, 0, 1, true);
			//tween.addEventListener(TweenEvent.TWEEN_END,MOTION_FINISH)
		}
		private function MOTION_FINISH(e:TweenEvent):void {
			
		}
	}
	
}