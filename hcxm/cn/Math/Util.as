package hcxm.cn.Math
{
	public class Util
	{
		public function Util()
		{
		}
		
		/**
		 * 把arr 中的重复的元素删除，只保留一个，最后返回arr 不制作副本
		 * */
		public static function KeepOne(arr:Array):Array {
			for (var i = 0; i<arr.length; i++) {
				for (var j = i+1; j<arr.length; j++) {
					if (arr[i] == arr[j]) {
						arr.splice(j, 1);
					}
				}
			}
			return arr;
		}
	}
}