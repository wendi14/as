package  cn.hcxmflash.game.sound
{
	import cn.hcxmflash.utils.Singleton;
	
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class GSoundManager extends Singleton 
	{
		private var _sArr:Array;
		public static var isMute:Boolean=false;
		
		public function GSoundManager() 
		{
			_sArr = [];
		}
		public static function getIns():GSoundManager
		{
			return Singleton.getIns(GSoundManager);
		}
		public function addSound(s:GSound):void
		{
			if (isMute==true) 
			{
				return;
			}
			_sArr.push(s);
		}
		public function  mute(bo:Boolean=true):void
		{
			
			for (var i:int = 0; i <_sArr .length; i++) 
			{
				var item:GSound = _sArr[i];
			
				if (bo)
				{
					item.pause();
				}else
				{
					item.resume();
				}
				
			}
		}
		
	}

}