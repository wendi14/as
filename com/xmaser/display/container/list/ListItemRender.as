package  com.xmaser.display.container.list
{
	
	
	import cn.hcxmflash.container.render.asset_ListItemRender_disabled;
	import cn.hcxmflash.container.render.asset_ListItemRender_down;
	import cn.hcxmflash.container.render.asset_ListItemRender_normal;
	import cn.hcxmflash.container.render.asset_ListItemRender_over;
	import cn.hcxmflash.container.render.asset_ListItemRender_selected;

	import com.xmaser.display.component.butotn.ButtonComponent;
	import com.xmaser.display.component.skin.Skin_Button;
	import com.xmaser.display.container.render.ItemRender;
	
	
	/**
	 * ...
	 * @author 
	 */
	public class ListItemRender extends ItemRender
	{
		protected var _btn:ButtonComponent;
		
		public function ListItemRender() 
		{
			
		
		}
		override protected function drawUI():void 
		{
			_btn = new ButtonComponent();
			var sk:Skin_Button = new Skin_Button();
			sk.disabled = asset_ListItemRender_disabled;
			sk.normal = asset_ListItemRender_normal;
			sk.over = asset_ListItemRender_over;
			sk.down = asset_ListItemRender_down;
			sk.selected = asset_ListItemRender_selected;
			_btn.skinSkin = sk;
			
			addChild(_btn);
			
		}
		
		override protected function draw():void 
		{
			_btn.label = _data.toString();
			
			super.draw();
		}
		
		
	}

}