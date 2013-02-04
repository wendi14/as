package com.xmaser.file

{
	
	import flash.display.Sprite;
	
	import flash.utils.ByteArray;
	
	import flash.utils.Endian;
	
	import flashx.textLayout.elements.InlineGraphicElement;
	
	public class SwfParser extends Sprite
	
	{
		
		
		
		private var _swfByteArray:ByteArray = new ByteArray();
		
		
		
		private var _swfSize:int;
		
		private var _frameRate:int;
		
		private var _frameTotal:int;
		
		private var _version:int;
		
		private var TestClass:Class
		
		public function SwfSymbolClassParser(swf:ByteArray )
		{
			
			
			
			
			var tempByteArray:ByteArray = swf;
			var compressed:String = tempByteArray.readUTFBytes(3);
			_version = tempByteArray.readByte();
			
			var length:uint = tempByteArray.readUnsignedInt();
			
			tempByteArray.position = 8;
			
			tempByteArray.readBytes(_swfByteArray);
			
			if (compressed == 'CWS')
				
			{
				
				_swfByteArray.uncompress();
				
			}
			
			_swfByteArray.endian = Endian.LITTLE_ENDIAN;
			
			_swfSize = _swfByteArray.readUnsignedByte() >> 3;
			
			_swfByteArray.position = Math.ceil((_swfSize * 4) / 8 + 5); 
			
			
			
			_frameRate = _swfByteArray.readShort() / 256; 
			
			_frameTotal = _swfByteArray.readShort(); 
		
			
		
		}
		public function getSymbolClassLink():Array
		
		{
			_swfByteArray.endian = Endian.LITTLE_ENDIAN;
			
			while (_swfByteArray.bytesAvailable)
			{
				
				var tagHead:int = _swfByteArray.readShort();
				
				var tagType:int = tagHead >> 6;
				var tagLength:int = tagHead & 0x3F;
				
				if (tagLength == 63) 
				{
					
					tagLength = _swfByteArray.readUnsignedInt();
					
				}
				if (tagType == 76)
					
				{
					_classList = [];
					parseSymbolClass(tagLength);
					
				}
				else
					
				{
					
					_swfByteArray.position += tagLength;
					
				}
				
			}
			
			return _classList;
		}
		
		private var _classList:Array;
		
		private function parseSymbolClass(length:int):void
		{
			
			var classNum:int = _swfByteArray.readShort();
			
			while (classNum--)
				
			{
				
				var classId:int = _swfByteArray.readUnsignedShort();
				
				
				var char:int = _swfByteArray.readByte();
				
				var name:String = "";
				
				while (char)
					
				{
					
					name += String.fromCharCode(char);
					
					char = _swfByteArray.readByte();
					
				}
				
				trace("导出类名为" + name);
				
				_classList.push(name);
				
			}
		
		}
	
	}

}