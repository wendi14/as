package cn.hcxmflash.control.pageControl 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.text.TextField;
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class Btn extends MovieClip
	{
		public var id;
		public function Btn() 
		{
			this.buttonMode = true;
			this.mouseChildren = false;
			this.addEventListener(Event.ADDED_TO_STAGE, __ADDED_TO_STAGE);
			di.visible = false;
		}
		
		private function __ADDED_TO_STAGE(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, __ADDED_TO_STAGE);
			//txt_id.text = 'v'
		}
		public function set text(v):void
		{
			
			txt_id.text = v
		}
		public function set selected(b:Boolean):void
		{
			di.visible = b
		}
	}

}