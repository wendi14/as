package com.xmaser.plist 
{
	import com.xmaser.utils.ObjectUtil;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import model.MonsterConstants;
	/**
	 * ...
	 * @author wdc
	 */
	public class PlistTexture 
	{
		private var parser:PlistParser;
		private var bitmapData:BitmapData;
		private var _textures:Array=[];
		private var _texturesOriginal:Array=[];
		
		public function PlistTexture(configXML:XML,bitmapData:BitmapData) 
		{
			this.bitmapData = bitmapData;
			parser = new PlistParser();
			parser.parser(configXML);
			createTexture();
			
			
		}
		private function createTexture():void 
		{
			for (var i:int = 0; i < parser.frames.length; i++) 
			{
				var item:PlistVO = parser.frames[i];
				//trace( "item : " + item );
				var bd:BitmapData = new BitmapData(item.dict.originalWidth, item.dict.originalHeight,false,0x999999);
				//var bd:BitmapData = new BitmapData(item.dict.originalWidth, item.dict.originalHeight,true,0x00000000);
				//var bd:BitmapData = new BitmapData(item.dict.originalWidth, item.dict.originalHeight,true);
				var rec:Rectangle = new Rectangle(item.dict.x, item.dict.y, item.dict.width, item.dict.height);
				
				var offsetX:int=item.dict.originalWidth/2-item.dict.width/2+item.dict.offsetX
				var offsetY:int = item.dict.originalHeight - item.dict.height;// +item.dict.offsetY;
				offsetX
				
				if (item.dict.offsetY > 0)
				{
					offsetY = -item.dict.height / 2 +(item.dict.offsetY) ;;// -item.dict.height / 2;
				}
				offsetX = offsetY = 0;
				//offsetX = item.dict.offsetX;offsetY = item.dict.offsetY;
				//var po:Point = getOffsetByCenter(item);
				//offsetX = po.x;offsetY =po.y;
				//trace( "item.dict.offsetY : " + item.dict.offsetY );
				//bd.copyPixels(bitmapData,rec,new Point(offsetX,offsetY))
	
				
				var bd2:BitmapData=new BitmapData(item.dict.width, item.dict.height,false,0);
				bd2.copyPixels(bitmapData, rec, new Point());
				//_textures[item.key] = (bd2);
				_texturesOriginal[item.key] = bd2;
				
			}
			//_textures.sortOn("key");
			//trace( "_textures : " + _textures );
		}
		private function getOffsetByCenter(item:PlistVO):Point
		{
			var po:Point = new Point();
			
			var xx:int = item.dict.originalWidth / 2 - item.dict.width / 2;
			var yy:int = item.dict.originalHeight / 2 - item.dict.height / 2;
			
			return new Point(xx, yy);
			
		}
		private function getOffsetByBottom(item:PlistVO):Point 
		{
			var po:Point = new Point();
			
			var xx:int = item.dict.originalWidth/2-item.dict.width/2+item.dict.offsetX
			var yy:int = item.dict.originalHeight  -item.dict.height ;
			
			return new Point(xx, yy);
		}
		public function getTextures(prefix:String,align:String=''):Array
		{
			var arr:Array = [];
			for (var name:String in _textures) 
			{
				if (name.indexOf(prefix)>-1)
				{
					//trace( "name : " + name );
					arr[name]=(_textures[name]);
				}
				
			}
			if (ObjectUtil.getLength(arr) == 0)
			{
				
				build(prefix,align);
				return getTextures(prefix);
			}
			if (prefix == MonsterConstants.MONSTER_BOOS2_ATT2)
			{
				trace( "prefix : " + prefix );
				
				
			}
			arr = ObjectUtil.sortByDescending(arr);
			
			return arr;
		}
		
		private function build(prefix:String,align:String=""):void 
		{
			for (var i:int = 0; i < parser.frames.length; i++) 
			{
				var item:PlistVO = parser.frames[i];
				if (item.key.indexOf(prefix)>-1)
				{
				
						//var bd:BitmapData = new BitmapData(item.dict.originalWidth, item.dict.originalHeight,false,0x999999);
						var bd:BitmapData = new BitmapData(item.dict.originalWidth, item.dict.originalHeight,true,0x00000000);
						//var bd:BitmapData = new BitmapData(item.dict.originalWidth, item.dict.originalHeight,true);
						var rec:Rectangle = new Rectangle(item.dict.x, item.dict.y, item.dict.width, item.dict.height);
						
						var offsetX:int=item.dict.originalWidth/2-item.dict.width/2+item.dict.offsetX
						var offsetY:int = item.dict.originalHeight - item.dict.height;// +item.dict.offsetY;
						
						offsetX = offsetY = 0;
					
						var bd2:BitmapData=new BitmapData(item.dict.width, item.dict.height,false,0);
						//bd2.copyPixels(bitmapData, rec, new Point(item.dict.offsetX,item.dict.offsetY));
						var po:Point = new Point();
						//po=new Point(item.dict.offsetX,item.dict.offsetY)
						switch (align) 
						{
							case "center":
								po = getOffsetByCenter(item);
							break;
						case "bottom":
								po=getOffsetByBottom(item);
							break;
							default:
								
							break;
						}
						bd.copyPixels(bitmapData, rec, po);
						_textures[item.key] = (bd);

				}
			}
			
		}
		
		
		/*public function get textures():Array 
		{
			return _textures;
		}*/
	}
}