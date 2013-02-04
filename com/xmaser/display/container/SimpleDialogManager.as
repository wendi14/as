package com.xmaser.display.container 
{
	import cn.hcxmflash.utils.Singleton;
	import com.greensock.TweenLite;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Stage;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author 
	 */
	public class SimpleDialogManager extends Singleton 
	{
		
		private var _dialogs:Dictionary = new Dictionary();
		private var _bgs:Dictionary = new Dictionary();
		public static var stage:DisplayObjectContainer;
		public function SimpleDialogManager() 
		{
			
		}
		public static function getIns():SimpleDialogManager
		{
			return Singleton.getIns(SimpleDialogManager);
		}
		
		public function showDialog(d:*):void
		{
			if (_dialogs[d.name]) 
			{
				return;
			}
			var _bg:SimpleDialogManagerBg = new SimpleDialogManagerBg(stage.stage.stageWidth, stage.stage.stageHeight);
			
			stage.addChild(_bg);
			_bg.alpha = 0;
			_bg.visible = true;
			TweenLite.to(_bg, 0.5, { alpha:1 } );
			
			stage.addChild(d);
			_dialogs[d.name] = d;
			_bgs[d.name ] = _bg;
		}
		public function popDialog(d:*):void
		{
			if (_dialogs[d.name]) 
			{
				return;
			}
			var _bg:SimpleDialogManagerBg = new SimpleDialogManagerBg(stage.stage.stageWidth, stage.stage.stageHeight);
			stage.addChild(_bg);
			_bg.visible = false;
			//TweenLite.to(_bg, 0.4, { alpha:1} );
			stage.addChild(d);
			_dialogs[d.name] = d;
			_bgs[d.name] = _bg
		}
		public function removeDialog(d:*):void
		{
			var _dialog:*= _dialogs[d.name];
			var _bg:*= _bgs[d.name];
			if (stage.contains(_dialog))
			{
				stage.removeChild(_dialog);
				if (_dialog is Loader) 
				{
					Loader(_dialog).unloadAndStop();
				}
				
			}
			if(stage.contains(_bg))
			{
				_bg.destory();
				stage.removeChild(_bg);
			}
			_dialogs[d.name] = null;
			_bgs[d.name] = null;
		}
		
	}

}
import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.Event;

class SimpleDialogManagerBg extends  Sprite
{
	public function SimpleDialogManagerBg(ww:Number,hh:Number)
	{
		var g:Graphics = this.graphics;
		g.beginFill(0, 0.3);
		g.drawRect(0, 0, ww, hh)
		g.endFill()
		if (!stage)
		{
			addEventListener(Event.ADDED_TO_STAGE, __ADDED_TO_STAGE);
		}else
		{
			__ADDED_TO_STAGE(null);
		}
	}
	
	private function __ADDED_TO_STAGE(e:Event):void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, __ADDED_TO_STAGE);
		stage.addEventListener(Event.RESIZE, __RESIZE);
	}
	public function destory():void
	{
		stage.removeEventListener(Event.RESIZE, __RESIZE);
	}
	private function __RESIZE(e:Event):void 
	{
		var g:Graphics = this.graphics;
		g.clear();
		g.beginFill(0, 0.3);
		g.drawRect(0, 0, stage.stageWidth, stage.stageHeight)
		g.endFill()
	}
}