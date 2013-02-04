package  cn.hcxmflash.utils 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class SpriteUtils 
	{
		
		public function SpriteUtils() 
		{
			
		}
		/**
		 * 水平　居中对齐
		 * @param	mcarr
		 * @param	mcParent	mcarr中的对像的上级
		 * @param	width	指定要对齐的宽度，如果为０就取mcParent的width
		 */
		public static function respostionXMcToCenter(mcarr:Array, mcParent:DisplayObjectContainer,width:int=0):void
		{
			var tempMc:Sprite = new Sprite()
			for (var i:int = 0; i < mcarr.length; i++) 
			{
				var item:* = mcarr[i];
				tempMc.addChild(item);
			}
			if (width == 0)
			{
				width=mcParent.width
			}
			
			tempMc.x = width / 2 - tempMc.width / 2;
			
			for (var j:int = 0; j < mcarr.length; j++) 
			{
				var item2:* = mcarr[j];
				var po:Point = item2.localToGlobal(new Point())
				//trace( "po : " + po );
				var po2:Point = mcParent.globalToLocal(po);
				item2.x = po2.x; item2.y = po2.y;
				mcParent.addChild(item2);
			}
		}
		public static function respostionYMcToCenter(mcarr:Array, mcParent:DisplayObjectContainer,height:int=0):void
		{
			var tempMc:Sprite = new Sprite()
			for (var i:int = 0; i < mcarr.length; i++) 
			{
				var item:* = mcarr[i];
				tempMc.addChild(item);
			}
			if (height == 0)
			{
				height=mcParent.height
			}
			
			tempMc.y = height / 2 - tempMc.height / 2;
			
			for (var j:int = 0; j < mcarr.length; j++) 
			{
				var item2:* = mcarr[j];
				var po:Point = item2.localToGlobal(new Point())
				//trace( "po : " + po );
				var po2:Point = mcParent.globalToLocal(po);
				item2.x = po2.x; item2.y = po2.y;
				mcParent.addChild(item2);
			}
		}		
	}

}