package hcxm.cn.net {
	
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	
	import hcxm.cn.event.Event_;

	
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class Remoting extends EventDispatcher {
		public static const ERROR:String="error";
		private var nc:NetConnection=new NetConnection();
		private var url
		private var method
		private var par:Array
		public function Remoting(url,method,par:Array=null) {
			
			this.url=url
			this.method=method
			if (par) {
				this.par=new Array()
				this.par=par;
			}
			init()
		}
		public function load(method,par:Array=null):void
		{
			this.method=method
			if (par) {
				this.par=new Array()
				this.par=par;
			}
			init()
		}
		private function init():void
		{
			nc.client = nc;
			nc.objectEncoding = ObjectEncoding.AMF3;
			nc.connect(url);
			nc.addEventListener(NetStatusEvent.NET_STATUS,NET_STATUS)
			if (par) {
				//nc.call(method, new Responder(success, fault), par);
				var arr = [method, new Responder(success, fault)];
				for (var i:int = 0; i < par.length; i++) {
					arr.push(par[i])
				}
				nc.call.apply(null, arr)
			}else {
				nc.call(method, new Responder(success,fault));
			}
		}
		private function success(e):void {
			
			/*
			for( var i:String in e["serverInfo"] ) trace( "key : " + i + ", value : " + e["serverInfo"][ i ] );
			
			key : initialData, value : 1,应用程序,2,卡通动画,3,互动教学,4,手机游戏,5,PC游戏,6,草稿箱
			key : version, value : 1
			key : cursor, value : 1
			key : serviceName, value : PageAbleResult
			key : columnNames, value : cate,catename
			key : totalCount, value : 6
			key : id, value : 194f023707c46ba2679387432f2bdb5d
			*/
			var arr:Array=[]
			if(e is Boolean){
				arr=[e]
			}else if(e is Number){
				arr=[e]
			}else if(e==null)
			{
				arr=[null]
			}
			else{
			trace(e.message);
				for (var i:int = 0; i < e["serverInfo"]["totalCount"] ; i++) {
					var obj ={}
					for (var j:int = 0; j <e["serverInfo"]["columnNames"].length ; j++) {
						var label:String = e["serverInfo"]["columnNames"][j]
						var date = e["serverInfo"]["initialData"][i][j];
						obj[label] = date;
					}
					arr.push(obj)
				}
			}
			

			//for (var k:int = 0;k< 6; k++) {
				//for ( var jj:String in arr[k] ) trace( "key : " + jj + ", value : " + arr[k][jj] );
				//trace("----------------------------")
			//}
			dispatchEvent(new Event_(Event_.COMPLETE,arr,true))
			//nc.close()
		}
		private function NET_STATUS(e:NetStatusEvent):void
		{
			if(e.info.level=="error"){
				//Debug.traceObj(e.info)
				//nc.close()
				//init()
			}
		}
		private function fault(e):void {
			trace( "返回错误: "  );
			for ( var i:String in e ) trace( "key : " + i + ", value : " + e[ i ] );
			trace("===============================")
			if(e["code"]=="AMFPHP_AUTHENTICATE_ERROR")
			{
				dispatchEvent(new Event_(ERROR,"你的身份不是管理员!"))
			}else
			{
				dispatchEvent(new Event_(ERROR,e))
			}
		}
		private function initNet():void{
			
		}
		
	}
	
}
