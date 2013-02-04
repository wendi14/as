package com.xmaser.game.comm.level 
{
	import cn.hcxmflash.utils.Singleton;
	import com.xmaser.system.LocalShared;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class GameLevelDataManager extends Singleton 
	{
		private var _levelDataArray:Array;
		
		public function GameLevelDataManager() 
		{
			

		}
		public static function getIns():GameLevelDataManager
		{
			return Singleton.getIns(GameLevelDataManager)
		}
		public function getOldLevelDataArray(gamelevel:String):Array
		{
			var ld:Array = [];
			if (!LocalShared.getIns().local) 
			{
				LocalShared.getIns().init(gamelevel);
			}
			var s:Object = LocalShared.getIns().getData(gamelevel);
			if (s) 
			{
				for (var i:int = 0; i < s.length; i++) 
				{
					var item: Object = s[i];
		
					ld.push(item);
				}
				_levelDataArray = ld;
				return ld
			}else
			{
				
			}
			return null;
		}
		public function saveLevel(level:int,gamename:String=''):void
		{
			for (var i:int = 0; i < _levelDataArray.length; i++) 
			{
				var item: Object = _levelDataArray[i];
				item.level = i 
				if (item.level==level) 
				{
					item.lock = false;
					break;
				}
			}
			if (!LocalShared.getIns().local) 
			{
				LocalShared.getIns().init(gamename);
			}
			LocalShared.getIns().save(gamename, _levelDataArray);
		}
		
		public function createLevelDataArray(totalLevel:int):Array
		{
			var ld:Array = [];
			for (var i:int = 0; i < totalLevel; i++) 
			{
				var item: Object = {}
				item.level = i
				item.lock = true;
				if (i == 0) item.lock = false;
				ld.push(item);
			}
			_levelDataArray = ld;
			return ld
		}
		
		public function get levelDataArray():Array 
		{
			return _levelDataArray;
		}
		public function clear():void
		{
			LocalShared.getIns().clear()
		}

		
	}

}