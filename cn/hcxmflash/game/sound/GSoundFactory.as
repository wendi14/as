package  cn.hcxmflash.game.sound
{
	import flash.events.Event;
	import flash.media.SoundChannel;
	/**
	 * ...
	 * @author ...
	 */
	public class GSoundFactory
	{
		static private var soundChannel:SoundChannel;
		static private var sound:*;
		
		public function GSoundFactory() 
		{
			
		}
		/**
		 *   
		 * @param	S  资源类
		 * @param	loop 是否循环；
		 */
		public static function playSound(S:*,loop:Boolean=false,startTime:Number=0):SoundChannel
		{
			sound= new S();
			soundChannel = sound.play(startTime);
			if (loop)
			{
				soundChannel.addEventListener(Event.SOUND_COMPLETE, __SOUND_COMPLETE);
			}
			return soundChannel;
		}
		
		static private function __SOUND_COMPLETE(e:Event):void 
		{
			soundChannel = sound.play();
			soundChannel.addEventListener(Event.SOUND_COMPLETE, __SOUND_COMPLETE);
		}
		
	}

}