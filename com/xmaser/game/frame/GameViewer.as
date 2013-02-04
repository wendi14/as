package com.xmaser.game.frame 
{
	import com.xmaser.view.ViewBasic;
	import flash.media.Sound;
	
	/**
	 * ...
	 * @author 
	 */
	public class GameViewer extends ViewBasic 
	{

		protected var _gameOver:GameGameOverViewer;
		protected var _gameMenu:GameMenuViewer;
		protected var _gameHelp:GameHelpViewer;
		protected var _platform:String
		public var buttonSound:*;
		public var buttonClickSound:Class;
		public function GameViewer() 
		{
			super(null);
		}
		
		
		override protected function init():void 
		{
			super.init();
			
			GameLocalModeManager.getIns().game = this;
			
			showGameMenu();
		}
		public function showGameMenu():void
		{
			trace("showGameMenu: " + showGameMenu);
			
			_gameMenu = new GameMenuViewer();
			addChild(_gameMenu);
			
			
		}
		public function removeGameMenu():void
		{
			_gameMenu.destroy()
			removeChild(_gameMenu);
			_gameMenu = null;
		}
		
		public function showGamePuse():void
		{
			
		}
		public function removeGamePause():void
		{
			
		}
		public function showGameHelp():void 
		{
			_gameHelp = new GameHelpViewer();
			addChild(_gameHelp);
		}
		public function removeGameHelp():void
		{
			_gameHelp.destroy()
			removeChild(_gameHelp);
			_gameHelp = null;
		}
		public function showGameHighScore():void 
		{
			
		}
		public function submitGameHighScore():void
		{
			
		}
		
		public function showGameOver():void
		{
			if (_gameOver)
			{
				
			}else 
			{
				_gameOver = new GameGameOverViewer()
			}
			
			addChild(_gameOver);
		}
		public function removeGameOver():void
		{
			_gameOver.destroy()
			removeChild(_gameOver);
			_gameOver = null;
		}
		public function playGame():void 
		{
			
		}
		
		public function playAgainFromGameOver():void 
		{
			removeGameOver();
		}
		
		public function backFromGameOver():void 
		{
			removeGameOver();
		}
		
		
		
		public function get platform():String 
		{
			return _platform;
		}
		
		public function set platform(value:String):void 
		{
			_platform = value;
		}
		
	}

}