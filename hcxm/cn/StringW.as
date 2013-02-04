package hcxm.cn {
	import flash.filters.GlowFilter;
	
	/**
	* ...
	* @author 小火柴(http://www.hcxmflash.cn)
	*/
	public class StringW {
		
		public function StringW() {
			
		}
	public static function addMiaoBianEffect(target):Void {
		var glow:GlowFilter = new GlowFilter(0x000000, 100, 2, 2, 4,1, false, false);
		var myarr:Array = target.filters;
		myarr.push(glow);
		target.filters = myarr;
	}
	}
	
}