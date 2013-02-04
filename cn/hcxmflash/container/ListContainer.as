package  cn.hcxmflash.container
{
	import cn.hcxmflash.container.ContainerBasic;
	import cn.hcxmflash.container.render.ItemRender;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author 
	 */
	public class ListContainer extends  ContainerBasic 
	{
		
		public function ListContainer() 
		{
			
		}
		override protected function rePostion():void 
		{
			for (var i:int = 0; i < _oldItemArr.length; i++) 
			{
				var item:ItemRender = _oldItemArr[i];
				item.y = i * item.height;
			}
			super.rePostion();
		}
		
	}

}