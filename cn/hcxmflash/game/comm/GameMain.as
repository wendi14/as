package  cn.hcxmflash.game.comm
{
	import cn.hcxmflash.game.comm.component.Viewer;
	import flash.display.Sprite;
	import flash.events.Event;
	import gs.TweenAlign;
	import gs.TweenLite;
	import mochi.as3.MochiScores;
	
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class GameMain extends Sprite 
	{
		
		public static const PauseView:String = "_pauseView";
		public static const HELP_VIEW:String = "_helpView";
		public static const MainMenuView:String = "_mainMenuView";
		public static const GameOverView:String = "_gameOverView";
		public static const WinView:String = "_gameWinView";
		public static const NextView:String = "_nextView";
		
		
		protected var _nextView:Viewer;
		protected var _mainMenuView:Viewer;
		protected var _pauseView:Viewer;
		protected var _gameOverView:Viewer;
		protected var _gameWinView:Viewer;
		protected var _helpView:Viewer
		private var _uiClassArr:Array=[]
		protected var _duration:Number=0.6;
		public function GameMain() 
		{
			if (stage)
			
			{
				init()
			}else
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
			
		}
		
		private function init(event:Event=null):void 
		{
			stage.scaleMode = "noScale";
			stage.align = "tl";
			stage.showDefaultContextMenu = false;
		}
		public function initView(variable:*,cla:Class):void
		{
			_uiClassArr[variable] = cla;
			//this[variable] = new cla();
		}
		public function showMainMenuView():void
		{
			_mainMenuView = new (_uiClassArr[MainMenuView]);
			addChild(_mainMenuView)
		}
		public function hideMainMenuView():void
		{
			_mainMenuView.destory();
			removeChild(_mainMenuView)
			_mainMenuView = null;
		}
		public function showPauseView():void
		{
			_pauseView = new (_uiClassArr[PauseView]);
			addChild(_pauseView)
			
		}
		public function hidePauseView():void
		{
			_pauseView.destory()
			removeChild(_pauseView);
			_pauseView = null;
		}
		public function showNextView():void
		{
			_nextView = new (_uiClassArr[NextView]);
			addChild(_nextView);
			_nextView.alpha = 0;
			TweenLite.to(_nextView,_duration, { alpha:1} );
		}
		public function hideNextView():void
		{
			_nextView.destory();
			removeChild(_nextView);
			_nextView = null;
		}
		public function showGameWinView():void
		{
			_gameWinView=new (_uiClassArr[WinView])
			addChild(_gameWinView)
		}
		public function hideGameWinView():void
		{
			
			
			_gameWinView.destory();
			removeChild(_gameWinView);
			_gameWinView = null;
		}
		public function showGameOverView():void
		{
			_gameOverView=new (_uiClassArr[GameOverView])
			addChild(_gameOverView)
		}
		public function hideGameOverView():void
		{
			
			
			_gameOverView.destory();
			removeChild(_gameOverView);
			_gameOverView = null;
		}
		public function showHelpView():void
		{
			_helpView=new (_uiClassArr[HELP_VIEW])
			addChild(_helpView)
		}
		public function hideHelpView():void
		{
			_helpView.destory();
			removeChild(_helpView);
			_helpView = null;
		}
		public function showLeaderboard():void
		{
			var o:Object = { n: [5, 4, 14, 0, 11, 0, 11, 5, 0, 15, 13, 5, 8, 6, 9, 14], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
			var boardID:String = o.f(0,"");
			MochiScores.showLeaderboard({boardID: boardID});
		}
		public function submitScore(playerscore:Number):void
		{
			//trace( "playerscore : " + playerscore );
			
			var o:Object = { n: [5, 4, 14, 0, 11, 0, 11, 5, 0, 15, 13, 5, 8, 6, 9, 14], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
			var boardID:String = o.f(0,"");
			MochiScores.showLeaderboard({boardID: boardID, score: playerscore});
		}
		
		public function get gameOverView():Viewer 
		{
			return _gameOverView;
		}
	}

}