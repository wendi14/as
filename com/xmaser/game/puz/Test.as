package com.xmaser.game.puz 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class Test extends Sprite 
	{
		
		public function Test() 
		{
			var g:GridPUZ = new GridPUZ(null);
			addChild(g);
			
			var ar:Array =
			
			[
			
				[1,1,1,2,2,3],
				[1, 1, 1, 2, 2, 3],
				[1, 1, 1, 2, 2, 3],
				[1, 1, 1, 2, 2, 3],
				[1, 1, 1, 2, 2, 3],
				[1,1,1,2,2,3]
			]
			g.createGrid(ar)
		}
		
	}

}