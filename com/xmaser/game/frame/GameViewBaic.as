package com.xmaser.game.frame 
{
	import com.xmaser.view.ViewBasic;
	
	/**
	 * ...
	 * @author 
	 */
	public class GameViewBaic extends ViewBasic 
	{
		protected var _game:GameViewer;
		
		public function GameViewBaic(cla:Class) 
		{
			_game=GameLocalModeManager.getIns().game
			super(cla);
		}
		
	}

}