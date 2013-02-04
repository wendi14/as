package  cn.hcxmflash.game.sound
{
	import cn.hcxmflash.game.comm.component.Viewer;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class GSoundSprite extends Viewer 
	{
		
		public function GSoundSprite(ui:Class) 
		{
			super(ui)
		}
		override public function drawComplete():void 
		{
			super.drawComplete();
			
			addEventListener(Event.ENTER_FRAME,__enter)
		}
		
		private function __enter(e:Event):void 
		{
			if (MovieClip(_mc).currentFrame == MovieClip(_mc).totalFrames)
			{
				MovieClip(_mc).stop();
				removeEventListener(Event.ENTER_FRAME, __enter);
				destory()
			}
		}
		
	}

}