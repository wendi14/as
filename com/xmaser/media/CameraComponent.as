package com.xmaser.media 
{
	import com.xmaser.display.component.ComponentBasic;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.ActivityEvent;
	import flash.events.Event;
	import flash.media.Camera;
	import flash.media.Video;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class CameraComponent extends ComponentBasic 
	{
		static public const POSITION_OK:String = "positionOk";
		private var _video:Video;
		private var _camera:Camera;
		private var _ww:Number=0;
		private var _hh:Number=0;
		private var _size2:Boolean;
		
		public function CameraComponent() 
		{
			
		}
		override protected function drawUI():void 
		{
			super.drawUI();
			_video = new Video()
			
		}
		override protected function init():void 
		{
			super.init();
			_camera = Camera.getCamera();
			if (_camera)
			{
				_camera.addEventListener(ActivityEvent.ACTIVITY,__ACTIVITY)
				if (_ww > 0)
				{
					_video.width = _ww
					_video.height = _hh;
				}else 
				{
					_video.width = _camera.width;
					_video.height = _camera.height;
				}
				if (_size2)
				{
					_video.width = _camera.width*2
					_video.height = _camera.height*2;
				}
				_camera.setMode(_video.width, _video.height,15);
				addChild(_video);
				_video.attachCamera(_camera);
				
				dispatchEvent(new Event(POSITION_OK))
			}
			
		}
		public function setSize(ww:Number,hh:Number):void
		{
			_hh = hh;
			_ww = ww;
			if (_camera)
			{
				_camera.setMode(ww, hh, 15);
				_video.width = _camera.width;
				_video.height = _camera.height;
			}
		}
		public function doubleSize():void
		{
			_size2 = true;
		}
		private function __ACTIVITY(e:ActivityEvent):void 
		{
			//trace(_camera.width)
		}
		override public function destory():void 
		{
			super.destory();
			
			if (_video)
			{
				if (_camera)
				{
				
				}
				removeChild(_video);
			}
		}
		public function get bitmap():Bitmap 
		{ 
			if (!_camera)
			{
				return null;;
			}
			var bd:BitmapData = new BitmapData(_video.width, _video.height);
			
			bd.draw(this);
			var bp:Bitmap=new Bitmap(bd,"auto",true)
			
			return bp; 
		}
	}

}