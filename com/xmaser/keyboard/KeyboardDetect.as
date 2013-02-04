package com.xmaser.keyboard 
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author 
	 */
	public class KeyboardDetect 
	{
		private var _key:Dictionary=new Dictionary();
		private var keyDonwFunc:Function;
		private var keyUpFunc:Function;
		private var stage:Stage;
		
		public function KeyboardDetect(stage:Stage, keyDonwFunc:Function=null,keyUpFunc:Function=null) 
		{
			this.stage = stage;
			this.keyUpFunc = keyUpFunc;
			this.keyDonwFunc = keyDonwFunc;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, __KEY_DOWN);
			stage.addEventListener(KeyboardEvent.KEY_UP, __KEY_UP);
		}
		public function destory():void
		{
			_key=new Dictionary();
			this.keyUpFunc = null;
			this.keyDonwFunc = null;
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, __KEY_DOWN);
			stage.removeEventListener(KeyboardEvent.KEY_UP, __KEY_UP);
		}
		private function __KEY_DOWN(e:KeyboardEvent):void 
		{
			
			if (!_key[e.keyCode])
			{
				_key[e.keyCode] = { };
			}
			/*if (e.keyCode == Keyboard.LEFT)
			{*/
				_key[e.keyCode].down = true;
			/*}*/
			if (this.keyDonwFunc != null) this.keyDonwFunc.call();
		}
		
		private function __KEY_UP(e:KeyboardEvent):void 
		{
			
  			_key[e.keyCode].down = false;
			//trace( "_key[e.keyCode].down : " + _key[e.keyCode].down );
			
			if (this.keyUpFunc != null) this.keyUpFunc.call();
		}
		public function getKeyisDown(key:uint):Boolean
		{
			if (_key.hasOwnProperty(key)==false)
			{
				return false;
			}
			//trace( "_key[key].down : " + _key[key].down );
			return _key[key].down;
		}
		public function getKeyisUp():Boolean
		{
			return false;
		}
		
	}

}