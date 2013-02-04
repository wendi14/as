package hcxm.cn.util{
	import flash.utils.ByteArray;
	public class CodeURL {
	public static var arr:Array = [
	{a:"a",b:"z"},
	{a:"b", b:"y" },
	{a:"c", b:"x" },
	{a:"d", b:"w" },
	{a:"e", b:"v" },
	{a:"f", b:"u" },
	{a:"g", b:"t" },
	{a:"h", b:"s" },
	{a:"i", b:"r" },
	{a:"j", b:"q" },
	{a:"k", b:"p" },
	{a:"l", b:"o" },
	{a:"m", b:"n" },
	{a:"n", b:"m" },
	{a:"o", b:"l" },
	{a:"p", b:"k" },
	{a:"q", b:"j" },
	{a:"r", b:"i" },
	{a:"s", b:"h" },
	{a:"t", b:"g" },
	{a:"u", b:"f" },
	{a:"v", b:"e" },
	{a:"w", b:"d" },
	{a:"x", b:"c" },
	{a:"y", b:"b" },
	{a:"z", b:"a" },
	{a:".", b:"^" },
	{a:"/", b:"$" },
	{a:":",b:"%"}
	]
	public function CodeURL() {
		
	}
	public static function encode(str:String):String {
		var res:String ;
		var strarr:Array = str.split("");
		for (var i:int = 0; i < strarr.length; i++) {
			var ss :String = strarr[i];
			for (var j:int = 0; j <arr.length ; j++) {
				if (arr[j].a == ss.toLowerCase()) {
			
					var pa:RegExp = new RegExp("[" + ss + "]", "g");
					var b = arr[j].b
					strarr[i] = strarr[i].replace(pa, b);
					trace( "\"[\"+ss+\"]\" : " + "["+ss+"]" +"==="+strarr[i]);
					
					break;
				}
				
			}
			
		}
		//trace( "strarr : " + strarr );
		res = strarr.join("");
		trace( "res : " + res );		
		return res	
	}
	public static function decode(str:String):String {
		var res:String ;
		var strarr:Array = str.split("");
		for (var i:int = 0; i < strarr.length; i++) {
			var ss :String = strarr[i];
			for (var j:int = 0; j <arr.length ; j++) {
				if (arr[j].b == ss.toLowerCase()) {			
					var pa:RegExp = new RegExp("[" + ss + "]", "g");
					var b = arr[j].a
					strarr[i] = strarr[i].replace(pa, b);
					//trace( "\"[\"+ss+\"]\" : " + "["+ss+"]" +"==="+strarr[i]);					
					break;
				}
				
			}
			
		}
		//trace( "strarr : " + strarr );
		res = strarr.join("");
		trace( "res : " + res );		
		return res	
	}
	
}
}