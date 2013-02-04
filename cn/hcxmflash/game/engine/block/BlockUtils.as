package  cn.hcxmflash.game.engine.block
{
	import cn.hcxmflash.game.comm.component.Grid;
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class BlockUtils 
	{
		
		public function BlockUtils() 
		{
			
		}
		public static function checkIsEmpty(ar:Array,x:int,y:int,isXY:Boolean=true,emptyValue:int=0):Array
		{
			
			var res:Array=[]
			var len:int;
			if (isXY)
			{
				//x
				
				len = ar[y].length;
			}else 
			{
				len = ar.length;
			}
			for (var i:int = 0; i < len; i++) 
			{
				
				var item:Grid;
				if (isXY) 
				{
					item = ar[y][i];
				}else 
				{
					item = ar[i][x];
				}
				if (item.type != emptyValue)
				{
					
					res.push(item);
				}
			}
			return res;
		}
		
		public static function goToLeft(ar:Array,grid:Grid,emptyValue:int=0,...args):Object
		{
			var startX:int = grid.xx;
			var ok:Boolean = true;
			var res:Array = [];
			if (!args)
			{
				args=[emptyValue]
			}else 
			{
				args=args.concat(emptyValue)
			}
			for (var i:int = startX-1; i>=0; i--) 
			{
				var item:Grid = ar[grid.yy][i];
				var tms:Boolean = false;
				for (var j:int = 0; j < args.length; j++) 
				{
					if (item.type == args[j])
					{
						res.push(item);
						tms = true;
					}
				}
				
				if (tms == false)
				{
					ok = false;
				}
			}
			return {ok:ok,data:res};
		}
		public static function goToRight(ar:Array,grid:Grid,emptyValue:int=0,...args):Object
		{
			var startX:int = grid.xx;
			var ok:Boolean = true;
			var res:Array = [];
			if (!args)
			{
				args=[emptyValue]
			}else 
			{
				args=args.concat(emptyValue)
			}
			for (var i:int = startX+1; i<ar[grid.yy].length; i++) 
			{
				var item:Grid = ar[grid.yy][i];
				
				var tms:Boolean = false;
				for (var j:int = 0; j < args.length; j++) 
				{
					if (item.type == args[j])
					{
						res.push(item);
						tms = true;
					}
				}
				
				if (tms == false)
				{
					ok = false;
				}
			}
			return {ok:ok,data:res};
		}		
		public static function goToTop(ar:Array,grid:Grid,emptyValue:int=0,...args):Object
		{
			var startY:int = grid.yy;
			var ok:Boolean = true;
			var res:Array = [];
			if (!args)
			{
				args=[emptyValue]
			}else 
			{
				args=args.concat(emptyValue)
			}
			for (var i:int = startY-1; i>=0; i--) 
			{
				var item:Grid = ar[i][grid.xx];
				
				
				var tms:Boolean = false;
				for (var j:int = 0; j < args.length; j++) 
				{
					if (item.type == args[j])
					{
						res.push(item);
						tms = true;
					}
				}
				
				if (tms == false)
				{
					ok = false;
				}
			}
			return {ok:ok,data:res};
		}
		public static function goToBottom(ar:Array,grid:Grid,emptyValue:int=0,...args):Object
		{
			var startY:int = grid.yy;
			var ok:Boolean = true;
			var res:Array = [];
			if (!args)
			{
				args=[emptyValue]
			}else 
			{
				args=args.concat(emptyValue)
			}
			for (var i:int = startY+1; i<ar.length; i++) 
			{
				var item:Grid = ar[i][grid.xx];
				
				var tms:Boolean = false;
				for (var j:int = 0; j < args.length; j++) 
				{
					if (item.type == args[j])
					{
						res.push(item);
						tms = true;
					}
				}
				
				if (tms == false)
				{
					ok = false;
				}
			}
			return {ok:ok,data:res};
		}
		public static function checkRound(ar:Array,grid:Grid,emptyValue:int=0,...args):Object
		{
			
			
			var res:Object = { }
			var ok:Boolean = false;
			var data:Array=[];
			if (!args)
			{
				args=[emptyValue]
			}else 
			{
				args=args.concat(emptyValue)
			}
			//left 
			var item:Grid ;
			var xx:int; var yy:int;
			
			xx = grid.xx - 1; yy = grid.yy;
			if (xx >= 0)
			{
				data = data.concat(_add1(ar, args, xx, yy)) 
				
			}
			//right
			xx = grid.xx + 1;
			if (xx < ar[yy].length)
			{
				data = data.concat(_add1(ar, args, xx, yy)) 
			}
			//top
			xx = grid.xx; yy = grid.yy - 1;
			if (yy >= 0)
			{
				data = data.concat(_add1(ar, args, xx, yy))
			}
			//down
			yy = grid.yy + 1;
			if (yy < ar.length)
			{
				data = data.concat(_add1(ar, args, xx, yy))
			}
			if (data.length > 0) ok = true;
			return { ok:ok, data:data };
		}
		private static function _add1(ar:Array,args:Array,xx:int,yy:int):Array
		{
			var res:Array=[]
			var item:Grid = ar[yy][xx];
			//trace( "item : " + item );
			var bo:Boolean = false;
			for (var j:int = 0; j < args.length; j++) 
				{
					if (item.type == args[j])
					{
						bo = true;
						break;
					}
				}
				if (!bo)
				{
					res.push(item);
				}
			return res;
		}
	}

}