package hcxm.cn.loading
{
	/**
	 * 在加载多个资源时，分开来加载，一个加载完成后，再加载下一个，不要同时加载，分散开来，加快速度
	 * 说明
	 * 
	 * */
	public class MutilLoadier
	{
		public function MutilLoadier()
		{
		}
		private var _arr:Array=[];
		private var _total:int=0;
		private var _start:int=0;
		
		/**
		 * 把要加载的东西先存进来
		 * @param	target	加载的对像
		 * @param	loadurl	加载对像要加载的资源地址，是一个urlrequest
		 * @param	eventStr		加载对像加载完成后，发送的事件。
		 */
		public function add(target,loadurl,eventStr):void
		{
			_arr.push([target,loadurl,eventStr])
		}
		/**
		 * 在要加载的东西存进来后，就调用这个方法，开始加载 了
		 */
		public function load():void
		{
			_total=_arr.length;
			_load(_arr[_start])
		}
		private function _load(ar):void
		{
			ar[0].load(ar[1]);
			ar[0].addEventListener(ar[2],_complete)
		}
		private function _complete(e):void
		{
			e.target.removeEventListener(_arr[_start][2],_complete)
			_start++;
			if(_start<_total)
			{
				 load()
			}
		}
	}
}