package  com.xmaser.display.component.scroll
{
	import cn.hcxmflash.assets.hscroll_b_disabled;
	import cn.hcxmflash.assets.hscroll_b_normal;
	import cn.hcxmflash.assets.hscroll_b_over;
	import cn.hcxmflash.assets.hscroll_b_selected;
	import cn.hcxmflash.assets.hscroll_bar;
	import cn.hcxmflash.assets.hscroll_dragbar_disabled;
	import cn.hcxmflash.assets.hscroll_dragbar_normal;
	import cn.hcxmflash.assets.hscroll_dragbar_over;
	import cn.hcxmflash.assets.hscroll_dragbar_selected;
	import com.xmaser.display.component.skin.Skin_Button;
	import flash.events.Event;
	
	import cn.hcxmflash.event.Event_;
	import com.xmaser.display.component.butotn.ButtonComponent
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	import gs.TweenLite;
	
	/**
	 * ...
	 * @author 
	 */
	public class HScroll extends Scroll
	{
		static public const DRAGING_BAR_START:String = "dragingBarStart";
		static public const DRAGING_BAR_END:String = "dragingBarEnd";
		
		
		public function HScroll() 
		{
			
		}
		protected function drawUpDownButtonSKin():Skin_Button
		{
			var sk:Skin_Button = new Skin_Button(hscroll_b_normal, hscroll_b_over, hscroll_b_normal, hscroll_b_selected, hscroll_b_disabled);
			return sk;
		}
		protected function drawBarBg():void
		{
			_barBg = new hscroll_bar();
		}
		override protected function drawUI():void 
		{
			
			drawBarBg();
			addChild(_barBg);
			
			var sk:Skin_Button = drawUpDownButtonSKin();
			//var clarr:Array=[getDefinitionByName("cn.hcxmflash.assets.hscroll_b_normal"),getDefinitionByName("cn.hcxmflash.assets.hscroll_b_over"),getDefinitionByName("cn.hcxmflash.assets.hscroll_b_selected"),getDefinitionByName("cn.hcxmflash.assets.hscroll_b_disabled")]
			_upButton = new ButtonComponent()
			_upButton.skinSkin = sk;
			addChild(_upButton);
			
			_upButton.addEventListener(MouseEvent.CLICK, __upButtonCLICK);
			
			_downButton = new ButtonComponent();
			_downButton.skinSkin = sk;
			addChild(_downButton);
			_downButton.addEventListener(MouseEvent.CLICK, __downButtonCLICK);
			
			//var dragArr:Array=[getDefinitionByName("cn.hcxmflash.assets.hscroll_dragbar_normal"),getDefinitionByName("cn.hcxmflash.assets.hscroll_dragbar_over"),getDefinitionByName("cn.hcxmflash.assets.hscroll_dragbar_selected"),getDefinitionByName("cn.hcxmflash.assets.hscroll_dragbar_disabled")]
			_dragBarButton = new ButtonComponent();
			_dragBarButton.skinSkin=drawDragBarSkin()
			_dragBarButton.addEventListener(MouseEvent.MOUSE_DOWN,__dragBarButtonMOUSE_DOWN)
			addChild(_dragBarButton);
			
			_dragBarButton.y = _barBg.height / 2 - _dragBarButton.height / 2;
		}
		
		protected function drawDragBarSkin():Skin_Button 
		{
			return new Skin_Button(hscroll_dragbar_normal, hscroll_dragbar_over, hscroll_dragbar_normal, hscroll_dragbar_selected, hscroll_dragbar_disabled)
			
			
		}
		override protected function reDraw():void 
		{
			
			super.reDraw();
			
			_barBg.width = maskWidth;;
		}
		override protected function dragTarget(per:Number):void 
		{
			if (_target)
			{
				super.dragTarget(per);
			}else 
			{
				if (per >1) per = 1;
				if (per < 0) per = 0;
				
				
			}
		}
		override protected function __dragBarButtonMOUSE_DOWN(e:MouseEvent):void 
		{
			var rec:Rectangle = new Rectangle(_barBg.x, _dragBarButton.y, _barBg.width - _dragBarButton.width, 0);
			_dragBarButton.startDrag(false, rec);
			stage.addEventListener(MouseEvent.MOUSE_UP,__dragBarButtonMOUSE_UP)
			stage.addEventListener(MouseEvent.MOUSE_MOVE, __stageMOUSE_MOVE);
			
			dispatchEvent(new Event(HScroll.DRAGING_BAR_START))
			
		}
		override protected function __dragBarButtonMOUSE_UP(e:MouseEvent):void 
		{
			super.__dragBarButtonMOUSE_UP(e);
			dispatchEvent(new Event(HScroll.DRAGING_BAR_END));
		}

		
		override protected function calOnMouseMovePer():Number 
		{
			var per:Number = (_dragBarButton.x - _barBg.x) / (_barBg.width - _dragBarButton.width);
			
			return per;
		}
		override public function get dragBarPostionPercent():Number 
		{
			return super.dragBarPostionPercent;
		}
		
		override public function set dragBarPostionPercent(value:Number):void 
		{
			_dragBarPostionPercent = value;
			
			var xx:Number = _barBg.x + value * (_barBg.width - _dragBarButton.width);
			TweenLite.to(_dragBarButton, 0.2, {x: xx} );
			dragTarget(value)
		}
		override public function get width():Number 
		{
			return super.width;
		}
		
		override public function set width(value:Number):void 
		{
			_barBg.width = value;
		}
	}

}