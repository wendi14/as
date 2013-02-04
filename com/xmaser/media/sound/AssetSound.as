package  com.xmaser.media.sound	
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class AssetSound 
	{
		private var soundChannel:SoundChannel;
		private var sound:Sound;
		private var _loop:Boolean;
		private var _soundPostion:Number;
		private var _volume:Number;
		public var name:String;
		public function AssetSound(S:*,loop:Boolean=false,volume:Number=1) 
		{
			this._volume = volume;
			
			//name = getQualifiedClassName(S);
			sound= new S();
			soundChannel = sound.play();
			if (!soundChannel)
			{
				return;
			}
			var tclone:SoundTransform = soundChannel.soundTransform;
			tclone.volume = volume;
			soundChannel.soundTransform = tclone;
			
			_loop = loop;
			
			soundChannel.addEventListener(Event.SOUND_COMPLETE, __SOUND_COMPLETE);
			
			mute(SoundManager.getIns().isMute);
			
		}
		private function __SOUND_COMPLETE(e:Event):void 
		{
			
			var tclone:SoundTransform = soundChannel.soundTransform; 
			
			soundChannel.removeEventListener(Event.SOUND_COMPLETE, __SOUND_COMPLETE);
			if (_loop==false)
			{
				
				SoundManager.getIns().removeSound(this);
				return;
			}
			soundChannel = sound.play(100);
			soundChannel.soundTransform = tclone;
			soundChannel.addEventListener(Event.SOUND_COMPLETE, __SOUND_COMPLETE);
		}
		public function destroy():void
		{
			if (soundChannel)
			{
				soundChannel.stop();
				soundChannel.removeEventListener(Event.SOUND_COMPLETE, __SOUND_COMPLETE);
			}
			name = null;
			sound = null;
			soundChannel = null;
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
		
		public function mute(boolean:Boolean):void 
		{
			var volume:Number=this._volume;
			var tclone:SoundTransform;
			if (soundChannel)
			{
				tclone = soundChannel.soundTransform;
				
			}
			if (tclone)
			{
				if (boolean) 
				{
					volume =0
				}
				tclone.volume = volume;
				soundChannel.soundTransform = tclone;
			}
		}
		
	}

}