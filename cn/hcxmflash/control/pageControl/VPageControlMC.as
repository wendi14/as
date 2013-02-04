package cn.hcxmflash.control.pageControl 
{
	import cn.hcxmflash.control.pageControl.PageControlMc;
	import flash.events.Event;
	import flash.display.SimpleButton
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.display.MovieClip;
	import gs.easing.Circ;
	import gs.easing.Elastic;
	import gs.TweenLite;
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class VPageControlMC extends PageControlMc
	{
		private var oldMc_btnY
		private var btnH;
		public function VPageControlMC() 
		{
			mc_btn = _mc_btn;
			oldMc_btnY = mc_btn.y;
			btn_next.addEventListener(MouseEvent.CLICK, __btn_nextCLICK);
			btn_prev.addEventListener(MouseEvent.CLICK, __btn_prevCLICK);
			
			btn_p.addEventListener(MouseEvent.CLICK, __btn_pCLICK);
			btn_n.addEventListener(MouseEvent.CLICK, __btn_nCLICK)
		}
		override protected function initMc_btn():void 
		{
			super.initMc_btn()
			for (var i:int = 0; i < totalPage; i++) 
			{
				var bt:Btn = _mc_btn.getChildByName( "b_" +( i + 1)) as Btn;
				bt.x = 0;
				bt.y = i * (bt.height + 4);
				if (!btnH) 
				{
					btnH = bt.height + 4;
				}
			}
		}
		override protected function __btn_pCLICK(e:MouseEvent):void 
		{
			super.__btn_pCLICK(e);
			
			
			var xx = oldMc_btnY+nowP*6 * btnH
			TweenLite.to(mc_btn, 0.4, { y: xx,ease:Elastic.easeOut} )
		}
		override protected function __btn_nCLICK(e:MouseEvent):void 
		{
			super.__btn_nCLICK(e); 
			var xx = oldMc_btnY+nowP*6 * btnH
			TweenLite.to(mc_btn, 0.4, { y: xx ,ease:Elastic.easeOut} );
		}
	}

}