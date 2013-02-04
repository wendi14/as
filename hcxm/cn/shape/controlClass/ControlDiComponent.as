package hcxm.cn.shape.controlClass
{
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;

	public class ControlDiComponent extends UIComponent
	{
		public function ControlDiComponent()
		{
			super();
			this.addEventListener(MouseEvent.MOUSE_OVER,_MOUSE_OVER)
			this.addEventListener(MouseEvent.MOUSE_OUT,_MOUSE_OUT)
		}
		public var tools:Function;
		
		private function _MOUSE_OVER(e:MouseEvent):void
		{
			if(tools)
			{
				tools.call(this)
			}
		}
		private function _MOUSE_OUT(e:MouseEvent):void
		{
			
		}
	}
}