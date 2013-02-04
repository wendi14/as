package  hcxm.cn.media {
	
	/**
	* ...
	* @author Default
	*/
	public class NetsClient {
		public var width:Number
		public var height:Number
		public var duration:Number
		public var framerate:Number
		public function NetsClient() {
			
		}
		public function onMetaData(info:Object):void {
			//trace ("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
			width = info.width;
			height = info.height;
			duration = info.duration
			framerate = info.framerate;
		}
		public function onCuePoint(info:Object):void {
			//trace("cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type);
		}
		public function onPlayStatus (info:Object):void {
			//trace("-----------------------------------")
			//for( var i:String in info ) trace( "key : " + i + ", value : " + info[ i ] );
			//trace("-----------------------------------")
		}
		
		
	
	}
	
}
