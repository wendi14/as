package com.xmaser.display.component.tooltip 
{
	import cn.hcxmflash.utils.Singleton;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class ToolTipManager extends Singleton 
	{
		public static var skinClass:Class;
		private var _tipArr:Array = [];
		public static var stage:DisplayObjectContainer;
		
		public function ToolTipManager() 
		{
			
		}
		public static function getIns():ToolTipManager
		{
			return Singleton.getIns(ToolTipManager);
		}
		public function addToolTip(mc:DisplayObject,tip:String,skin:Class=null,texf:TextFormat=null,tipWidth:int=0):void
		{
			if (skin == null) skin = skinClass;
			var t:ToolTip = _tipArr[mc.name] = new ToolTip(mc, tip, skin,texf,tipWidth);
			t.offestPoint = new Point(0, 20);
			stage.addChild(_tipArr[mc.name]);
			_tipArr[mc.name].visible = false;
		}
		public var nowToolTipByCustomTipComponent:ToolTip;
		public function addToolTipByCustomTipComponent(mc:DisplayObject,tipComponent:ToolTip):void
		{
			var t:ToolTip = _tipArr[mc.name] = tipComponent;
			t.offestPoint = new Point(0, 0);
			stage.addChild(_tipArr[mc.name]);
			_tipArr[mc.name].visible = false;
		}
		
	}

}