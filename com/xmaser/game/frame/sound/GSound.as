package  com.xmaser.game.frame.sound	
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class GSound 
	{
		private var soundChannel:SoundChannel;
		private var sound:Sound;
		private var _loop:Boolean;
		private var _soundPostion:Number;
		
		public function GSound(S:*,loop:Boolean=false,volume:Number=1) 
		{
			
			
			sound= new S();
			soundChannel = sound.play();
			var tclone:SoundTransform = soundChannel.soundTransform;
			tclone.volume = volume;
			soundChannel.soundTransform = tclone;
			
			_loop = loop;
			if (loop)
			{
				soundChannel.addEventListener(Event.SOUND_COMPLETE, __SOUND_COMPLETE);
			}
		}
		private function __SOUND_COMPLETE(e:Event):void 
		{
			var tclone:SoundTransform = soundChannel.soundTransform; 
			
			
			soundChannel.removeEventListener(Event.SOUND_COMPLETE, __SOUND_COMPLETE);
			
			soundChannel = sound.play();
			soundChannel.soundTransform = tclone;
			soundChannel.addEventListener(Event.SOUND_COMPLETE, __SOUND_COMPLETE);
		}
		public function pause():void
		{
			_soundPostion = soundChannel.position;
			soundChannel.stop()
		}
		public function resume():void
		{
			
			soundChannel = sound.play(_soundPostion);
			
			if (_loop)
			{
				soundChannel.addEventListener(Event.SOUND_COMPLETE, __SOUND_COMPLETE);
			}
		}
		
	}

}