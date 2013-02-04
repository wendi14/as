package  cn.hcxmflash.component
{
	import cn.hcxmflash.component.ButtonComponent;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author 
	 */
	public class ToogleButtonComponent extends Sprite 
	{
		private var _b1:ButtonComponent;
		private var _b2:ButtonComponent;
		
		public function ToogleButtonComponent(b1:ButtonComponent,b2:ButtonComponent) 
		{
			_b1 = b1;
			_b2 = b2;
			_b2.visible = false;
			_b1.addEventListener(MouseEvent.CLICK, __c1);
			_b2.addEventListener(MouseEvent.CLICK, __c2);
			
			addChild(_b1); addChild(_b2);
		}
		public function setState(s:int):void
		{
			if (s == 0)
			{
				_b2.visible = false;
				_b1.visible = true;
			}else 
			{
				_b1.visible = false;
				_b2.visible = true;
			}
		}
		private function __c1(e:MouseEvent):void 
		{
			_b1.visible = false;
			_b2.visible = true;
		}
		
		private function __c2(e:MouseEvent):void 
		{
			_b2.visible = false;
			_b1.visible = true;
		}
		
	}

}