package cn.hcxmflash.net 
{
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class MutilLoader extends EventDispatcher
	{
		private var _arr:Array;
		private var _loadFunc:Function;
		public function MutilLoader(arr:Array) 
		{
			_arr = arr;
			
			startLoad()
			
		}
		
		private function startLoad():void
		{
			if (_arr.length==0) 
			{
				return;
			}
			var lo:Function = _arr.shift();
			lo.apply(null,[f1])
			//_loadFunc.call(lo);
		}
		
		private function f1():void
		{
			//trace("f1 : " + f1);
			startLoad()
		}
		
	}

}