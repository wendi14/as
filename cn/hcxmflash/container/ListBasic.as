package  cn.hcxmflash.container
{
	import cn.hcxmflash.container.ContainerBasic;
	import cn.hcxmflash.container.render.ItemRender;
	import cn.hcxmflash.container.render.ListItemRender;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author 
	 */
	public class ListBasic extends  ContainerBasic 
	{
		protected var _bgMc:MovieClip;
		private var _bgSkinClass:Class;
		
		public function ListBasic() 
		{
			var listA:Class = ListItemRender;
			
			
			var ca:Class
			try 
			{
				ca= getDefinitionByName("listBgSkin") as Class;
			}catch (err:Error)
			{
				
			}
			if (ca) 
			{
				bgSkin = ca;
			}
			 super(listA);
		}
		public function set bgSkin(value:Class):void 
		{
			_bgSkinClass = value;
			_bgMc = new _bgSkinClass()
			addChildAt(_bgMc,0)
			_bgMc.mouseChildren = false;
			_bgMc.width = _bgMc.height = 1;
		}
		
		public function get bgSkinClass():Class 
		{
			return _bgSkinClass;
		}
		
		public function set bgSkinClass(value:Class):void 
		{
			_bgSkinClass = value;
		}
		override protected function draw():void 
		{
			super.draw();
			rePostion()
		}
		override protected function rePostion():void 
		{
			for (var i:int = 0; i < _oldItemArr.length; i++) 
			{
				var item:ItemRender = _oldItemArr[i];
				item.y = 6+i * item.height;
				item.x = 6;
			}
			_bgMc.width = this.width+12;
			_bgMc.height = this.height+12;
			super.rePostion();
		}
		
	}

}