package hcxm.cn.loading
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.events.FlexEvent;
	import mx.preloaders.IPreloaderDisplay;

	public class MyPreloader2 extends Sprite implements IPreloaderDisplay
	{
		
		private var cc:MovieClip
		private var swfmc
		public function MyPreloader2()
		{
			super();
			backgroundColor=0x000000;
		
		}
		public function initialize():void
		{
			backgroundColor=0x000000;
			swfmc=new a();
			cc=swfmc.lod.c;
			swfmc.visible=false;
			swfmc.alpha=0;
			swfmc.addEventListener(Event.ADDED_TO_STAGE,addTostage)
			addChild(swfmc);
			//swfmc.addEventListener(Event.ENTER_FRAME,_ENTER_FRAME)
			timer.start()
			timer.addEventListener(TimerEvent.TIMER,_ENTER_FRAME)
		}
		var timer:Timer=new Timer(100)
		private function _ENTER_FRAME(e):void
		{
			if(!swfmc)
			{
				return;
			}
			
			
			swfmc.visible=true;
			swfmc.alpha+=0.1
			if(swfmc.alpha>=1)
			{
				timer.stop();
				swfmc.removeEventListener(Event.ENTER_FRAME,_ENTER_FRAME)
			}
		}
		private function addTostage(e):void
		{//swfmc.visible=true;
			swfmc.x=stage.stageWidth/2-swfmc.width/2;
			swfmc.y=stage.stageHeight/2-swfmc.height/2;
			
			
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
			//swfmc.pre.close();
			swfmc.removeEventListener(Event.ENTER_FRAME,_ENTER_FRAME)
			timer.stop();
			timer=null;
			removeChild(swfmc)
			swfmc=null;
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