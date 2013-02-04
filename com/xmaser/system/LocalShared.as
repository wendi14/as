package com.xmaser.system 
{
	import cn.hcxmflash.utils.Singleton;
	import flash.net.SharedObject;
	
	/**
	 * ...
	 * @author 
	 */
	public class LocalShared extends Singleton 
	{
		private var _local:SharedObject;
		private var _name:String;
		private var _isInit:Boolean;
		
		public function LocalShared() 
		{
			
		}
		public function init(name:String,localPath:String=null,secure:Boolean=false):void
		{
			this._name = name;
			_isInit = true;
			try 
			{
				_local = SharedObject.getLocal(name, localPath, secure);
			}catch (err:Error)
			{
				trace( "err : " + err );
				
			}
		}
		public static function getIns():LocalShared { return Singleton.getIns(LocalShared); }
		
		
		public function save(name:String,value:Object):void
		{
			if (!_isInit)
			{
				throw new Error("_local 没有初化始，请先调用 init方法");
				return;
			}
			if (!_local) 
			{
				trace( "err : 获取本地缓存失败"  );
				return;
			}
			_local.data[name] = value;
			_local.flush();
		}
		public function getData(name:String):Object
		{
			if (!_local) return null;
			return _local.data[name];
		}
		public function clear():void
		{
			if (_local) 
			{
				_local.clear();
			}
		}
		
		public function get local():SharedObject 
		{
			return _local;
		}
		
		
	}

}