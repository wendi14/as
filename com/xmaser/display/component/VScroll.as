package  com.xmaser.display.component
{
	

	import com.xmaser.display.component.scroll.Scroll;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author 
	 */
	public class VScroll extends Scroll
	{
		
		public function VScroll() 
		{
			
		}
		/*override protected function drawUI():void 
		{
			var barBgCla:Class = getDefinitionByName("cn.hcxmflash.assets.scroll_bar") as Class;
			_barBg = new barBgCla();
			addChild(_barBg);
			
			var clarr:Array=[getDefinitionByName("cn.hcxmflash.assets.scroll_b_normal"),getDefinitionByName("cn.hcxmflash.assets.scroll_b_over"),getDefinitionByName("cn.hcxmflash.assets.scroll_b_selected"),getDefinitionByName("cn.hcxmflash.assets.scroll_b_disabled")]
			_upButton = new ButtonComponent(clarr, 4);
			addChild(_upButton);
			_upButton.addEventListener(MouseEvent.CLICK, __upButtonCLICK);
			
			_downButton = new ButtonComponent(clarr, 4);
			addChild(_downButton);
			_downButton.addEventListener(MouseEvent.CLICK, __downButtonCLICK);
			
			var dragArr:Array=[getDefinitionByName("cn.hcxmflash.assets.scroll_dragbar_normal"),getDefinitionByName("cn.hcxmflash.assets.scroll_dragbar_over"),getDefinitionByName("cn.hcxmflash.assets.scroll_dragbar_selected"),getDefinitionByName("cn.hcxmflash.assets.scroll_dragbar_disabled")]
			_dragBarButton = new ButtonComponent(dragArr, 4);
			_dragBarButton.addEventListener(MouseEvent.MOUSE_DOWN,__dragBarButtonMOUSE_DOWN)
			addChild(_dragBarButton);
		}*/
		
	}

}