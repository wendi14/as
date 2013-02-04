package  cn.hcxmflash.game.sound	
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
		private var volume:Number;
		
		public function GSound(S:*,loop:Boolean=false,volume:Number=1) 
		{
			this.volume = volume;
			
			
			sound= new S();
			if (GSoundManager.isMute == false)
			{
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
			
		}
		private function __SOUND_COMPLETE(e:Event):void 
		{
			soundChannel.removeEventListener(Event.SOUND_COMPLETE, __SOUND_COMPLETE);
			
			soundChannel = sound.play();
			soundChannel.addEventListener(Event.SOUND_COMPLETE, __SOUND_COMPLETE);
		}
		public function pause():void
		{
			if (!soundChannel) 
			{
				return;
			}
			_soundPostion = soundChannel.position;
			soundChannel.stop()
		}
		public function resume():void
		{
			soundChannel = sound.play(_soundPostion);
			if (soundChannel)
			{
				var tclone:SoundTransform = soundChannel.soundTransform;
			tclone.volume = volume;
			soundChannel.soundTransform = tclone;
			}
			
			
			if (_loop)
			{
				soundChannel.addEventListener(Event.SOUND_COMPLETE, __SOUND_COMPLETE);
			}
		}
		
	}

}