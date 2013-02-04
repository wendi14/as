package com.xmaser.net.interfaceClass 
{
	
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public interface IQueueVO 
	{
		function get isReady():Boolean;
		function set isReady(value:Boolean):void;
		function get errorTotalNum():int;
		function set errorTotalNum(value:int):void;
		function set callBackFunction(value:Function):void;
		function get callBackFunction():Function;
		function set data(value:*):void;
		function get data():*;
		
		function destory():void;
		
		function get isProcessing():Boolean;
		function set isProcessing(value:Boolean):void;
		
		
	}
	
	
}