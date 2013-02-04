package  {
	import flash.display.Sprite;
	
	/**
	* ...
	* @编写者： wendi(小火柴)
						http://www.hcxm.cn
	*/
	public class NewClass extends Sprite {
		/**
		 * 10020002.23  读为 壹仟零贰万零贰元贰角叁分
　　1020         读为 壹仟零贰拾元整。
　　100000       读为 拾万元整
　　0.13         读为 壹角叁分
		 */
		var num:Number=865465
		var arr:Array = [];
		var MathStr=["","十","百","千","万","十","百","千","亿","十","百","千"," 万"]
		//var MathStr=["","十","百","千","万","","","","亿","","","","","亿亿"]
		public function NewClass() {
			var str:String = num.toString();			
			arr = str.split("");
			
			var stra = "";
			var len = arr.length;
			for (var i:int = 0; i <len; i++) {
				stra += arr[i] + MathStr[len-1-i];
			}
			trace( "stra : " + stra );
		}
		
	}
	
}