package com.xmaser.plist 
{
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author wdc
	 */
	public class PlistParser 
	{
		public var texture:PlistVO;
		public var frames:Array;
		public function PlistParser() 
		{
			
		}
		public function parser(xm:XML):void
		{
			//trace( "xm : " + xm );trace( "xm.dict : " + xm.dict );
			frames = [];
			
			var ar:Array = [];
			var key:String
			for each (var item:XML in xm.dict.children() ) 
			{
				
				if (item.name() == "key")
				{
					//trace( "item : " + item );
					var pvo:PlistVO = new PlistVO();
					pvo.key = item;
					ar.push(pvo);
					
					key = item;
					
				}else
				{
					if (key =='texture' )
					{
						var dict:PDictVO = new PDictVO();
						dict.buildFormXML(item);
						pvo.dict = dict;
						texture = pvo;
					}else
					{
						
						for each (var item2:XML in item.children()) 
						{
							pvo = build(item2, pvo);
							if (pvo)
							{
								frames.push(pvo);
							}
						}
					}
					
				}
				
				
			}
			//trace(xm.dict.length())
		}
		private function build(item:XML,pvo1:PlistVO):PlistVO
		{
			//trace( "item : " + item );
			if (item.name() == "key")
			{
				//trace( "item : " + item );
				var pvo:PlistVO = new PlistVO();
				pvo.key = item;
			}else 
			{
				var dict:PDictVO = new PDictVO();
				dict.buildFormXML(item);
				pvo1.dict = dict;
			}
			return pvo;
		}
	}

}