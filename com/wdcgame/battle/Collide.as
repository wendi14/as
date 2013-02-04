package com.wdcgame.battle
{
	
	
	/**
	 *2012-12-6下午2:09:30
	 * ...
	 * @author  wdc
	 */
	public class Collide
	{
		public function Collide()
		{
			
		}
		public static function check(ar1:Vector.<ICollide>,ar2:Vector.<ICollide>):void
		{
			for (var i:int = 0; i < ar1.length; i++) 
			{
				var a1:ICollide = ar1[i];
				var c:Boolean = false;
				for (var j:int = 0; j < ar2.length; j++) 
				{
					var a2:ICollide = ar2[j];
					if (a2.canCollide() == false) continue;
					if (a1.getCollidedWidth(a2))
					{
						a1.collided(a2);
						a2.collided(a1);
						c = true;
					} 
					
				}
				if (c==false&&a1.canCollideNull()) 
				{
					a1.collided(null);
				}
				
			}
			
			
			remove(ar1);
			remove(ar2);
		}
		
		static private function remove(ar1:Vector.<ICollide>):void 
		{
			if (!ar1) return;
			for (var i:int = 0; i < ar1.length; i++) 
			{
				var item:ICollide = ar1[i];
				if (item.canCollide()==false) 
				{
					ar1.splice(i, 1);
				}
			}
		}
		
	}
}