/**
 * 制作相册的时候，请扩展此类;
 * */
package hcxm.cn.media.ImgCase
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.utils.Timer;
	
	import hcxm.cn.media.ImageProgressBar;
	import hcxm.cn.media.ImagerLoader;
	import hcxm.cn.media.ImgCase.control.IImageControl;

	public class ImgCase1 extends Sprite
	{
		private var _Controler:IImageControl
		public function ImgCase1(arr:Array=null)
		{
			if(arr)show(arr)
			
		}
		/***
		 * param	arr	图片数组
		 * */
		 
		public function show(arr:Array)
		{
			total=arr.length;
			for(var i:int=arr.length-1;i>=0;i--)
			{
				var imgLo:ImagerLoader=new ImagerLoader(arr[i],false);
				imgLo.name="img"+i;
				if(i==0)
				{
					imgLo.startLoad();
					imgLo.addEventListener(ImagerLoader.LOAD_COMPLETE,_LOAD_COMPLETE)
				}else
				{
					imgLo.visible=false;
				}
				addChild(imgLo);
				imgLo.setProgressBar(new ImageProgressBar());
			}
			
			timer=new Timer(2000);
			timer.addEventListener(TimerEvent.TIMER,_TIMER);
			
		}
		//第一图片加载完后，才开始循环;
		private function _LOAD_COMPLETE(e):void
		{
			e.target.removeEventListener(ImagerLoader.LOAD_COMPLETE,_LOAD_COMPLETE);
			timer.start();
			if(_Controler)_Controler.setBtn(adminindex);
		}
		
		var timer:Timer
		
		var adminindex=0;
		public var total;
		
		var oldimg;
		var nowimg
		private function _TIMER(e:TimerEvent):void
		{
			oldimg=this.getChildByName("img"+adminindex);
			adminindex++;
		
			if(adminindex>=total)
			{
				adminindex=0;
			}
			
			
			nowimg=this.getChildByName("img"+adminindex);
			nowimg.addEventListener(ImagerLoader.LOAD_COMPLETE,_LOAD_COMPLETE)
			nowimg.startLoad();
			fadeOut(oldimg)
			fadeIn(nowimg);
			timer.stop();
			oldimg=nowimg;
			
		}
		var fadeInBlurNum=20
		//进入
		private function fadeIn(img:ImagerLoader):void
		{
			img.alpha=0;
			img.visible=true;
			img.filters=[new BlurFilter(fadeInBlurNum,fadeInBlurNum)];
			img.addEventListener(Event.ENTER_FRAME,_fainENTER_FRAME)
		}
		private function _fainENTER_FRAME(e):void
		{
			fadeInBlurNum--
			e.target.filters=[new BlurFilter(fadeInBlurNum,fadeInBlurNum)];
			e.target.alpha+=0.05
			if(fadeInBlurNum<=0)
			{
				e.target.removeEventListener(Event.ENTER_FRAME,_fainENTER_FRAME);
				fadeInBlurNum=20
			}
			
		}
		//退出
		var fadeOutBlurNum=0
		private function fadeOut(img:ImagerLoader):void
		{
			img.filters=[new BlurFilter(fadeOutBlurNum,fadeOutBlurNum)];
			img.addEventListener(Event.ENTER_FRAME,_faoutENTER_FRAME)		
		}
		private function _faoutENTER_FRAME(e):void
		{	
			fadeOutBlurNum++;
			e.target.filters=[new BlurFilter(fadeOutBlurNum,fadeOutBlurNum)];
			e.target.alpha-=0.05
			if(fadeOutBlurNum>=20)
			{
				e.target.removeEventListener(Event.ENTER_FRAME,_faoutENTER_FRAME);
				fadeOutBlurNum=0;
			}
		}
		
		/**
		 * 添加控制器
		 * param	obj	控制组件的实例
		 * param	x	控制组件的x坐标
		 * */
		public function addControler(obj:IImageControl,x=null,y=null):void
		{
			obj.imageSource=this;
			addChild(obj as Sprite);
			Sprite(obj).y=y;
			Sprite(obj).x=x;
			_Controler=obj;
		}
		/**
		 * 跳转到 n;
		 * param	n	显示第n张图片
		 * */
		public function goto(n:int):void
		{
			timer.stop();
			adminindex=n;
			nowimg=this.getChildByName("img"+adminindex);
			
			if(adminindex>=total)
			{
				adminindex=0;
			}
			if(!oldimg)
			{
				oldimg=this.getChildByName("img0");
				
			}
			
			nowimg.addEventListener(ImagerLoader.LOAD_COMPLETE,_LOAD_COMPLETE)
			nowimg.startLoad();
			fadeOut(oldimg)
			fadeIn(nowimg);
			oldimg=nowimg;
			
		}
	}
}