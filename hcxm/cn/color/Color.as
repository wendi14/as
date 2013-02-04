package hcxm.cn.color
{
	import flash.filters.ColorMatrixFilter;
	
	public class Color
	{    
		private static  var _matrix : Array = [
		1, 0, 0, 0, 0, //r-g-b-a-off
		0, 1, 0, 0, 0,
		0, 0, 1, 0, 0,
		0, 0, 0, 1, 0];
		//_nRed,_nGreen,_nBlue是计算机图形颜色亮度的常量
	    private static var _nRed : Number = 0.3086;
	    private static var _nGreen : Number = 0.6094;
	    private static var _nBlue : Number = 0.0820;
		
		/**
		 * 色调 seDiao(number)
		 * 亮度 lianDu(number)取值范围为：-255~255
		 *灰度 huiDu(true)布尔值，true为灰度，false则反之。
		 * 饱和度 baoHeDu(number)一般范围为：0~3为宜
		 * 对比度 duiBiDu(number)取值范围为：0~1
		 * 反相 fanXian(true)布尔值，true为反相，false则反之。
		 * hextoargb(number) 十六进制转为argb 返回一个object包含red,green,blue,alpha
		 */
		public function Color()
		{
		}
		public static function  AdjustHuiDu (yes:Boolean):ColorMatrixFilter {
			var Grayscale_Matrix : Array =_matrix;
			if (yes) {
				 Grayscale_Matrix  = [
				_nRed, _nGreen, _nBlue, 0, 0,
				_nRed, _nGreen, _nBlue, 0, 0,
				_nRed, _nGreen, _nBlue, 0, 0,
				0, 0, 0, 1, 0];	
			}
			return new ColorMatrixFilter (Grayscale_Matrix)
		}
		//十六进制转argb;
		public static function hextoargb (val : Number)
		{
			var col = {
			};
			col.alpha = (val >> 24) & 0xFF;
			col.red = (val >> 16) & 0xFF;
			col.green = (val >> 8) & 0xFF;
			col.blue = val & 0xFF;
			return col;
		}
		/**
		 * ARGB转换为十六进制值
		 * @param	a
		 * @param	r
		 * @param	g
		 * @param	b
		 */
		public static function argbtohex(a:Number, r:Number, g:Number, b:Number)
		{
			return (a<<24 | r<<16 | g<<8 | b)
		}
		public static function showColor() {
			var arr:Array=[]
			for (var i = 0; i<=255; i += 51) {
				for (var j = 0; j<=255; j += 51) {
					for (var k = 0; k <= 255; k += 51) {
						//trace(argbtohex(255,i,j,k))
						arr.push(argbtohex(255,i,j,k))
					}
				}
			}
			return arr;
		}		
		
	}
}