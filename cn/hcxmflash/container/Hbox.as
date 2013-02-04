package cn.hcxmflash.container 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import gs.TweenLite
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class Hbox extends Sprite
	{
		private var _hGap:int;
		protected var _width:Number;
		protected var _height:Number;
		protected var totalWidth:Number = 0;
		protected var totalHeight:Number = 0;
		protected var _reDuration:Number = 0.2;
		/**
		 * 设置过渡变换时间
		 */
		public static const ALIGN_TOP:String = "alignTop";
		public static const ALIGN_CENTER:String = "alignCenter";
		private var _align:String = ALIGN_TOP;

		public function Hbox(width:Number=0,height:Number=0) 
		{
			_width = width;
			_height = height;
			if (stage) 
			{
				init()
			}else 
			{
				addEventListener(Event.ADDED_TO_STAGE, __ADDED_TO_STAGE);
			}
			
		}
		
		private function __ADDED_TO_STAGE(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, __ADDED_TO_STAGE);
			init()
		}
		
		private function init():void
		{
			//stage.addEventListener(Event.RESIZE, __stageRESIZE);
		
			if (_width==0&&_height==0) 
			{
				_width = stage.stageWidth;
				_height = stage.stageHeight;
			}
			
		}
		
		protected function __stageRESIZE(e:Event):void 
		{
			_width = stage.stageWidth;
			_height = stage.stageHeight;
			totalWidth = 0;
			totalHeight = 0;
			for (var i:int = 0; i < this.numChildren; i++) 
			{
				
				rePosition(this.getChildAt(i) as DisplayObject);
			}
		}
		override public function addChild(child:DisplayObject):DisplayObject 
		{
			//rePosition(child);
			child.addEventListener(Event.ADDED_TO_STAGE, __childADDED);
			return super.addChild(child);
			
			
		}
		protected function __childADDED(e:Event):void 
		{
			rePosition(e.target as DisplayObject);
			
		}
		public function update():void
		{
			totalWidth = 0;
			totalHeight = 0;
			for (var i:int = 0; i < this.numChildren; i++) 
			{
				
				rePosition(this.getChildAt(i) as DisplayObject);
			}
		}
		protected function rePosition(child:DisplayObject):void
		{
			
			
			//trace("totalWidth : " + totalWidth);trace("totalHeight : " + totalHeight);
			if (totalWidth+child.width >_width) 
			{
				
				totalWidth = 0;
				totalHeight += child.height;
			}
			child.x = totalWidth;
			//trace("totalWidth : " + totalWidth);
			//TweenLite.to(child, _reDuration, {x:totalWidth,y:totalHeight,overwrite:0} );
			child.y = totalHeight;
			
			totalWidth += (child.width + _hGap);
			for (var i:int = 0; i<this.numChildren; i++) 
			{
				var item:DisplayObject = this.getChildAt(i);
				if (_align == ALIGN_CENTER)
				{
					item.y = this.height / 2 - item.height / 2;
					//trace( "item.height : " + item.height,item );
					//trace( "this.height  : " + this.height);
				}
				
			}
		}
		
		public function get hGap():int 
		{
			return _hGap;
		}
		
		public function set hGap(value:int):void 
		{
			_hGap = value;
		}
		
		public function get align():String 
		{
			return _align;
		}
		
		public function set align(value:String):void 
		{
			_align = value;
		}
		
		
	}

}