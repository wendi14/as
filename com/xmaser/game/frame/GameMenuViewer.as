package com.xmaser.game.frame 
{
	import cn.hcxmflash.game.sound.GSound;
	import cn.hcxmflash.game.sound.GSoundManager;
	import com.xmaser.media.sound.AssetSound;
	import com.xmaser.media.sound.SoundManager;
	import com.xmaser.view.ViewBasic;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author 
	 */
	public class GameMenuViewer extends  GameViewBaic 
	{
		
		public function get mcc():game_asset_gamemenu { return _mc; }
		public function GameMenuViewer() 
		{
			
			super(game_asset_gamemenu);
		}
		override protected function drawUI():void 
		{
			super.drawUI();
			
			if(mcc.btn_help)mcc.btn_help.addEventListener(MouseEvent.CLICK, __btn_help);
			if(mcc.btn_help)mcc.btn_help.addEventListener(MouseEvent.ROLL_OVER, __ROLL_OVER);
			if(mcc.btn_highScore)mcc.btn_highScore.addEventListener(MouseEvent.CLICK, __btn_highScore);
			if(mcc.btn_highScore)mcc.btn_highScore.addEventListener(MouseEvent.ROLL_OVER, __ROLL_OVER);
			mcc.btn_play.addEventListener(MouseEvent.CLICK, __btn_play);
			mcc.btn_play.addEventListener(MouseEvent.ROLL_OVER, __ROLL_OVER);
			
			if (mcc.btn_sound) 
			{
				mcc.btn_sound.buttonMode = true;
				mcc.btn_sound.gotoAndStop(1);
				mcc.btn_sound.addEventListener(MouseEvent.CLICK, __btn_soundCLICK);
				mcc.btn_sound.addEventListener(MouseEvent.ROLL_OVER, __btn_soundROLL_OVER);
				if (SoundManager.getIns().isMute)
				{
					mcc.btn_sound.gotoAndStop(2);
				}
			}
			
		}
		
		private function __btn_soundROLL_OVER(e:MouseEvent):void 
		{
			if (_game.buttonSound) 
			{
				SoundManager.getIns().playSound(_game.buttonSound);
			}
		}
		
		private function __btn_soundCLICK(e:MouseEvent):void 
		{
			if (mcc.btn_sound.currentFrame==1) 
			{
				mcc.btn_sound.gotoAndStop(2);
				SoundManager.isMute = true;
				SoundManager.getIns().mute();
			}else
			{
				SoundManager.isMute = false;
				mcc.btn_sound.gotoAndStop(1);
				SoundManager.getIns().mute(false);
			}
		}
		
		protected function __ROLL_OVER(e:MouseEvent):void 
		{
			if (_game.buttonSound)
			{
				SoundManager.getIns().playSound(_game.buttonSound);
			}
		}
		override public function destroy():void 
		{
			if(mcc.btn_help)mcc.btn_help.removeEventListener(MouseEvent.CLICK, __btn_help);
			if(mcc.btn_highScore)mcc.btn_highScore.removeEventListener(MouseEvent.CLICK, __btn_highScore);
			if(mcc.btn_play)mcc.btn_play.removeEventListener (MouseEvent.CLICK, __btn_play)
			super.destroy();
			
		}
		
		public function update():void 
		{
			if (SoundManager.getIns().isMute)
				{
					mcc.btn_sound.gotoAndStop(2);
				}else
				{
					mcc.btn_sound.gotoAndStop(1);
				}
		}
		protected function __btn_play(e:MouseEvent):void 
		{
			if (_game.buttonClickSound) 
			{
				//GSoundManager.getIns().addSound(new GSound(_game.buttonClickSound))
				SoundManager.getIns().playSound(_game.buttonClickSound);
			}
			_game.playGame()
		}
		
		private function __btn_highScore(e:MouseEvent):void 
		{
			if (_game.buttonClickSound) 
			{
				SoundManager.getIns().playSound(_game.buttonClickSound);
			}
			_game.showGameHighScore();
		}
		
		private function __btn_help(e:MouseEvent):void 
		{
			if (_game.buttonClickSound) 
			{
				SoundManager.getIns().playSound(_game.buttonClickSound);
			}
			_game.showGameHelp();
		}
	}

}