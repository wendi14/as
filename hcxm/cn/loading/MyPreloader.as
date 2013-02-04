package hcxm.cn.loading
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	import mx.events.FlexEvent;
	import mx.preloaders.IPreloaderDisplay;

	public class MyPreloader extends Sprite implements IPreloaderDisplay
	{
		[Embed(source='a1.swf', symbol='a')]
		public var swf:Class;
		private var cc:MovieClip
		private var swfmc:Sprite
		public function MyPreloader()
		{
			super();
			backgroundColor=0x000000;
		}
		public function initialize():void
		{
			swfmc=new swf();
			addChild(swfmc);
			var di:MovieClip=swfmc['di'];
			di.width=stage.stageWidth;
			di.height=stage.stageHeight;	
			var lo:MovieClip=swfmc['lod']	;
					
			lo.x=stage.stageWidth/2-lo.width/2;
			lo.y=stage.stageHeight/2-lo.height/2;
			cc=lo["c"];
			
		}

		public function set preloader(preloader:Sprite):void
		{
			preloader.addEventListener(flash.events.ProgressEvent.PROGRESS,handleProgress)
			preloader.addEventListener(mx.events.FlexEvent.INIT_COMPLETE, 
			handleInitComplete);				
		}
		private function handleProgress(e:ProgressEvent):void{
			//trace(e.bytesLoaded+"---"+e.bytesTotal);
			cc.scaleX=e.bytesLoaded/e.bytesTotal;
		}
		private function handleInitComplete(e:mx.events.FlexEvent):void{
			dispatchEvent(new Event(Event.COMPLETE))
		}
		public function get stageHeight():Number
		{
			return 0;
		}		
		public function set stageHeight(value:Number):void
		{
		}
		
		public function get stageWidth():Number
		{
			return 0;
		}
		
		public function set stageWidth(value:Number):void
		{
		}
		public function get backgroundAlpha():Number
		{
			return 0;
		}
		
		public function set backgroundAlpha(value:Number):void
		{
			
		}
		
		public function get backgroundColor():uint
		{
			return 0;
		}
		
		public function set backgroundColor(value:uint):void
		{
			
		}
		
		public function get backgroundImage():Object
		{
			return null;
		}
		
		public function set backgroundImage(value:Object):void
		{
		}
		
		public function get backgroundSize():String
		{
			return null;
		}
		
		public function set backgroundSize(value:String):void
		{
		}	

		
		
	}
}