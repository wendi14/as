package cn.hcxmflash.control.pageControl 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.text.TextField;
	import gs.TweenLite;
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class PageControlMc extends MovieClip
	{
		public static const DIRECTIO_HOR = "hor";
		public static const DIRECTIO_VER:String = "ver";
		
		private var _total=100;
		private var _perPage=14
		private var _totalPage;//总页数;
		private var mc_btn:MovieClip;
		
		private var btnW;
		private var oldMc_btnX;
		public var nowPage:int=1
		public function PageControlMc() 
		{
			init();
		}
		
		private function init():void
		{
			
			nowPage =1
			
			mc_btn = _mc_btn;
			
			oldMc_btnX = mc_btn.x;
			btn_next.addEventListener(MouseEvent.CLICK, __btn_nextCLICK);
			btn_prev.addEventListener(MouseEvent.CLICK, __btn_prevCLICK);
			
			btn_p.addEventListener(MouseEvent.CLICK, __btn_pCLICK);
			btn_n.addEventListener(MouseEvent.CLICK, __btn_nCLICK);
			
		}
		private var _nowP:int = 0;
		private var _started:Boolean=false;
		private function __btn_pCLICK(e:MouseEvent):void 
		{

			_nowP++;
			if (_nowP>0) 
			{
				_nowP=0
			}
			var xx = oldMc_btnX+_nowP * btnW
			
			//TweenLite.to(mc_btn, 0.2, { x: xx } )
			
		}
		
		private function __btn_nCLICK(e:MouseEvent):void 
		{
		
			_nowP--
			
			if (_nowP<=-_totalPage) 
			{
				_nowP=-_totalPage+1
			}
			var xx = oldMc_btnX+_nowP * btnW
			TweenLite.to(mc_btn, 0.2, { x: xx } );
		}
		public function start():void
		{
			if (_started) 
			{
				return;
			}
			nowPage = 1;
			_started = true;
			_totalPage = Math.ceil(_total / _perPage)
			
			initMc_btn();
		}
		
		public var direction:String = DIRECTIO_HOR;
		public function set total(v):void
		{
			_total = v;
			
		}
		public function get TotalPage():Number
		{
			return _totalPage;
		}
		/**
		 * 每页几个
		 */
		public function set perPage(v):void
		{
			_perPage = v;
			
		}	
		
		private function __btn_prevCLICK(e:MouseEvent):void 
		{
			nowPage--;
			if (nowPage<1) 
			{
				nowPage=1
			}else
			{
				send(nowPage+1)
			}
		}
		
		private function __btn_nextCLICK(e:MouseEvent):void 
		{
			nowPage++;
			if (nowPage>_totalPage) 
			{
				nowPage = _totalPage;
			}else
			{
				send(nowPage-1)
				
			}
		}
		//
		/**
		 * 生成数字按纽;
		 */
		protected function initMc_btn():void
		{
			
			for (var i:int = 0; i < _totalPage; i++) 
			{
				var bt:Btn = new Btn();
				bt.id = i + 1;
				bt.name = "b_" +( i+1);
				if (i==0) 
				{
					bt.selected = true;
				}
				bt.addEventListener(MouseEvent.CLICK, __btnCLICK);
				bt.filters=[new BlurFilter(0,0)]
				bt.text = i+1;
				mc_btn.addChild(bt);
				bt.x = i * (bt.width + 4);
				if (!btnW) 
				{
					btnW=(bt.width + 4);
				}
			}
		}
		/**
		 * 点击数字按纽后;
		 * @param	e
		 */
		private function __btnCLICK(e:MouseEvent):void 
		{
			var op=nowPage
			nowPage = e.currentTarget.id;
			send(op)
		}
		
		private function send(old):void
		{
			dispatchEvent(new Event("pageEvent", true, true))
			
			var b:Btn = mc_btn.getChildByName("b_" + nowPage) as Btn;
			b.selected = true;
			
			var bold:Btn = mc_btn.getChildByName("b_" + old) as Btn;
			bold.selected = false;
			
			if (b.id>bold.id) 
			{
					__btn_nCLICK(null)
			}else 
			{
			__btn_pCLICK(null)
			}
		}
		
		
		
	}

}