package hcxm.cn.controls {
	import fl.controls.TextArea;
	import fl.transitions.easing.Bounce;
	import fl.transitions.easing.Strong;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import hcxm.cn.event.Event_;
	import hcxm.cn.event.MouseEvent_;
	import hcxm.cn.mouse.PressRelease;
	import hcxm.cn.MyLoader;
	
	/**
	* ...
	* @编写者： wendi(小火柴)
						http://www.hcxm.cn
	*	可以在里面显示文字和媒体（图像）
	*/
	public class  Mypanel extends MovieClip{
		private var tt:TextArea
		private var isHtml:Boolean = false;
		private var _ww = 120;
		private var _hh = 20;
		var mc:Sprite
		private var pad = 5;//上下左右间隔
		//private var bg:MovieClip
		private var headMc:Head;
		var myload:MyLoader
		var bgg:MovieClip
		private var _contentX;
		private var _contentY;
		namespace wendi;
		wendi var guan:MovieClip;
		public function Mypanel() {
			bg.width = _ww;
			bg.height = _hh;
			
			headMc = new head();
			headMc.bg.width = _ww;
			guan.width = _ww;
			guan.height = headMc.height;
			
			bg.y = headMc.height;
			addChild(headMc);
			
			
			UIMethod()
			init()
		}
		
		private function init():void{
			headMc.addEventListener(MouseEvent.CLICK,minFunc)
		}
		
		private function minFunc(e):void {
			//e.target : [object minButton]
			//e.target : [object maxButton]
			//e.target : [object closeButton]
			var time=0.8
			switch(e.target.name) {
				
				case "minButton":
					//trace( "minButton : " + minButton );
					var tw:Tween = new Tween(bgg, "height", Strong.easeOut, bgg.height, 0, time, true);
					var tw2:Tween= new Tween(bg, "height", Strong.easeOut, bg.height, 0, time, true);
				break;
				case "maxButton":
					//trace( "maxButton : " + maxButton );
					var tw:Tween = new Tween(bgg, "height", Strong.easeOut, bgg.height, _hh, time, true);
					var tw2:Tween= new Tween(bg, "height", Strong.easeOut, bg.height, _hh, time, true);
				break;
				case "closeButton":
					//trace( "closeButton : " + closeButton );
					var pare:DisplayObjectContainer = this.parent;
					pare.removeChild(this)
				break;
			}
		}
		
		private function UIMethod():void{
			//
			headMc.dragIt(this)
		}
		
		/**
		 * 显示文本
		 * 可以显示了普通文本和Html文本
		 * @param	str	要被显示的文字
		 * @param	is_html		是否显示为Html
		 */
		public function addText(str:String, is_html:Boolean = true):void {
			isHtml = is_html;
			
			tt = new TextArea();
			addChild(tt)
			//tt.setStyle()
			tt.editable=false
			tt.width = _ww-2 - pad * 2;
			tt.height = _hh -4- pad
			tt.x = tt.y = pad;
			tt.y = headMc.height + 2;
			guan.width = _ww
			guan.height = _hh + headMc.height;
			headMc.newHeight =headMc.height;
			headMc.newWidth = headMc.width;
			
			var textf:TextFormat = new TextFormat()
			textf.size = 12;
			
			tt.setStyle("textFormat", textf);

			if (isHtml) {
				tt.htmlText = str;
			}else {
				tt.text = str;
				
			}
			//bgg = new BG();
			//addChild(bgg);
			//bgg.width = _ww;
			//bgg.height = _hh;
			//bgg.y = bg.y;
			//tt.mask = bgg;
			
		}
		/**(805855056
		 * 显示媒体310437863
		 * 像:图像。。。347930785
		 * @param	url 	媒体地址
		 */
		public function load(url:String) {
			mc = new Sprite();
			if (_contentX==null) {
				mc.x =  pad+2;
			}else {
				mc.x = pad +2+ _contentX;
			}
			
			if (_contentY==null) {
				mc.y = bg.y + 2;
			}else {
				mc.y = bg.y + 2 + _contentX;
			}
			
			addChild(mc);
			guan.width = width
			guan.height = height;
			myload = new MyLoader(url);
			mc.addChild(myload);
			myload.showTiao = true;
			myload.addEventListener(Event.COMPLETE, COMPLETEol);
		}
		
		private function COMPLETEol(e:Event_):void {
			var lo:MyLoader = e.target as MyLoader
			lo.visible = false;
			var tar1 = bg;
			var ow = bg.width;
			var _cx
			var _cy
			if (_contentX==null) {
				_cx=0
			}else{_cx=_contentX}
			if (_contentY==null) {
				_cy=0
			}else{_cy=_contentY}
			var nw = e.data.width +pad * 2+_cx*2+4;
			var oh = bg.height
			var nh = e.data.height +pad + 4 + _cy*2;


			headMc.newHeight = nh;
			headMc.newWidth = nw;
			
			var tww:Tween = new Tween(tar1, "width", Strong.easeOut, ow, nw, 1, true);
			var twh:Tween = new Tween(tar1, "height", Strong.easeOut, oh, nh, 1, true);
			var twh1:Tween = new Tween(guan, "height", Strong.easeOut, oh, nh + headMc.height, 1, true);
			var tww1:Tween = new Tween(guan, "width", Strong.easeOut, ow,nw, 1, true);
			var tww2:Tween = new Tween(headMc.bg, "width", Strong.easeOut, headMc.bg.width,nw, 1, true);
			//trace( "lo.width +pad * 2 : " + (lo.width +pad * 2) );
			tww.addEventListener(TweenEvent.MOTION_FINISH,MOTION_FINISH)
			
		}
		private function MOTION_FINISH(e:TweenEvent):void {
			myload.visible = true;
			myload.alpha = 0;
			var twa:Tween = new Tween(myload, "alpha", Strong.easeOut, 0, 1, 1, true);
		}
		
		override public function set width(value:Number):void {
			bg.width = value;
			_ww = value;
			headMc.bg.width = value;
		}
		override public function set height(value:Number):void {
			bg.height = value;
			_hh = value;
		}
		/**
		 * 设置标题
		 */
		public function set title(value):void {
			headMc.title = value;
		}
		/**
		 * 设置标题x
		 */
		public function set titleX(value):void {
			headMc.titleX = value;
		}
		/**
		 * 设置标题颜色
		 */
		public function set titleColor(value):void {
			headMc.titleColor=value
		}
		/**
		 * 设置标题为粗体
		 */
		public function set titleBold(value):void {
			headMc.titleBold = value;
		}
		/**
		 * 是否显示按纽
		 */
		public function set showTopButton(value):void {
			headMc.showBtn = true;
		}
		public function set contentX(value):void {
			_contentX = value;
		}
		public function set contentY(value):void {
			_contentY = value;
		}
	}
	
}
