package com.xmaser.map45.model 
{
	import cn.hcxmflash.vo.VoBasicFlash;
	
	/**
	 * ...
	 * @author 
	 */
	public class ItemVO extends VoBasicFlash 
	{
		public var type:int;
		public var id:int;
		public var name:String;
		public var url:String;
		public var x:int
		public var y:int;
		public var overlapX:int = 1;
		public var overlapY:int = 1;
		
		public function ItemVO() 
		{
			
		}
		
	}

}