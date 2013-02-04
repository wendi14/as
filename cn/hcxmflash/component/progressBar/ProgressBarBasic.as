package  cn.hcxmflash.component.progressBar
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class ProgressBarBasic extends Sprite 
	{
		private var _nowProgress:Number = 0;
		private var _totalProgress:Number=0;
		
		public function ProgressBarBasic() 
		{
			
		}
		public function start():void
		{
					
		}
		public function reset():void
		{
			_nowProgress = 0;
		}
		public function setProgress(value:Number):void
		{
			_nowProgress = value;
			if (_nowProgress >= _totalProgress)
			{
				_nowProgress = _totalProgress;
				complete()
			}
			
		}
		public function get precent():Number { return _nowProgress/_totalProgress; }
		public function complete():void
		{
			dispatchEvent(new Event(Event.COMPLETE,true,true));		
		}
		public function updateBar():void
		{
					
		}
		public function get totalProgress():Number 
		{
			return _totalProgress;
		}
		
		public function set totalProgress(value:Number):void 
		{
			_totalProgress = value;
		}
		
		public function get nowProgress():Number 
		{
			return _nowProgress;
		}
		
		public function set nowProgress(value:Number):void 
		{
			_nowProgress = value;
		}
	}

}