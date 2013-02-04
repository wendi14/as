package hcxm.cn.controls.text
{
	import com.gskinner.motion.GTween;
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import hcxm.cn.string.StringW;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;

	public class GungDongText extends UIComponent
	{
		public function GungDongText()
		{
			super();
		}
		
		var tex:TextField
		var di:Shape
		override protected function createChildren():void
		{
			super.createChildren();
			
			createDi()
			tex=new TextField()
			addChild(tex);
			tex.text="这是一个滚动的文字组件...";
			if(_text)tex.text=_text;
			tex.selectable=false;
			tex.x=this.width;
			tex.addEventListener(MouseEvent.MOUSE_OVER,_MOUSE_OVER)
			tex.addEventListener(MouseEvent.MOUSE_OUT,_MOUSE_OUT)
			hcxm.cn.string.StringW.addMiaoBianEffect(tex,0xffffff);
			//playA()
			tex.autoSize="left";
			ma=new Shape();
			ma.graphics.beginFill(0x000000,.5)
			ma.graphics.drawRect(0,0,this.width,this.height);
			ma.graphics.endFill();
			addChild(ma)
			
			tex.mask=ma;
		}
		var ma:Shape
		var _text
		public function set text(v):void
		{
			_text=v
		}
		public var gtw:GTween
		private function playA():void
		{
			if(gtw)
			{
				gtw.pause();
				gtw.play();
				return;
			}
			gtw=new GTween(tex,this.width/40,{x:-tex.textWidth},{repeat:-1})
			gtw.addEventListener(Event.COMPLETE,_gtwCOMPLETE)
		}

		override protected function measure():void
		{
			super.measure();

		}
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight)
			trace("updateDisplayList"+unscaledWidth)
			trace("this.width"+this.width)
			createDi()
			tex.x=unscaledWidth;
			ma.graphics.clear();
			ma.graphics.beginFill(0x000000,0.5)
			ma.graphics.drawRect(0,0,unscaledWidth,this.height);
			ma.graphics.endFill();
			tex.mask=ma;
			
			playA()
		}
		private function _MOUSE_OVER(e:MouseEvent):void
		{
			gtw.pause()
		} 
		private function _MOUSE_OUT(e:MouseEvent):void
		{
			gtw.play();
		} 		
		private function _gtwCOMPLETE(e):void
		{
			trace(e)
		}
		private function createDi():void
		{
			if(di)removeChild(di);
			di=new Shape()
			addChild(di);
			di.graphics.beginFill(0xffffff,0.2);
			di.graphics.drawRect(0,0,this.width,this.height);
			di.graphics.endFill();
		}

	}
}