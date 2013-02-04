package  com.xmaser.media.sound
{
	import cn.hcxmflash.utils.Singleton;
	
	import flash.events.Event;
	import flash.media.SoundChannel;

	/**
	 * ...
	 * @author ...
	 */
	public class SoundManager extends Singleton
	{
		static private var soundChannel:SoundChannel;
		static private var sound:*;
		private var _sounds:Array;
		private var _isMute:Boolean;
		private var _soundNmu:int=0;
		static public var isMute:Boolean;
		
		public function SoundManager() 
		{
			_sounds = [];
		}
		public static function getIns():SoundManager
		{
			return Singleton.getIns(SoundManager);
		}
		
		/**
		 *   
		 * @param	S  资源类
		 * @param	loop 是否循环；
		 */
		public  function playSound(asset:Class, loop:Boolean=false,volume:Number=1,name:String=''):void
		{
			if (_isMute==false)
			{
				var na:String = "sound_" + _soundNmu;
				if (name != "")
				{
					na = name;
				}
				var assetSound:AssetSound = new AssetSound(asset, loop, volume);
				assetSound.name = na;
				_sounds[na] = assetSound;;
				_soundNmu++;
				assetSound = null;
				
			}
			
		}
		public function removeSoundByName(soundName:String):void
		{
			try
			{
				_sounds[soundName].destroy();
			}catch (e:Error)
			{
				trace( "e : " + e ,this);
				
			}
			delete _sounds[soundName];
			_sounds[soundName] = null;
		}
		
		public function removeSound(assetSound:AssetSound):void 
		{
			var na:String = assetSound .name;
			
			//trace( "removeSound : " + na);
			try 
			{
				assetSound.destroy();
			}catch (err:Error)
			{
				trace( "e : removeSound" + err ,this);
			}
			delete _sounds[na];
			//_sounds[na] = null;
			assetSound = null;
		}
		
		public function pauseSoundByName(soundName:String):void 
		{
			_sounds[soundName].pause();
			//_sounds[assetSound.name] = null;
		}
		public function resumeSoundByName(soundName:String):void
		{
			_sounds[soundName].resume();
		}
		
		public function mute(boolean:Boolean=true):void 
		{
			for each (var item:AssetSound in _sounds) 
			{
				if(item)item.mute(boolean);
			}
			_isMute = boolean;
		
		}
		
		public function get isMute():Boolean 
		{
			return _isMute;
		}
		
	}

}