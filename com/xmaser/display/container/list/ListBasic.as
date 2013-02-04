package com.xmaser.display.container.list 
{
	
	
	import cn.hcxmflash.container.render.asset_listbg;
	import com.xmaser.display.component.ComponentBasic;
	import com.xmaser.display.component.scroll.Scroll;
	import com.xmaser.display.container.HBox;
	import com.xmaser.display.container.render.events.ItemRenderEvent;
	import com.xmaser.display.container.render.ItemRender;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class ListBasic extends ComponentBasic 
	{
		private var _scroll:Scroll;
		protected var _hGap:Number=6;
		protected var _vGap:Number=0;
		protected var _dataProvider:*;
		protected var _itemRender:Class
		protected var _bgMc:MovieClip;
		
		protected var _holdItems:Sprite = new Sprite();
		private var _maskFor_holdItems:Shape;
		
		private var _align:String = "left";
		private var _scrollStep:Number = 0;
		
		protected var _dataProvider2:*;
		public function ListBasic() 
		{
			
		}
		override protected function drawUI():void 
		{
			super.drawUI();
			drawBg()
			drawMask();
			addChild(_holdItems);
			_holdItems.mask = _maskFor_holdItems;
			
		}
		
		protected function drawBg():void 
		{
			_bgMc = new asset_listbg();
			addChild(_bgMc);
			
		}
		
		protected function drawMask():void 
		{
			if (!_maskFor_holdItems)
			{
				_maskFor_holdItems = new Shape()
				addChild(_maskFor_holdItems)
			}
			_maskFor_holdItems.graphics.clear();
			_maskFor_holdItems.graphics.beginFill(0xff0000);
			_maskFor_holdItems.graphics.drawRect(0, 0, _bgMc.width, _bgMc.height);

			_maskFor_holdItems.graphics.endFill();
			if (_scroll)
			{
				_scroll.maskHeight = _bgMc.height
				_scroll.x = _bgMc.width + _bgMc.x-_scroll.width;;
					
					_scroll.maskWidth = _bgMc.width;
					_scroll.maskHeight = _bgMc.height;
					
				//_scroll.dragBarPostionPercent = 0;
				//_scroll.target = _holdItems;
			}
			
			
		}
		public function get itemRender():Class 
		{
			return _itemRender;
		}
		
		public function set itemRender(value:Class):void 
		{
			_itemRender = value;
		}
		
		public function get dataProvider():* 
		{
			return _dataProvider;
		}
		
		public function set dataProvider(value:*):void 
		{
			_dataProvider = value;
			
			
			drawItem();
			
		}
		public function get dataProvider2():* 
		{
			return _dataProvider2;
		}
		
		public function set dataProvider2(value:*):void 
		{
			_dataProvider2 = value;
			drawItem2()
		}
		
		protected function drawItem2():void 
		{
			
		}
		public function get align():String 
		{
			return _align;
		}
		
		public function set align(value:String):void 
		{
			_align = value;
		}
		public function addItem(value:*):void 
		{
			if (!_dataProvider)_dataProvider = [];
			_dataProvider.unshift(value);
			var item:ListItemRender;
			item = new _itemRender();
				item.data = value;
				item.y =0
			
				_holdItems.addChildAt(item,0);
				item.addEventListener(ItemRenderEvent.RESIZE, __itemRESIZE)
			rePosition();
			
		}
		public function delItem(value:*):void
		{
			var ind:int = _dataProvider.indexOf(value);
			//trace("ind: " + ind);
			if (ind!=-1) 
			{
				_dataProvider.	splice(ind, 1);
				var item:*=_holdItems.removeChildAt(ind);
				item.removeEventListener(ItemRenderEvent.RESIZE, __itemRESIZE);
				rePosition();
			}
			
		}
		public function delItemByID(id:*):void
		{
			for each (var item:* in _dataProvider) 
			{
				if (item.id == id)
				{
					var i:int = 0;
					while (i<_holdItems.numChildren) 
					{
						var item1:*= _holdItems.getChildAt(i);
						if (item1.data.id == id)
						{
							_holdItems.removeChild(item1);
							item1.removeEventListener(ItemRenderEvent.RESIZE, __itemRESIZE);
				rePosition();
							break;
						}
						i++
					}
					return;
				}
			}
			
			
		}
		public function getItemByID(id:*):*
		{
			for each (var item:* in _dataProvider) 
			{
				if (item.id == id)
				{
					return item;
				}
			}
			return null;
			
		}
		private function drawItem():void 
		{
			var item:ListItemRender;
			var hh:Number = 0;
			removeAllItemRender();
			
			for (var i:int = 0; i < _dataProvider.length; i++) 
			{
				var data:* = _dataProvider[i];
				item = new _itemRender();
				item.data = data;
				if(_align=="right")item.x=this.width-item.width-_hGap
				item.y = hh;
				_holdItems.addChild(item);
				postionItem(item,i)
				hh += (item.height + _vGap);
				//trace("(item.height: " + item.height);
				
				//trace("item.x: " + item.x);
				
				item.addEventListener(ItemRenderEvent.RESIZE, __itemRESIZE)
				
			}
			
			if (_holdItems is HBox)
			{
				var re:Rectangle = _holdItems.getBounds(_holdItems);
				hh = re.y * 2 + re.height;
			}
			
			if (_holdItems.height > _bgMc.height)
			{
				if (!_scroll)
				{
					_scroll = new Scroll();
					if (_scrollStep > 0)_scroll.scrollStep = _scrollStep;
					addChild(_scroll);
					_scroll.x = _bgMc.width + _bgMc.x-_scroll.width;
			
					_scroll.maskWidth = _bgMc.width;
					_scroll.maskHeight = _bgMc.height;
				}else
				{
					
				}
				
					
			}else
			{
				if (_scroll)
				{
					_scroll.target = null;
					removeChild(_scroll);
					_scroll = null;
				}
			}
			
			if (_scroll)
			{
				_scroll.target = _holdItems;
				//_scroll.dragBarPostionPercent = 0;
			}
		}
		
		protected function postionItem(item:ListItemRender,index:int):void 
		{
			
		}
		
		protected function removeAllItemRender():void 
		{
			if (_holdItems is HBox) 
			{
				HBox(_holdItems).destory()
			}		
			while (_holdItems.numChildren>0) 
			{
				ItemRender(_holdItems.getChildAt(0)).destory();
				_holdItems.getChildAt(0).removeEventListener(ItemRenderEvent.RESIZE, __itemRESIZE);
				_holdItems.removeChildAt(0);
			}
			
			_holdItems.y = 0;
			if (_scroll)
			{
				_scroll.dragBarPostionPercent = 0;
			}
		}
		
		private function __itemRESIZE(e:ItemRenderEvent):void 
		{
			rePosition();
		}
		public function rePosition():void
		{
			var i:int = 0;
			var hh:Number = 0;
			while (i<_holdItems.numChildren) 
			{
				var item:*= _holdItems.getChildAt(i);
				item.y = hh;
				postionItem(item,i);
				if(_align=="right")item.x=this.width-item.width-_hGap
				hh += (item.height + _vGap);
				i++;
			}
			
			
			if (hh > _bgMc.height)
			{
				if (!_scroll)
				{
					_scroll = new Scroll();
					addChild(_scroll);
					if (_scrollStep > 0)_scroll.scrollStep = _scrollStep;
					_scroll.x = _bgMc.width + _bgMc.x-_scroll.width;;
					_scroll.target = _holdItems;
					_scroll.maskWidth = _bgMc.width;
					_scroll.maskHeight = _bgMc.height;
				}
					
			}
			
			
		}
		public function enabledMouseWheel():void
		{
			this.addEventListener(MouseEvent.MOUSE_WHEEL, __MOUSE_WHEEL);
		}
		
		protected function __MOUSE_WHEEL(e:MouseEvent):void 
		{
			if (_scroll)
			{
				if (e.delta < 0)
				{
					_scroll.goDown()
				}else
				{
					_scroll.goUp()
				}
			}
		}
		public function disabledMouseWheel():void
		{
			this.removeEventListener(MouseEvent.MOUSE_WHEEL, __MOUSE_WHEEL);
		}
		
		public function set scrollStep(value:Number):void 
		{
			_scrollStep = value;
			if (_scroll)_scroll.scrollStep = value;
		}
		
		public function get scroll():Scroll 
		{
			return _scroll;
		}
		
		public function get holdItems():Sprite 
		{
			return _holdItems;
		}
		public function scrollToIndex(ind:int):void
		{
			var item:*= _holdItems.getChildAt(ind);
			item.y
			trace("item.y: " + item.y);
			scroll.dragBarPostionPercent = item.y / (_holdItems.height-_maskFor_holdItems.height);
		}
		
		
		
	}

}