package cn.hcxmflash.media.lrc 
{
	import cn.hcxmflash.event.Event_;
	import cn.hcxmflash.time.TimeUtils;
	import cn.hcxmflash.utils.StringUtil;
	import com.metaphile.utils.ByteUtil;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author 
	 */
	[Event(name = "loaderComplete", type = "cn.hcxmflash.event.Event_")]
	public class LRCParser extends EventDispatcher 
	{
		private var _urlloader:URLLoader;
		private var _lrcFrom:String = "qq";
		private var _lyrics:Array;
		private var _isReady:Boolean = false;;
		
		private var _setp:int = 1;
		public function LRCParser() 
		{
			_urlloader = new URLLoader();
			_urlloader.addEventListener(Event.COMPLETE, _urlloaderCOMPLETE);
			_urlloader.dataFormat=URLLoaderDataFormat.BINARY
		}
		
		private function _urlloaderCOMPLETE(e:Event):void 
		{
			read(e.target.data)
		}
		public function load(url:String):void
		{
			if (_lrcFrom == "qq")
			{
				
			}else 
			{
				
			}
			_urlloader.load(new URLRequest(url));
		}
		public function read(data:*):void
		{
			if (_lrcFrom == "qq")
			{
				if (_setp == 1)
				{
					_setp++;
					getTrueURL(data as ByteArray)
					return;
				}
				readFromQQ(data as ByteArray)
			}
			
			
		}
		
		private function getTrueURL(data:ByteArray):void 
		{
			var s:String = StringUtil.readGB2312_Byte(data);
			var xm:XML = new XML(s);
			
			for each (var item:XML in xm.cmd.songinfo ) 
			{
				
	
				var id:Number = item.@id;
				var url:String = LRCConst.LRC_URL_QQ;
				url = StringUtil.replaceWords(url, String(id).substr(String(id).length - 2, 2), String(id));
				url = "http://www.hcxmflash.cn/api/trans.php?url=" + url;
				load(url);
				break;
			}
			
			
		}
		
		private function readFromQQ(data:ByteArray):void 
		{
			
			_lyrics=[]
			var s:String 
			s = StringUtil.readGB2312_Byte(data);
			var xm:XML = new XML(s);
			s = String(xm);
			var ar:Array = s.split("\n");
			var reg:RegExp=/\[\d{1,2}:\d{1,2}.\d{1,2}\]/g;
			for (var i:int = 0; i < ar.length; i++) 
			{
				var item:String = ar[i];
				if (reg.test(item))
				{
					var timeArr1:Array = item.match(reg);
					var timeArr2:Array = [];
					
					var reg2:RegExp=/\[(\d{1,2}:\d{1,2}.\d{1,2})\]/g;
					for (var j:int = 0; j < timeArr1.length; j++) 
					{
						var item2:String = timeArr1[j];
						var ob:*= reg2.exec(item2);
						for (var k:int = 1; k < ob.length; k++) 
						{
							var item3:String = ob[k];
							var time:Number = TimeUtils.getTimeFromMSMS(item3,":",".");
							timeArr2.push(time);
						}
						
						//[00:00:00]
						
					}
					var lvo:LrcVO = new LrcVO()
					item = item.replace(reg, "");
					lvo.timeArr = timeArr2;
					lvo.lyrics = item;
					_lyrics.push(lvo);
					trace("")
				}
				
				
			}
			_isReady = true;
			dispatchEvent(new Event_("loaderComplete"));
		}
		
		public function get lrcFrom():String 
		{
			return _lrcFrom;
		}
		
		public function set lrcFrom(value:String):void 
		{
			_lrcFrom = value;
		}
		
		public function get lyrics():Array 
		{
			return _lyrics;
		}
		
		public function set lyrics(value:Array):void 
		{
			_lyrics = value;
		}
		
		public function get setp():int 
		{
			return _setp;
		}
		
		public function set setp(value:int):void 
		{
			_setp = value;
		}
		
	}

}