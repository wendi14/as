package  hcxm.cn.loading 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PreLoading extends Sprite 
	{
		
		public function PreLoading() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE,init)
			
		}
		private var holdArr:Array=[]
		private function init(e=null):void
		{
			BOXSP = new Sprite()
			
			var d = (new dong())
			d.x = stage.stageWidth / 2
			d.y = stage.stageHeight / 2;
			BOXSP.addChild(d)
			
			this.addEventListener(Event.ENTER_FRAME, render)
			 
			bmd= new BitmapData(this.stage.stageWidth, stage.stageHeight,false,0);
			bmp = new Bitmap(bmd)
			addChild(bmp)
			ctm = new ColorTransform(.99, .92, .95);
			
			maxtrans = new Matrix();
			

		}	
		public function close():void
		{
			bmd=null;
			this.removeEventListener(Event.ENTER_FRAME, render)
			
		}
		var bmd:BitmapData
		var ctm:ColorTransform 
		private var bmp:Bitmap;
		
		private var maxtrans:Matrix;

		private var BOXSP:Sprite;
		private var bf = new BlurFilter(6, 6, 2);
		var ang1:int = 0;
		var dir = 1;
		private function render(e=null):void
		{
		
			var hu = ang1 / 180 * Math.PI;
			
			ang1+=1;
			
			if (ang1 >=360)
			{	
				ang1 = 0
				
				dir *=-1
			}
			var sxxx = Math.cos(hu) * dir;
			var syyy = Math.sin(hu) * dir;
			
			maxtrans.tx = sxxx/10;// Math.cos(hu) * dir;
		
			maxtrans.ty = sxxx/10; //Math.cos(hu) * dir;
			maxtrans.a =  1+sxxx/40;
	
			maxtrans.d=1+sxxx/40;
			bmd.draw(bmd, maxtrans, ctm, BlendMode.ALPHA);
			var bmd2:BitmapData = bmd.clone();
			bmd.draw(bmd2, maxtrans, ctm);
			bmd.draw(BOXSP, new Matrix());
			bmd.applyFilter(bmd,bmd.rect,new Point(),bf)
			
		}
		
	}
	
}