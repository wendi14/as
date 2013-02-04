package hcxm.cn.media
{

	
	import hcxm.cn.event.Event_;
	import flash.text.TextField;
	import flash.display.MovieClip;
	public class ImageProgressBar2  extends ImageProgressBar
	{

		override protected function PROGRESS(e:Event_):void
		{
			var per=e.data.bytesLoaded/e.data.bytesTotal;
			tt.text=Math.round(per*100)+source.percentLabel;
		}
		
	}
}