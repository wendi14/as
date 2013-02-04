package hcxm.cn.media{
	import flash.utils.ByteArray;
	import hcxm.cn.media.event.FlvEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	/**
	* ...
	* @author Default
	*/
	public class FlvPlayer extends EventDispatcher {
		private var _url:String;
		private var video:Video;
		private var _netstr:NetStream;
		private var _client:NetsClient
		private var mc:Sprite
		private var _width:Number;
		private var _height:Number
		private var _x:Number
		private var _y:Number
		private var _isPlaying:Boolean;
		public function FlvPlayer(mc:Sprite) {
			
			video = new Video();
			video.smoothing = true;
			this.mc = mc;
			mc.addChild (video)
			_client= new NetsClient()
			var con:NetConnection = new NetConnection ();
			con.connect (null);
			_netstr = new NetStream (con);
			_netstr.client =_client
			video.attachNetStream (_netstr);
			_netstr.addEventListener (NetStatusEvent.NET_STATUS, NET_STATUS)			
			
		}
		/**
		 * 播放
		 * @param	url
		 */
		public function play (url:String):void {
			_netstr.play (url);
		}
		public function playBytes(byte:ByteArray):void
		{
			_netstr.close();
			_netstr.play(null);
			_netstr.appendBytes(byte);
		
		}
		/**
		 * 停止
		 */
		public function stop ():void {
			_netstr.close ();
			isPlaying = false;
		}
		/**
		 * 暂停
		 */
		public function pause ():void {
			_netstr.pause ();
			isPlaying = false;
		}
		/**
		 * 继续
		 */
		public function resume ():void {
			_netstr.resume ();
			isPlaying = true;
		}
		/**
		 *快进
		 * @param	n
		 */
		public function seek(n:Number):void
		{
			_netstr.seek(n);
			
		}
		private function NET_STATUS (e:NetStatusEvent):void {
			//trace ( "e : " + e.info);
			//for( var i:String in e.info ) trace( "key : " + i + ", value : " + e.info[ i ] );
			switch (e.info.code) {
				case "NetStream.Buffer.Full":
					//trace ("播放已开始" + _client.width);	
					setWidthAndHeight ();
					isPlaying = true;
				break;
				case "NetStream.Play.Stop":
					trace("播放停止")
					isPlaying = false;
					removeEventListeners();
				break;
			}
		}
		
		private function removeEventListeners():void 
		{
			mc.removeEventListener(Event.ENTER_FRAME, ENTER_FRAME);
			
		}
		
		private function addEventListeners():void 
		{
			mc.addEventListener(Event.ENTER_FRAME,ENTER_FRAME)

		}			
		private function setWidthAndHeight ():void {
			
			if (!_width)
			{
				_width = _client.width;
				
			}
			if (!_height) 
			{
				_height = _client.height;
			}
			video.width = _width
			video.height =_height
			addEventListeners()
		}
		
		
		
		private function ENTER_FRAME(e:Event):void 
		{
			//trace( "e : " + e );
			//trace(_netstr.time+"---"+_client.duration)
			dispatchEvent(new FlvEvent( FlvEvent.PROGRE,true,{now:_netstr.time,total:_client.duration}))
		}
		public function set progress(value:Number):void 
		{
			seek(_client.duration * value);
		}
		
		public function get height():Number 
		{
			return _height;
		}
		
		public function set height(value:Number):void 
		{
			_height = value;
			video.height = _height;
		}
		
		public function get width():Number 
		{
			return _width;
		}
		
		public function set width(value:Number):void 
		{
			_width = value;
			video.width = value;
		}
		
		public function get y():Number 
		{
			return _y;
		}
		
		public function set y(value:Number):void 
		{
			_y = value;
			video.y = _y;
		}
		
		public function get x():Number 
		{
			return _x;
		}
		
		public function set x(value:Number):void 
		{
			_x = value;
			video.x = _x;
		}
		
		public function get isPlaying():Boolean 
		{
			return _isPlaying;
		}
		
		public function set isPlaying(value:Boolean):void 
		{
			_isPlaying = value;
		}
		
	}
	
}
