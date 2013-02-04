package com.xmaser.game.frame 
{
	import cn.hcxmflash.game.sound.GSound;
	import cn.hcxmflash.game.sound.GSoundManager;
	import com.xmaser.view.ViewBasic;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author 
	 */
	public class GameHelpViewer extends  GameViewBaic 
	{
		public function get mcc():game_asset_gamehelp { return _mc; }
		public function GameHelpViewer() 
		{
			
			super(game_asset_gamehelp)
		}
		override protected function drawUI():void 
		{
			super.drawUI();
			
			mcc.btn_backmenu.addEventListener(MouseEvent.CLICK, __btn_backCLICK);
		
			mcc.btn_backmenu.addEventListener(MouseEvent.ROLL_OVER, __ROLL_OVER);
			
		}
		
		
		override public function destroy():void 
		{
			mcc.btn_backmenu.removeEventListener(MouseEvent.CLICK, __btn_backCLICK);
			super.destroy();
			
		}
		protected function __btn_backCLICK(e:MouseEvent):void 
		{
			
			GameLocalModeManager.getIns().game.removeGameHelp();
			//GameLocalModeManager.getIns().game.showGameMenu();
		}
		private function __ROLL_OVER(e:MouseEvent):void 
		{
			if (_game&&_game.buttonSound)
			{
				GSoundManager.getIns().addSound(new GSound(_game.buttonSound))
			}
		}
		
	}

}