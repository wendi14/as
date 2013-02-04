package  com.xmaser.game.frame.sound
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
		public static function playSound(S:*,loop:Boolean=false):void
		{
			sound= new S();
			soundChannel = sound.play();
			if (loop)
			{
				soundChannel.addEventListener(Event.SOUND_COMPLETE, __SOUND_COMPLETE);
			}
		}
		
		static private function __SOUND_COMPLETE(e:Event):void 
		{
			soundChannel = sound.play();
			soundChannel.addEventListener(Event.SOUND_COMPLETE, __SOUND_COMPLETE);
		}
		
	}

}