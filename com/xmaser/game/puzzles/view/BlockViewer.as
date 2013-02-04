package com.xmaser.game.puzzles.view 
{
	import com.xmaser.game.puzzles.model.BlockVO;
	import com.xmaser.view.ViewBasic;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class BlockViewer extends ViewBasic 
	{
		public var blockWidth:Number;
		public var blockHeight:Number;
		/**
		 * 被哪个东西删除的
		 */
		public var deleteBySpecial:int;
		protected var _vo:BlockVO;
		protected var _searched:Boolean;
		protected var _txt:TextField;
		
		public function BlockViewer() 
		{
			super(null);
			_txt = new TextField();
			_txt.autoSize = "left";
			addChild(_txt);
			_txt.textColor = 0xff0000;
			_txt.selectable = false; _txt.mouseEnabled = false;
		}
		public function drawBg():void
		{
			this.graphics.clear()
			this.graphics.lineStyle(1, 0);
			if (this.searched)
			{
				this.graphics.lineStyle(2, 0xff0000);
			}
			var co:uint;
			switch (vo.type) 
			{
				case 0:
					co = 0xcccccc;
				break;
			case 1:
					
					co = 0x000000;
					
				break;
				case 2:
					co = 0x00ff00;
				break;
				case 3:
					co = 0x0000ff;
				break;
				case 11:
					co = 0xff0000
				break;
				default:
					
				break;
			}
			if (vo.special == 1)
					{
						co = 0xff0000;
					}
			this.graphics.beginFill(co,1);
			this.graphics.drawRect(0, 0, blockWidth, blockHeight);
			this.graphics.endFill();
			
		}
		
		public function updateTest(len:int=0):void
		{
			_txt.text = vo.y + "_" + vo.x+"|"+len;
		}
		public function set vo(value:BlockVO):void 
		{
			_vo = value;
			drawBg()
		}
		
		public function get vo():BlockVO 
		{
			return _vo;
		}
		
		public function get searched():Boolean 
		{
			return _searched;
		}
		
		public function set searched(value:Boolean):void 
		{
			_searched = value;
			
			
		}
		public function set selected(value:Boolean):void 
		{
			if (value)
			{
				this.filters=[new  ColorMatrixFilter(new Array(1,0,0,0,85,0,1,0,0,85,0,0,1,0,85,0,0,0,1,0))]
			}else 
			{
				this.filters = [];
			}
		}
		override public function get name():String 
		{
			return vo.y + "_" + vo.x;
		}
		
		override public function set name(value:String):void 
		{
			super.name = value;
		}
		
		override public function toString():String 
		{
			return vo.y+   "_" + vo.x+" type:" + vo.type + "	com.xmaser.game.puzzles.view.BlockViewer" ;
		}
		/**
		 * 变身
		 * 4 相同	发光	爆破周围
		 * 5 相同	燃烧	会从激活处燃烧到底，最后爆炸。
		 * 6 相同	闪电	犹如一道霹雳消除横竖向的小鸡。
		 * 7 相同	黑洞	会吸走屏幕上所有的，就是清屏，
		 * 
		 * @param	len	共有几个相同的，
		 */
		
		public function change(len:int):void 
		{
			switch (len) 
			{
				case 4:
					_vo.special = 1;
					break;
				case 5:
					_vo.special = 2;
					
				break;
				default:
					
				break;
			}
			vo = _vo;
		}
		
		public function remove(len:int=3):void 
		{
			
		}
	}

}