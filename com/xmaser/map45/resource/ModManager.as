package com.xmaser.map45.resource 
{
	import cn.hcxmflash.utils.Singleton;
	import com.xmaser.map45.utils.HumanActionBuilder;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author 
	 */
	public class ModManager extends Singleton 
	{
		public var _modS:Array=[]
		public function ModManager() 
		{
			
		}
		private var _modLoader:ModLoader = new ModLoader();
		
		public static function getIns():ModManager
		{
			return Singleton.getIns(ModManager) as ModManager;
		}
		public function loadMod(url:String,callBack:Function=null):void
		{
			
			_modLoader.load(url, callBack2,[callBack,url]);
		}
		
		private function callBack2(by:ByteArray,cs):void 
		{
			var c = cs[0];
			
			var h:HumanActionBuilder=new HumanActionBuilder()
			h.parse(by);
			_modS[cs[1]] = h;
			h.addEventListener(Event.COMPLETE,function(e):void{c()})
		}
	}

}