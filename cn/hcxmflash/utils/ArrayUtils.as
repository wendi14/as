package cn.hcxmflash.utils 
{
	/**
	 * ...
	 * @author 小火柴
	 */
	public class ArrayUtils
	{
		static private var _res:Array;
		private static var _checkStr:String;
		public function ArrayUtils() 
		{
			
		}
		public static function filterNoValue(ar:Array):Array
		{
			var res:Array=[]
			for (var i:int = 0; i < ar.length; i++) 
			{
				var item:* = ar[i];
				if (item)
				{
					res.push(item)
				}
			}
			return res;
		}
		public static function filterKeepOne(ar:Array):Array
		{
			_res = [];
			
			var a:Array = ar.filter(filterKeepOneFunc);
			return a;
		}
		
		static private function filterKeepOneFunc(item:*, index:int, array:Array):Boolean 
		{
			var d:int = _res.indexOf(item);
			if (d == -1)
			{
				_res.push(item);
				return true;
			}
			return false;
		}
		
		 public static function filterKeepOneInObj(inda:Array, string:String) : Array
        {
            _res = [];
            _checkStr = string;
            var _loc_3:* = inda.filter(filterKeepOneFunc2);
            return _loc_3;
        }// end function

        private static function filterKeepOneFunc2(item:*, index:int, array:Array) : Boolean
        {
            var _loc_4:* = _res.indexOf(item[_checkStr]);
            if (_loc_4 == -1)
            {
                _res.push(item[_checkStr]);
                return true;
            }
            return false;
        }// end function
		
		
		//
		/**
		 * a-b之间的不重复随机数
		 * @param	a	包含a
		 * @param	b	包含b
		 * @return
		 */
		public static function randNum(a:Number, b:Number):Array 
		{
			var toal:int = b-a+1;
			var arr:Array = [];
			for (var i:int = 0; i < toal; i++) {
				arr[i] = b-i;
			}
			for (var j:int = 0; j<toal; j++) {
				var temp:* = arr[j];
				var nn :Number= int(Math.random()*j);
				arr[j] = arr[nn];
				arr[nn] = temp;
			}
			//trace("最后生成"+arr)
			return arr;
		}
		public static function randArray(source_ar:Array):Array
		{
			
			var source_ar2:Array = source_ar.concat();
			var source_ar2_:Array = []
			var total:int=0
			for (var i:int = 0; i <source_ar.length ; i++) 
			{
				
				for (var j:int = 0; j <source_ar[i].length ; j++) 
				{
					source_ar2_.push (source_ar[i][j]);
					total++
				}
			}
			var ar:Array = randNum(0, total-1);
			//trace("ar : " + ar.length);
			for (var i2:int = 0; i2< source_ar2_.length; i2++) 
			{
				ar[i2] = source_ar2_[ar[i2]];
			}
			
		
			var ar2:Array=[]
			var k:int = 0;
			
			var res:Array=[]
			for (var i3:int = 0; i3 <source_ar.length ; i3++) 
			{
				res[i3] = [];
				for (var j2:int = 0; j2 <source_ar[i3].length ; j2++) 
				{
					res[i3][j2] = ar[k];
					k++;
				}
			}
			
			
			return res;
		}
	}

}