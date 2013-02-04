package com.xmaser.title.tmx 
{
	import com.hurlant.util.Base64;
	import com.xmaser.map45.model.ItemVO;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Endian;
	/**
	 * ...
	 * @author 小火柴
wendi14@qq.com
	 */
	public class TmxParser 
	{
		private var _map:Array;
		private var _mapItemvo:Array
		private var _tileset:Dictionary;
		public function TmxParser() 
		{
			
		}
		
		public function parser(tmx:XML):void
		{
			_map = [];
			_tileset = new Dictionary();
			var xmllist:XMLList = tmx.layer;
			//trace( "xmllist : " + xmllist );
			var ww:int = tmx.@width;
			var hh:int = tmx.@height;
			for each (var item:XML in xmllist) 
			{
				//trace(item.data);
				//var b:Base64 = new Base64()
				var by:ByteArray = Base64.decodeToByteArray(item.data);
				by.uncompress();
				by.endian = Endian.LITTLE_ENDIAN;
				//trace(by.bytesAvailable);
				_map[item.@name] = [];
				var nowMap:Array = _map[item.@name];
				for (var i:int = 0; i <hh; i++) 
				{
					nowMap[i]=[]
					for (var j:int = 0; j <ww; j++) 
					{
						var item2:int= by.readInt();
						//trace("item2: " +j,i, item2);
						
						if (item2 >0)
						{
							//trace("item2: " +j,i, item2);
						}
						nowMap[i][j] =item2
						//trace("_map[i][j]: " + _map[i][j]);
						
					}
					
				}
				
			}
			for each (var item3:XML in tmx.tileset) 
			{
				var tilevo:Tileset = new Tileset();
				tilevo.buildFormXMLAttr(item3);
				//trace("tilevo: " + tilevo);
				_tileset[tilevo.firstgid] = tilevo;
			}
		}
		public function transtoItemVO():Array
		{
			
			var _mapItemvoArr:Array = [];
			var k:int = 0;
			
			for  (var n:String in map) 
			{
				var itemarr:Array = map[n];
				_mapItemvo = [];
				for (var i:int = 0; i < itemarr.length; i++) 
				{
					for (var j:int = 0; j < itemarr[i].length; j++) 
					{
						k++
						var item:int = itemarr[i][j];
						//if(item==2)trace("item: " + item);
						
						if (item > 0)
						{
								var ivo:ItemVO = new ItemVO();
								ivo.id = k;
								ivo.name = i + "_" + j;
								ivo.type = item;
								ivo.url = _tileset[item].image;
								ivo.x = j;
								ivo.y = i;
								//trace("ivo.y: " +ivo.x, ivo.y);
								
								_mapItemvo.push(ivo);
						}
					}
					
				}
				_mapItemvoArr[n]=(_mapItemvo);
			}
			return _mapItemvoArr;
		}
		public function get tileset():Dictionary 
		{
			return _tileset;
		}
		
		public function get map():Array 
		{
			return _map;
		}
		
	}

}