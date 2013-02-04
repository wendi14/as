package cn.hcxmflash.utils 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author 小火柴
	 */
	public class DragManager
	{
		
		public function DragManager() 
		{
			
		}
		
		private static var _ins:DragManager;
		
		public static function getIns():DragManager
		{
			if (_ins == null)
			{
				_ins=new DragManager()
			}
			return _ins;
		}
	}

}