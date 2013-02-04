package com.xmaser.system 
{
	import cn.hcxmflash.utils.Singleton;
	import flash.text.Font;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author 厦门火柴 www.xmaser.com|www.hcxmflash.cn
	 */
	public class FontManager extends Singleton 
	{
		
		
		
		public function FontManager() 
		{
			
		}
		public static function getIns():FontManager { return Singleton.getIns(FontManager); }
		
		
		public function get textFormat():TextFormat { return  new TextFormat(font,12,0x000000); }
		public function get textFormat12White():TextFormat { return  new TextFormat(font,12,0xffffff); }
		public function get textFormat12Red():TextFormat { return  new TextFormat(font,12,0xff0000); }
		public function get textFormat16():TextFormat { return  new TextFormat(font,16,true); }
		public function get textFormat14():TextFormat { return  new TextFormat(font, 14,0); }
		public function get textFormat14White():TextFormat { return  new TextFormat(font, 14,0xffffff); }
		public function get textFormat14Red():TextFormat { return  new TextFormat(font, 14,0xcc3300,false,null); }
		public function get textFormat16Red():TextFormat { return  new TextFormat(font, 16,0xcc3300,false,null,true); }
		
		public function get textFormatMenu():TextFormat
		{
			var a:Array = Font.enumerateFonts(false);
			return  new TextFormat(font,16,0xffffff); 
		}
		public function get font():String 
		{
			var fn:String = '';
			var a:Array = Font.enumerateFonts(true);
			for each (var item:Font in a) 
			{
				if (item.fontName == 'Microsoft YaHei' || item.fontName == "微软雅黑")
				{
					fn = 'Microsoft YaHei';
					break;
				}
			}
			if (fn == '')
			{
				for each (var item2:Font in a) 
				{
					//trace( "item2.fontName : " + item2.fontName );
					if (item2.fontName == 'SimHei'||item2.fontName=="黑体")
					{
						
						fn = item2.fontName;
						break;
					}
				}
			}
			
			if (fn == '')
			{
				fn = "_sans";
			}
			return fn;
			
		 }
		public function checkFont():Array
		{
			var a:Array = Font.enumerateFonts(true);
			//var needLoadFonts:Array=[['SimHei'],['Microsoft YaHei',"微软雅黑"]]
			var needLoadFonts:Array=[['SimHei'],['Microsoft YaHei',"微软雅黑"]]

			for each (var item:Font in a) 
			{
				/*if (item.fontName == 'Microsoft YaHei'||item.fontName=="微软雅黑")
				{
					needLoadFonts = delf('STXinwei', a);
					
					
				}*/
				needLoadFonts = delf(item.fontName, needLoadFonts);
				
				
			}
			trace("needLoadFonts: " + needLoadFonts);
			return needLoadFonts;
		}
		
		public function registerFont(fs:String, definition:Object):void 
		{
			trace("fs: " + fs);
			Font.registerFont(definition as Class);
			
		}
		private function delf(s:String,a:Array):Array
		{
			for (var i:int = 0; i < a.length; i++) 
			{
				var item:Array = a[i];
				for each (var item2:String in item) 
				{
					if (item2 == s)
					{
						a.splice(i, 1);
						break;
					}
				}
			
				
			}
			return a;
		}
	}

}