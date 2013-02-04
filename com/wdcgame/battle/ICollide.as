package com.wdcgame.battle 
{
	
	/**
	 * ...
	 * @author wdc
	 */
	public interface ICollide 
	{
		function getCollidedWidth(b:ICollide):Boolean;
		function collided(b:ICollide):void;
		function canCollide():Boolean;
		
		function canCollideNull():Boolean;

	}
	
}