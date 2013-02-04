package   cn.hcxmflash.color
{
	/**
	 * ...
	 * 比较颜色
	 * @author hcxmflash.cn
	 */
	public class ColorCompare 
	{
		
		public function ColorCompare() 
		{
			
		}
		
		public static function compare(c1:uint,c2:uint,min:Number=50):Boolean
		{
			var col1:Object = { };
			col1.alpha = (c1 >> 24) & 0xFF;
			col1.red = (c1 >> 16) & 0xFF;
			col1.green = (c1 >> 8) & 0xFF;
			col1.blue = c1 & 0xFF;
	
			//for ( var i:String in col1 ) trace( "key : " + i + ", value : " + col1[ i ] );
			
			var col2:Object = { };
			col2.alpha = (c2 >> 24) & 0xFF;
			col2.red = (c2 >> 16) & 0xFF;
			col2.green = (c2 >> 8) & 0xFF;
			col2.blue = c2 & 0xFF;
			//trace("2====================================")
			//for ( var i:String in col2 ) trace( "key : " + i + ", value : " + col2[ i ] );
			
			var total:Number = Math.abs(col1.red - col2.red) + Math.abs(col1.green - col2.green) + Math.abs(col1.blue-col2.blue);
			if (total <= min) return true;
			return false;
		}
		
	}

}