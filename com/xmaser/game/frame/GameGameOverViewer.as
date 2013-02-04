package com.xmaser.game.frame 
{
	import cn.hcxmflash.game.sound.GSound;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author 厦门火柴 www.xmaser.com|www.hcxmflash.cn
	 */
	public class GameGameOverViewer extends GameViewBaic 
	{
		public function get mcc():game_asset_gameover { return mc ; }
		public function GameGameOverViewer() 
		{
			super(game_asset_gameover)
		}
		override protected function drawUI():void 
		{
			super.drawUI();
			initbtns()
		}
		
		protected function initbtns():void 
		{
			if (mcc.btn_back)
			{
				mcc.btn_back.addEventListener(MouseEvent.CLICK, __btn_backCLICK);
				mcc.btn_back.addEventListener(MouseEvent.ROLL_OVER, __btn_backROLL_OVER);
			}
			
			mcc.btn_playagain.addEventListener(MouseEvent.CLICK, __btn_playagainCLICK);
			mcc.btn_playagain.addEventListener(MouseEvent.ROLL_OVER, __btn_playagainROLL_OVER);
		}
		
		private function __btn_playagainROLL_OVER(e:MouseEvent):void 
		{
			if (_game&&_game.buttonSound)
			{
				new GSound(_game.buttonSound);
			}
		}
		
		private function __btn_backROLL_OVER(e:MouseEvent):void 
		{
			if (_game&&_game.buttonSound)
			{
				new GSound(_game.buttonSound);
			}
		}
		
		protected function __btn_playagainCLICK(e:MouseEvent):void 
		{
			_game.playAgainFromGameOver()
		}
		
		protected function __btn_backCLICK(e:MouseEvent):void 
		{
			_game.backFromGameOver()
		}
		
	}

}