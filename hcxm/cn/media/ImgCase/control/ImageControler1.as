package hcxm.cn.media.ImgCase.control
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ImageControler1 extends Sprite implements IImageControl
	{
		private var _source;
		private var _total
		public function ImageControler1()
		{
		}
		public function set imageSource(va):void
		{
			_source=va;
			_total=_source.total;
			create()
		}
		public function get imageSource()
		{
			return _source;
		}
		public function goto(n):void
		{
			_source.goto(n);
			this.setBtn(n);
		}
		public function setBtn(n:int):void
		{
			for(var i:int=0;i<_total;i++)
			{
				var btn=this.getChildByName("btn"+i);
				btn.gotoAndStop(1);
			}
			var btn1=this.getChildByName("btn"+n);
			btn1.gotoAndStop(2);
		}
		private function create():void
		{
			for(var i:int=0;i<_total;i++)
			{
				var btn:MovieClip=new btn_img()
				btn.id=i;
				addChild(btn)
				btn.name="btn"+i;
				btn.x=btn.width*i;
				btn.addEventListener(MouseEvent.CLICK,_btnClick);
				btn.tt.text=i+1;
				btn.mouseChildren=false;
			}
		}
		private function _btnClick(e:MouseEvent):void
		{
			
			goto(e.target.id);
		}

	}
}