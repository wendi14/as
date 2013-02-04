package com.xmaser.game.frame 
{
	import cn.hcxmflash.utils.Singleton;
	
	/**
	 * ...
	 * @author 
	 */
	public class GameLocalModeManager extends Singleton 
	{
		
		private var _game:GameViewer;
		
		
		public function GameLocalModeManager() 
		{
			
		}
		public static function getIns():GameLocalModeManager { return Singleton.getIns(GameLocalModeManager) as GameLocalModeManager; }
		
		public function get game():GameViewer 
		{
			return _game;
		}
		
		public function set game(value:GameViewer):void 
		{
			_game = value;
		}
		
		
	}

}