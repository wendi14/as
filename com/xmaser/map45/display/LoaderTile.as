package com.xmaser.map45.display 
{
	import com.xmaser.map45.model.ItemVO;
	import com.xmaser.net.URLAssetsManager;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	/**
	 * ...
	 * @author 
	 */
	public class LoaderTile extends  GraphicTile 
	{
		private var _item:ItemVO;
		
		public function LoaderTile(size:Number,item:ItemVO) 
		{
			super(size,null,item.overlapX,item.overlapY);
			this._item = item;
			//trace("_item: " + _item);
			/*graphics.clear()
			graphics.beginFill( 0xff0000);
			graphics.lineStyle(0, 0, 0.4);
			graphics.moveTo( -size , 0);
			graphics.lineTo(0, -size / 2) ;
			graphics.lineTo(size, 0) ;
			graphics.lineTo(0, size/2) ;
			graphics.lineTo( -size, 0) ;
			graphics.endFill();*/
			
			//this.alpha=0.2
			if (item.x == 0 && item.y == 0)
			{
				
				
			}URLAssetsManager.getIns().load(item.url, __c2, true, true);
			
			return
			var u:Loader = new Loader();
			_graphic = u;
			u.contentLoaderInfo.addEventListener(Event.COMPLETE, __c);
			//showBackGround();
			u.load(new URLRequest(item.url));
			addChild(_graphic)
		}
		
		private function __c2(i:*):void 
		{
			//trace("__c2: " + __c2);
			//trace(this.name,item.y, item.x);
			//var  b:Bitmap = new Bitmap(i.bitmap.bitmapData)
			addChild(i.bitmap);
				_graphic = i.bitmap;
			updateGraphicPosition();
			
		}
		
		private function __c(e:Event):void 
		{
			
			
			updateGraphicPosition();
			
		}
		
		public function get item():ItemVO 
		{
			return _item;
		}
		
	}

}