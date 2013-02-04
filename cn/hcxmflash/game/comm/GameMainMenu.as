package cn.hcxmflash.game.comm 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import gs.TweenLite;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class GameMainMenu extends MovieClip
	{
		private var _btnPlayCallBack;
		private var _btnHelpCallBack;
		private var _btnHighScoreCallBack;
		public static const DISPOSE:String = "dispose";
		
		public function GameMainMenu() 
		{
			/**
			 * 注意
			 * 默认中心点需要移到中间
			 */
			this.x = this.width / 2;
			this.y = this.height / 2;
		}
		/**
		 * 设置 play 的执行函数
		 */
		public function set btnPlayCallBack(value):void 
		{
			_btnPlayCallBack=value
		}
		public function set btnHelpCallBack(value):void 
		{
			_btnHelpCallBack=value
		}
		public function set btnHighScoreCallBack(value):void 
		{
			_btnHighScoreCallBack = value;
		}
		protected function initBtnPlay():void
		{
			btnPlay.addEventListener(MouseEvent.CLICK, __btnPlayCLICK);
		}
		protected function __btnPlayCLICK(e:MouseEvent):void 
		{
			if (_btnPlayCallBack)
			{
				_btnPlayCallBack();
			}
		}
		protected function initBtnHelp():void
		{
			btnHelp.addEventListener(MouseEvent.CLICK, __btnHelpCLICK);
		}
		
		protected function __btnHelpCLICK(e:MouseEvent):void 
		{
			if (_btnHelpCallBack) 
			{
				_btnHelpCallBack()
			}
		}
		protected function initBtnHighScore():void
		{
			btnHighScore.addEventListener(MouseEvent.CLICK, __btnHighScoreCLICK);
		}
		
		protected function __btnHighScoreCLICK(e:MouseEvent):void 
		{
			if (_btnHighScoreCallBack)
			{
				_btnHighScoreCallBack();
			}
		}
		protected function initBtnMoreGame():void
		{
			btnMoreGame.addEventListener(MouseEvent.CLICK, __btnMoreGameCLICK);
		}
		
		protected function __btnMoreGameCLICK(e:MouseEvent):void 
		{
			
		}
		public function dispose():void
		{
			TweenLite.to(this, 0.3, { alpha:0, scaleX:0.1, scaleY:0.1 ,onComplete:__closeComplete} );
			
		}
		
		private function __closeComplete():void
		{

			dispatchEvent(new Event(DISPOSE))
		}
		
		/**
		 * 开始游戏
		 */
		public function get btnPlay() :SimpleButton { return this.getChildByName("_btnPlay") as SimpleButton; }
		/**
		 * 高分数
		 */
		public function get btnHighScore() :SimpleButton { return this.getChildByName("_btnScore") as SimpleButton; }
		/**
		 * 帮助
		 */
		public function get btnHelp() :SimpleButton { return this.getChildByName("_btnHelp") as SimpleButton; }
		/**
		 * 更多游戏
		 */
		public function get btnMoreGame() :SimpleButton{ return this.getChildByName("_btnMoreGame") as SimpleButton; }
	}

}