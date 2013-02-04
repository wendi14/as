package  cn.hcxmflash.container.render
{
	import cn.hcxmflash.component.ButtonComponent;
	import cn.hcxmflash.container.render.ItemRender;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author 
	 */
	public class ListItemRender extends ItemRender 
	{
		private var _btn:ButtonComponent;
		
		public function ListItemRender() 
		{
			var ar:Array = [
			getDefinitionByName("cn.hcxmflash.container.render.ListItemRender_normal"),
			getDefinitionByName("cn.hcxmflash.container.render.ListItemRender_over"),
			getDefinitionByName("cn.hcxmflash.container.render.ListItemRender_selected"),
			getDefinitionByName("cn.hcxmflash.container.render.ListItemRender_disabled"),
			]
			_btn = new ButtonComponent(ar,4);
			addChild(_btn);
		}
		override protected function draw():void 
		{
			_btn.label = _data.label;
			
			super.draw();
		}
		
	}

}