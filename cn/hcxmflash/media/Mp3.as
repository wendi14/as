package cn.hcxmflash.media{
	import cn.hcxmflash.event.Event_;
	
	import com.metaphile.MetaReader;
	import com.metaphile.id3.ID3Reader;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	
	import hcxm.cn.time.FormatDate;
	
	
	[Event(name="complete", type="flash.events.Event")] 
	public class Mp3 extends EventDispatcher {
		
		public static const LOAD_COMPLETE:String="load_complete";
		
		private var _url:String
		public var sound:Sound
		private var soundChan:SoundChannel
		private var soundTrans:SoundTransform
		
		private var pauseTime:Number;
		/**
		 * 是否暂停，默认为false
		 */
		public var isPause:Boolean=false;
		//当前音乐的总长度	
		public var soundTotalTime:Number;
		//当前音乐播放到的时间
		private var _soundNowTime:Number;
		public var loadPercent:Number;//已经加载的百分比
		public function Mp3(url:String=null) {
			
			pauseTime = 0;
			
			
			if (url) play(url);
			
		}
		/**
		 * 重头开始播放
		 * @param	url　音乐路径
		 */
		public function play(url:String):void 
		{
			close();
			
			_url = url;
			
			
			//test
			
			//var u:URLStream = new URLStream()
			//u.addEventListener(Event.COMPLETE, __c11);
			//u.load(new URLRequest(url));
			
			//var p:ID3Reader = new ID3Reader();
			//p.read(u)
			//var m:MetaReader=new MetaReader(p,__c22)
			//
			
			
			
			sound = new Sound();
			//sound.addEventListener(Event.ID3, __ID3);
			sound.addEventListener(IOErrorEvent.IO_ERROR, _IO_ERROR);
			sound.addEventListener(ProgressEvent.PROGRESS,PROGRESS);
			sound.addEventListener(Event.COMPLETE, _loadComplete);
			sound.load(new URLRequest(url), new SoundLoaderContext(5000, true));
			
			soundChan = sound.play();
			soundChan.addEventListener(Event.SOUND_COMPLETE, SOUND_COMPLETE);
			
			
			soundTrans = soundChan.soundTransform;
			isPause = false;
			soundTotalTime = 0;
		}
		
		private function __c11(e:Event):void 
		{
			var u:URLStream = e.target as URLStream;
			var d:ByteArray=new ByteArray()
			u.readBytes(d);

			
			//m.read(d);
		}
		
		private function __c22(id:*):void 
		{
			dispatchEvent(new Event_(Event.ID3,id))
			
			
		}
		
		private function __ID3(e:Event):void 
		{
			dispatchEvent(e);
		}
		/**
		 * 停止
		 */
		public function close():void
		{
			if(soundChan)
			{
				soundChan.stop();
				soundChan.removeEventListener(Event.SOUND_COMPLETE, SOUND_COMPLETE);
				soundChan = null;
			}
			if (sound) 
			{
				try 
				{
					sound.close();
				}catch (err:Error)
				{
					
				}
				sound.removeEventListener(ProgressEvent.PROGRESS,PROGRESS);
			}
			sound = null;
			pauseTime = 0;
			isPause = true;
		}

		/**
		 * 暂停
		 */
		public function pause():void {
			if (soundChan) 
			{
				pauseTime = soundChan.position;
			
				soundChan.stop();
				soundChan.removeEventListener(Event.SOUND_COMPLETE, SOUND_COMPLETE);
			}
			
			isPause=true;			
		}
		/**
		 * 停止
		 */
		public function stop():void {
			close();
					
		}
		/**
		 * 继续
		 */
		public function resume():void 
		{						
			if (soundChan) 
			{
				soundChan = sound.play(pauseTime)	;
				soundChan.addEventListener(Event.SOUND_COMPLETE, SOUND_COMPLETE);
			}
			
			isPause=false;
		}
		/**
		 * 跳到指定的秒数
		 * @param	time
		 */
		public function gotoPlay(time:int):void {	
			if (soundChan) 
			{
				soundChan.stop();
				soundChan.removeEventListener(Event.SOUND_COMPLETE, SOUND_COMPLETE);
			}			
			soundChan=null;
			soundChan = sound.play(time*1000)	;
			soundChan.addEventListener(Event.SOUND_COMPLETE, SOUND_COMPLETE);
			isPause=false;
		}

		private function PROGRESS(e:ProgressEvent):void {
			loadPercent = e.bytesLoaded / e.bytesTotal;
		}
		/**
		 * 播放完成
		 * @param	e
		 */
		private function SOUND_COMPLETE(e:Event):void 
		{
			dispatchEvent(new Event(Event.SOUND_COMPLETE))
		}
		/**
		 * 声音已经加载完成
		 * @param	e
		 */
		private function _loadComplete(e:Event):void {
			soundTotalTime=int(sound.length/1000);
			dispatchEvent(e);
		}
		
		private function _IO_ERROR(e:IOErrorEvent):void
		{
			trace("找不到地址");
			dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR,true,false,":"+_url))
		}
		
		public function get soundNowTime():Number 
		{
			_soundNowTime = 0;
			if (soundChan)
			{
				_soundNowTime = soundChan.position / 1000;
				
			}
			return _soundNowTime;
		}
	}
	
}