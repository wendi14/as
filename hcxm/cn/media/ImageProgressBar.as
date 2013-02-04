package hcxm.cn.media
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.text.TextField;
	
	import hcxm.cn.event.Event_;
	
	public class ImageProgressBar extends MovieClip
	{
		private var di:MovieClip;
		private var tt:TextField;
		public function ImageProgressBar()
		{
			
		}
		
		private var _source
		public function set source(va)
		{
			_source=va;
			va.addEventListener(Event_.PROGRESS,PROGRESS)
		}
		[Bindable]
		public function get source()
		{
			return _source;
		}
		
		protected function PROGRESS(e:Event_):void
		{
			var per=e.data.bytesLoaded/e.data.bytesTotal;
			di.scaleX=per
			tt.text=Math.round(per*100)+source.percentLabel;
		}
		public function clear():void
		{
			this.removeEventListener(Event_.PROGRESS,PROGRESS)
			this.addEventListener(Event.ENTER_FRAME,_ENTER_FRAME);
			
		}
		
		var k=0
		private function _ENTER_FRAME(e):void
		{
			k++;
			this.filters=[new BlurFilter(k,k)];
			this.alpha=1-k*0.03;
			if(k>=30)
			{
				this.removeEventListener(Event.ENTER_FRAME,_ENTER_FRAME);
				source.removeChild(this);
			}
		}
		
	}
}