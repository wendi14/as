package  cn.hcxmflash.component
{
	import cn.hcxmflash.component.Scroll;
	import cn.hcxmflash.event.Event_;
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
		
		public function HScroll() 
		{
			
		}
		override protected function drawUI():void 
		{
			var barBgCla:Class = getDefinitionByName("cn.hcxmflash.assets.hscroll_bar") as Class;
			_barBg = new barBgCla();
			addChild(_barBg);
			
			var clarr:Array=[getDefinitionByName("cn.hcxmflash.assets.hscroll_b_normal"),getDefinitionByName("cn.hcxmflash.assets.hscroll_b_over"),getDefinitionByName("cn.hcxmflash.assets.hscroll_b_selected"),getDefinitionByName("cn.hcxmflash.assets.hscroll_b_disabled")]
			_upButton = new ButtonComponent(clarr, 4);
			addChild(_upButton);
			_upButton.addEventListener(MouseEvent.CLICK, __upButtonCLICK);
			
			_downButton = new ButtonComponent(clarr, 4);
			addChild(_downButton);
			_downButton.addEventListener(MouseEvent.CLICK, __downButtonCLICK);
			
			var dragArr:Array=[getDefinitionByName("cn.hcxmflash.assets.hscroll_dragbar_normal"),getDefinitionByName("cn.hcxmflash.assets.hscroll_dragbar_over"),getDefinitionByName("cn.hcxmflash.assets.hscroll_dragbar_selected"),getDefinitionByName("cn.hcxmflash.assets.hscroll_dragbar_disabled")]
			_dragBarButton = new ButtonComponent(dragArr, 4);
			_dragBarButton.addEventListener(MouseEvent.MOUSE_DOWN,__dragBarButtonMOUSE_DOWN)
			addChild(_dragBarButton);
			
			_dragBarButton.y = _barBg.height / 2 - _dragBarButton.height / 2;
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
	}

}