package hcxm.cn.media {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import hcxm.cn.time.FormatDate;
	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class Mp3 extends EventDispatcher {
		
		public static const LOAD_COMPLETE:String="load_complete";
		
		private var _url:String
		private var sound:Sound
		private var soundChan:SoundChannel
		private var soundTrans:SoundTransform
		private var byteArr:ByteArray;
		private var timer:Timer;
		private var bitm:Bitmap
		private var bd:BitmapData 
		private var mc:Sprite
		private var pauseTime:Number;
		private var mcww:Number=10;
		private var mchh:Number=10;
		public var isPause:Boolean=false;
		
		public var songName
		public function Mp3(url:String=null,mca:Sprite=null) {
			mc = mca;
			pauseTime = 0;
			
			if (url) play(url);
			
		}
		public function  effMC(value,ww,hh):void 
		{
			mc = value;
			mcww=ww;
			mchh=hh;
			
		}
		/**
		 * 播放
		 * @param	url
		 */
		public function play(url:String) {
			//trace(url)
			if(soundChan)
			{
				soundChan.stop();
				soundChan.removeEventListener(Event.SOUND_COMPLETE, SOUND_COMPLETE);
			}
			if(sound)
			{
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, TIMER);
				timer=null;
				sound.removeEventListener(ProgressEvent.PROGRESS,PROGRESS);
				try
				{
					trace("关闭")
					sound.close();
				}catch(e)
				{
					trace("出错了，，关闭")
				}
				sound=null;
			}
			
			_url = url;
			sound = new Sound(new URLRequest(url),new SoundLoaderContext(5000,true));
			sound.addEventListener(IOErrorEvent.IO_ERROR,_IO_ERROR)
			soundChan = sound.play();
			soundChan.addEventListener(Event.SOUND_COMPLETE, SOUND_COMPLETE);
			sound.addEventListener(ProgressEvent.PROGRESS,PROGRESS);
			sound.addEventListener(Event.COMPLETE,_loadComplete)
			soundTrans = soundChan.soundTransform;
			//trace( "soundTrans : " + soundTrans.volume );
			timer = new Timer(100);
			timer.addEventListener(TimerEvent.TIMER, TIMER);
			timer.start();
			byteArr = new ByteArray();
			
			bd = new BitmapData(mcww, mchh, true, 0xFFFFFFff);
			bitm = new Bitmap(bd);
			if(mc)
			{
				mc.filters=[new BlurFilter()]
				mc.addChild(bitm);
			}
			
			
		}
		

		/**
		 * 暂停
		 */
		public function pause():void {
			pauseTime = int(soundChan.position);
			//trace( "pauseTime : " + pauseTime );			
			soundChan.stop();
			isPause=true;			
		}
		/**
		 * 停止
		 */
		public function stop():void {
			soundChan.stop()
			sound.close()
			pauseTime = 0;			
		}
		/**
		 * 继续
		 */
		public function resume():void {						
			soundChan = sound.play(pauseTime)	;
			soundChan.addEventListener(Event.SOUND_COMPLETE, SOUND_COMPLETE);
			isPause=false;
		}
		/**
		 * 跳到指定的秒数
		 */
		public function gotoPlay(time):void {	
			soundChan.stop();					
			soundChan=null;
			soundChan = sound.play(time*1000)	;
			soundChan.addEventListener(Event.SOUND_COMPLETE, SOUND_COMPLETE);
			isPause=false;
		}
		private function TIMER(e:TimerEvent):void {
			if(mc)
			{	
				var ga:Graphics = mc.graphics;
				ga.clear()
				mc.transform.colorTransform=new ColorTransform();
				
				try
				{
					SoundMixer.computeSpectrum(byteArr);
					byteArr.position=0;			
					bd.fillRect(bd.rect, 0x00000000);
					
					
					ga.lineStyle(1)
					ga.lineGradientStyle(GradientType.LINEAR,[0xff0000,0x0000ff],[1,1],[0,255])
					for (var i:int = 0; i < mcww-2; i++) {	
						var da = byteArr.readFloat() * mchh
						ga.moveTo(i+1, mchh-0.5);
						ga.lineTo(i+1, mchh-0.5-Math.abs(da));
						
					}
					mc.transform.colorTransform=new ColorTransform(0.8,0.16,1);
					
				}catch(ee:Error)
				{
					trace(ee.message)
					var ga:Graphics = mc.graphics;
					ga.clear()
					//timer.stop();
					dispatchEvent(new Event("NO_Spectrum"));
					
				}
				
			}else
			{
				bd.dispose()
			}
			soundNowTime=FormatDate.FormSecondToTime(int((soundChan.position/1000)))
			soundNowTimeNumber=(int((soundChan.position/1000)))					
			
			//bd.applyFilter(bd,bd.rect,new Point(),new BlurFilter(10,10));
		}
		[Bindable]
		public var soundTotalTime:String="00:00";
		[Bindable]
		public var soundNowTime:String="00:00";
		[Bindable]
		public var soundTotalTimeNumber:Number;
		[Bindable]
		public var soundNowTimeNumber:Number;
		
		private function PROGRESS(e:ProgressEvent):void {
			var per = int(e.bytesLoaded / e.bytesTotal * 100);//已加载百分比
			_loadComplete(null);
		}
		/**
		 * 播放完成
		 * @param	e
		 */
		private function SOUND_COMPLETE(e:Event):void 
		{
			trace(e);
			dispatchEvent(new Event(Event.SOUND_COMPLETE))
		}
		private function _loadComplete(e:Event):void {
			soundTotalTime=String(int((sound.length/1000)));
			soundTotalTimeNumber=int((sound.length/1000));
			soundTotalTime=hcxm.cn.time.FormatDate.FormSecondToTime(Number(soundTotalTime));
			if(e)dispatchEvent(new Event(LOAD_COMPLETE));
		}
		
		private function _IO_ERROR(e:IOErrorEvent):void
		{
			trace("找不到地址");
			dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR,true,false,songName+":"+_url))
		}
	}
	
}