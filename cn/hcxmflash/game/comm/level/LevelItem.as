package cn.hcxmflash.game.comm.level 
{
	import cn.hcxmflash.game.comm.component.Viewer;
	import com.gskinner.geom.ColorMatrix;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class LevelItem extends  Viewer
	{
		private var _lock:Boolean=true;
		private var _level;
		private var _lock_mc:*;
		private var _level_txt:*;
		
		public function LevelItem(_itemUI:*) 
		{
			super(_itemUI);
			
			this.buttonMode = true;
			
			this.addEventListener(MouseEvent.CLICK, __CLICK);
			this.addEventListener(MouseEvent.ROLL_OVER, __ROLL_OVER);
			this.addEventListener(MouseEvent.ROLL_OUT, __ROLL_OUT);
			this.mouseChildren = false;
		}
		override public function drawComplete():void 
		{
			
			
			super.drawComplete();
			
			
				_lock_mc = _mc["mc_lock"];
				
				
				_level_txt = _mc["txt_level"];
		
			
		}
		
		private function __ROLL_OVER(e:MouseEvent):void 
		{
			
			var c:ColorMatrix = new ColorMatrix()
			c.adjustBrightness(60);
			this.filters = [new ColorMatrixFilter(c)];
		}
		
		private function __ROLL_OUT(e:MouseEvent):void 
		{
			this.filters = [];
		}
		
		private function __CLICK(e:MouseEvent):void 
		{
			
		}
		public function set lock(value):void 
		{
			_lock = value;
			
		}
		public function set level(value):void 
		{
			_level = value;
		}
		public function get level() { return _level; }
		private function draw():void
		{
			if (_lock)
			{
				drawLock();
			}else
			{
				drawUnLock()
			}
			
			if (_lock==false&&_lock_mc) 
			{
				_lock_mc.visible = false;
				
			}else
			{
				//this.mouseEnabled = false; this.mouseChildren = false;
			}
		
			
			
			if(_level_txt)_level_txt.text = _level;
			
		}
		
		protected function drawUnLock():void 
		{
		
			
			
			this.mouseChildren = false;
			this.mouseEnabled = true; 
			
		}
		
		protected function drawLock():void 
		{
			this.mouseEnabled = false; this.mouseChildren = false;
			
		}
		public function update():void
		{
			
			
			
			
			draw();
			
		}
		
	}

}