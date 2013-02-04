package {
	
	import com.flashdev.bitmap.*;	
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.filters.*;

	public class ReflectionTest extends Sprite {
		
		// Constructor
		public function ReflectionTest() {
			// Setup stage
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			
			// Load image
			var loadImg:Loader = new Loader();
			loadImg.contentLoaderInfo.addEventListener(Event.COMPLETE, onImgLoaded);
			loadImg.load(new URLRequest("image.jpg"));
		}
		
		// Called when image is loaded
		private function onImgLoaded(event:Event):void {
			
			var sprImg:Sprite = new Sprite();
			
			// Attach image
			var disImg:DisplayObject = event.target.content;
			var filGlow:GlowFilter = new GlowFilter(0x000000, .3, 8, 8, 1, 3, false, false);
			disImg.filters = [filGlow];
			sprImg.addChild(disImg);
			
			// Add reflection
			var sprReflect:Reflection = new Reflection(disImg, .4, .2, 0, 0, 1);
			sprImg.addChild(sprReflect);			
			
			// Center
			sprImg.x = (this.stage.stageWidth - sprImg.width) / 2;
			sprImg.y = (this.stage.stageHeight - sprImg.height) / 2;
			
			this.addChild(sprImg);
		}
	}
}
