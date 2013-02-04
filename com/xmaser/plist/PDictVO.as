package com.xmaser.plist 
{
	import cn.hcxmflash.vo.VoBasicFlash;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class PDictVO extends VoBasicFlash 
	{
		public var width:Number;
		public var height:Number;
		public var x:int
		public var y:int;
		public var offsetX:int;
		public var offsetY:int;
		public var originalWidth:int;
		public var originalHeight:int;
		
		public function PDictVO() 
		{
			
		}
		override public function buildFormXML(xml:XML):void 
		{
			//trace( "xml : " + xml );
			//super.buildFormXML(xml);
			var key:String = "";
			for each (var item:XML in xml.children()) 
			{
				//trace( "item.name() : " + item.name() );
				if (item.name() == "key")
				{
					
					key = item;
				}else
				{
					this[key] = item;
				}
			}
		}
	}

}