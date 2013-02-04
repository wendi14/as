package hcxm.fms
{
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.text.TextField;
	
	import hcxm.fms.events.StatusEventW;
	
	[Event(name="ok",type="hcxm.fms.events.StatusEventW")]
	[Event(name="fail",type="hcxm.fms.events.StatusEventW")]
	[Event(name="reject",type="hcxm.fms.events.StatusEventW")]
	
	public class FmsConnect extends EventDispatcher
	{
		public static const OtherURL:String="rtmp://112.handong.cc/wen/"
		private var _conn:NetConnection;
		private var _url;
		private var _info:Object;
		private var _showTi:Boolean=false
		private var _showMc
		var text:TextField
		var user
		var pa
		public function FmsConnect(rtmp:String='localhost',_showTi=null,uu=null,pp=null)
		{
		
			this._url=rtmp;
			
			this.user=uu
			this.pa=pp
			getInstan();
			if(_showTi)
			{
				text=new TextField()
				text.selectable=false;
				this._showTi=true;
				this._showMc=_showTi
				_showMc.addChild(text)
				
				text.text='正在连接服务器.................'
			}

		}
		private function getInstan():void
		{
			if(!_conn)
			{
				_conn=new NetConnection()
				_conn.connect(this.url,user,pa);
				_conn.addEventListener(NetStatusEvent.NET_STATUS,NET_STATUS)
			}			
			
		}
		private function NET_STATUS(e:NetStatusEvent):void
		{
			_info=e.info;
			switch (e.info.code) {
				case "NetConnection.Connect.Success":
					dispatchEvent(new StatusEventW(StatusEventW.OK))
					if(_showTi)
					{
						_showMc.addChild(text)
						text.text='连接服务器成功'
					}
				break;
				
				case "NetConnection.Connect.Failed":
					dispatchEvent(new StatusEventW(StatusEventW.FAIL))
					if(_showTi)
					{
						_showMc.addChild(text)
						text.text='连接服务器失败'
					}
				break;	
				
				case "NetConnection.Connect.Rejected":
					dispatchEvent(new StatusEventW(StatusEventW.REJECT))
					if(_showTi)
					{
						_showMc.addChild(text)
						text.text='连接服务器被拒绝'
					}
				break
			}
		}
		public function get url():String
		{
			return _url;
		}
		
		public function get conn():NetConnection
		{
			return _conn;
		}
		public function get info():Object
		{
			return _info;
		}
		public function set showTi(mc):void
		{
			_showTi=true;
			_showMc=mc
		}
	}
		
}