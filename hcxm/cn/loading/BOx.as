package hcxm.cn.loading
{
	import flash.display.BlendMode;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BOx extends Sprite
	{
		
		public function BOx() 
		{
			var sp:Sprite = this;

			var gr:Graphics = sp.graphics;
			gr.beginFill(0xffffff*(Math.random()*1000));
			
			gr.drawCircle(0, 0, int(Math.random() * 10));
			gr.endFill();
			this.ro = int(Math.random() * 360);
			this.speed=int(Math.random() * 20);
			//sp.filters = [new BlurFilter(16, 16, 2)];
			this.blendMode = BlendMode.ADD;
			this.cacheAsBitmap = true;
		}
		public var ro;
		public var speed;
		
		public var cenx=int(Math.random() *20);
		public var  ceny=int(Math.random() *20);
		
	}
	
}