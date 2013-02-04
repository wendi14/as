package com.xmaser.pmvc 
{
	import flash.utils.getQualifiedClassName;
	
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class PMediator extends Mediator
	{
		
		public function PMediator(viewComponent:Object=null) 
		{
			
			var mName:String = flash.utils.getQualifiedClassName(this);
			trace( "mName : " + mName );
			super(mName, viewComponent);
			
		}
		
	}

}