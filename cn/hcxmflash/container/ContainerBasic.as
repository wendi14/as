package cn.hcxmflash.container
{
	import cn.hcxmflash.container.render.ItemRender;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import cn.hcxmflash.event.Event_

	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class ContainerBasic extends Sprite
	{
		static public const EVENT_RESPOSINT_COMPLETE:String = "eventResposintComplete";
		protected var _dataProvider:Array;
		protected var _oldItemArr:Array=[];
		private var _DGItemRender:Class;
		
		public function ContainerBasic(dgitem:Class) 
		{
			_DGItemRender=dgitem
		}
		public function set dataProvider(value:Array):void 
		{
			_dataProvider = value;
			draw()
		}
		
		protected function draw():void
		{
			clearOld()
			_oldItemArr=[]
			for (var i:int = 0; i < _dataProvider.length; i++) 
			{
				if (!_dataProvider[i]) 
				{
					continue;
				}
				var item:ItemRender = new _DGItemRender();
				item.addEventListener(MouseEvent.CLICK ,__itemClick);
				addChild(item)
				_oldItemArr.push(item);
				item.data = _dataProvider[i];
				
			}
		}
		protected function rePostion():void
		{
			dispatchEvent(new Event(EVENT_RESPOSINT_COMPLETE,true,true))
		}
		
		protected function __itemClick(e:Event):void 
		{
			//var da = e.__arguments[0];
			dispatchEvent(new Event_(Event_.ITEM_CLICK,e.currentTarget.data,true,true))
			
		}
		
		private function clearOld():void
		{
			for (var i:int = 0; i < _oldItemArr.length; i++) 
			{
				removeChild(_oldItemArr[i]);
			}
		}
	}

}