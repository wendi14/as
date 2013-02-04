package  cn.hcxmflash.utils
{
	import flash.display.DisplayObject;
	import flash.filters.GlowFilter;
	/**
	 * ...
	 * @author 
	 */
	public class EffectUtils 
	{
		
		public function EffectUtils() 
		{
			
		}
		public static function miaoBian(mc:DisplayObject,color:uint=0x000000,miaoBianColor:uint=0xffffff):void
		{
		
			var txtGF2:GlowFilter=new GlowFilter(miaoBianColor,1,3,3,16);
			var myGF_arr:Array = mc.filters;
			myGF_arr.push(txtGF2);
			mc.filters=myGF_arr;
		}
	}

}