package com.wdcgame.battle 
{
	
	/**
	 * ...
	 * @author wdc
	 */
	public interface IBattleUnit 
	{
		function hurt(n:Number):void
		function attack():void
		function destroy():void
		function set isDie(value:Boolean):void
		function get isDie():Boolean;		
		function set life(value:Number):void
		function get life():Number;
		
		function get power():Number;
		function set power(value:Number):void;
		
	}
	
	
}