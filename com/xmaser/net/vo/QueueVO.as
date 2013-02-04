package com.xmaser.net.vo 
{

	import cn.hcxmflash.vo.VoBasicFlash;
	import com.xmaser.net.interfaceClass.IQueueVO;
	
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class QueueVO extends VoBasicFlash implements IQueueVO 
	{
		private var _isReady:Boolean;
		private var _errorTotalNum:int;
		private var _callBackFunction:Function;
		private var _data:*;
		private var _isProcessing:Boolean;
		public function QueueVO() 
		{
			
		}
		
		/* INTERFACE proxy.IQueueVO */
		
		public function get isReady():Boolean 
		{
			return _isReady;
		}
		
		public function set isReady(value:Boolean):void 
		{
			_isReady = value;
		}
		
		public function get errorTotalNum():int 
		{
			return _errorTotalNum
		}
		
		public function set errorTotalNum(value:int):void 
		{
			_errorTotalNum = value;
		}
		public function set callBackFunction(value:Function):void
		{
			_callBackFunction = value;
		}
		public  function get callBackFunction():Function
		{
			return _callBackFunction;
		}
		public function set data(value:*):void
		{
			_data = value;
		}
		public  function get data():*
		{
			return _data;
		}
		public function get isProcessing():Boolean { return _isProcessing; }
		public function set isProcessing(value:Boolean):void 
		{
			_isProcessing = value;
		}
		public  function destory():void {
			_isReady = false;
			_errorTotalNum = 0
			_callBackFunction = null;
			_data = null;
			}
		
	}

}