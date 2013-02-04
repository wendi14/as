package cn.hcxmflash.game.data 
{
	/**
	 * ...
	 * @author 小火柴
	 */
	public class ModelLocater
	{
		
		public function ModelLocater() 
		{
			
		}
		private static var _ins:ModelLocater
		
		public static function getIns():ModelLocater
		{
			if (_ins==null) 
			{
				_ins=new ModelLocater()
			}
			return _ins;
		}
	}

}