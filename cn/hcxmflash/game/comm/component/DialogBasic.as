package cn.hcxmflash.game.comm.component 
{
	import cn.hcxmflash.game.comm.interfaceclass.IDialog;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	import gs.TweenLite;
	
	/**
	 * ...
	 * 默认 素材里面有一个 _btnok 按纽;
	 * @author 小火柴
	 */
	public class DialogBasic extends Sprite implements IDialog
	{
		private var _mc:MovieClip
		private var _link;
		private var _animation:Boolean = true;
		private var _onClickcallBackFunction;
		public function set animation(value):void 
		{
			_animation = value;
		}
		public function get animation() { return _animation; }
		public function DialogBasic(uiClass:Class,onClickcallBackFunction:Function=null)
		{
			
			_link = uiClass;
			showMc()
			_onClickcallBackFunction = onClickcallBackFunction;
		}
		public function dispose():void
		{
			if (_onClickcallBackFunction) _onClickcallBackFunction();
			parent.removeChild(this);
		}
		private function showMc():void
		{	
		
			
			_mc = new _link();
			addChild(_mc);
			
			if (_animation)
			{
				_mc.alpha = 0;
				//_mc.scaleX = _mc.scaleY = 0.1;
				TweenLite.to(_mc, 0.3, {alpha:1 } );
			}
			if (!_mc["_btnok"]) 
			{
				throw new Error("can not find _btnok");
			}
			_mc["_btnok"].addEventListener(MouseEvent.CLICK, __btnokCLICK);
			drawWindow();
		}
		
		protected function drawWindow():void
		{
			
		}
		
		protected function __btnokCLICK(e:MouseEvent):void 
		{
			_mc["_btnok"].removeEventListener(MouseEvent.CLICK, __btnokCLICK);
			
			dispose();
		}
		public function get mc():MovieClip { return _mc; }
		
	}

}