package cn.hcxmflash.color
{
	import flash.display.MovieClip;
	import flash.filters.ColorMatrixFilter;
	
	/**
	* ...
	* @author Default
	*/

	public class ColorAdjust {
	
    private  var _matrix : Array = [
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

	private var _seDiao:*
	private var _lianDu:*
	private var mc:MovieClip
	
	public static function  seDiao (nColor:Number):ColorMatrixFilter {
		 var colorStr : String = nColor.toString (16);
		// trace( "colorStr : " + colorStr );
		 var nRed : Number = hextoargb(nColor).red
         var nGreen : Number = hextoargb(nColor).green
         var nBlue : Number = hextoargb(nColor).blue
		/**
		 * var nRed : Number = Number ("0x" + colorStr.slice (0, 2));
            var nGreen : Number = Number ("0x" + colorStr.slice (2, 4));
            var nBlue : Number = Number ("0x" + colorStr.slice (4, 6));

		 */
		 //trace( "hextoargb(nColor) : " + hextoargb(nColor).green );
		 var ColorMaxtix:Array = [
		 1, 0, 0, 0, nRed,
		 0, 1, 0, 0, nGreen,
		 0, 0, 1, 0, nBlue,
		 0, 0, 0, 1, 0];
		
		
		 return new ColorMatrixFilter(ColorMaxtix)
	}
	/**
	 *
	 * @param	offset -255~255
	 * @return
	 */
	public static function  lianDu (offset:Number):ColorMatrixFilter {
		//trace( "offset : " + offset );
		 var Brightness_Matrix : Array = [
		 1, 0, 0, 0, offset,
		 0, 1, 0, 0, offset,
		 0, 0, 1, 0, offset,
		 0, 0, 0, 1, 0];
		
	
		return new ColorMatrixFilter (Brightness_Matrix)
	}
	
	public static function  getHuiDu ():ColorMatrixFilter {
		
			var Grayscale_Matrix : Array = [
			_nRed, _nGreen, _nBlue, 0, 0,
			_nRed, _nGreen, _nBlue, 0, 0,
			_nRed, _nGreen, _nBlue, 0, 0,
			0, 0, 0, 1, 0];
			
			return new ColorMatrixFilter (Grayscale_Matrix)
		
		
	}
	/**
	 *
	 * @param	nLevel 0~3
	 * @return
	 */
	public static function  baoHeDu (nLevel:Number):ColorMatrixFilter {
		var srcRa : Number = (1 - nLevel) * _nRed + nLevel;
		var srcGa : Number = (1 - nLevel) * _nGreen;
		var srcBa : Number = (1 - nLevel) * _nBlue;
		var srcRb : Number = (1 - nLevel) * _nRed;
		var srcGb : Number = (1 - nLevel) * _nGreen + nLevel;
		var srcBb : Number = (1 - nLevel) * _nBlue;
		var srcRc : Number = (1 - nLevel) * _nRed;
		var srcGc : Number = (1 - nLevel) * _nGreen;
		var srcBc : Number = (1 - nLevel) * _nBlue + nLevel;
		var Saturation_Matrix : Array = [
		srcRa, srcGa, srcBa, 0, 0,
		srcRb, srcGb, srcBb, 0, 0,
		srcRc, srcGc, srcBc, 0, 0,
		0, 0, 0, 1, 0];
		
		
		return new ColorMatrixFilter (Saturation_Matrix);
	}
	/**
	 *
	 * @param	nLevel 0~1
	 * @return
	 */
	public static function  duiBiDu(nLevel:Number):ColorMatrixFilter {
		var Scale : Number = nLevel * 11;
        var Offset : Number = 63.5 - (nLevel * 698.5);
        var Contrast_Matrix : Array = [Scale, 0, 0, 0, Offset, 0, Scale, 0, 0, Offset, 0, 0, Scale, 0, Offset, 0, 0, 0, 1, 0];
		

			return new ColorMatrixFilter (Contrast_Matrix)
	}
	public static function  fanXian(yes:Boolean) :ColorMatrixFilter{
		var Invert_Matrix : Array
		if (yes) {
			Invert_Matrix  = [ - 1, 0, 0, 0, 255, 0, - 1, 0, 0, 255, 0, 0, - 1, 0, 255, 0, 0, 0, 1, 0];
			
		}
		return new ColorMatrixFilter (Invert_Matrix)
	}
	/**
	 * 十六进转为化argb
	 * @param	val
	 */
	public static function hextoargb (val : Number):Object
	{
		var col:Object = {
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
	public static function argbtohex(a:Number, r:Number, g:Number, b:Number):uint
	{
		return (a<<24 | r<<16 | g<<8 | b)
	}
	public static function showColor() :Array{
		var arr:Array=[]
		for (var i :int= 0; i<=255; i += 51) {
			for (var j :int= 0; j<=255; j += 51) {
				for (var k:int = 0; k <= 255; k += 51) {
					//trace(argbtohex(255,i,j,k))
					arr.push(argbtohex(255,i,j,k))
				}
			}
		}
		return arr;
	}
}
}