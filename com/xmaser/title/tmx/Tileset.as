package com.xmaser.title.tmx 
{
	import cn.hcxmflash.vo.VoBasicFlash;
	
	/**
	 * ...
	 * @author 小火柴
wendi14@qq.com
 <tileset firstgid="1" name="BCANN_FN.SLP 0002" tilewidth="67" tileheight="81">
  <image source="C:/Users/wendc/Desktop/empire/BCANN_FN.SLP 0002.bmp" trans="000000" width="67" height="81"/>
 </tileset>
	 */
	public class Tileset extends VoBasicFlash 
	{
		public var firstgid:String;
		public var name:String;
		public var tilewidth:Number
		public var tileheight:Number;
		public var image:String
		public function Tileset() 
		{
			
		}
		override public function buildFormXMLAttr(xml:XML):void 
		{
			super.buildFormXMLAttr(xml);
			image = xml.image.@source;
		}
		
	}

}