package cn.hcxmflash.media.lrc 
{
	import cn.hcxmflash.component.LabelComponent;
	import cn.hcxmflash.container.Panel;
	import cn.hcxmflash.event.Event_;
	import cn.hcxmflash.media.lrc.LRCParser;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextFormat;
	import gs.TweenLite;
	
	/**
	 * ...
	 * @author 
	 */
	public class LRCViewer extends Sprite 
	{
		private var _lyrice:Array;
		
		private var _wordArr:Array
		private var _parser:LRCParser;
		private var pthis:Point;
		private var _panel:Panel;
		private var lastLabel:LabelComponent;
		public function LRCViewer() 
		{
			_wordArr=[]
		}
		public function loadLRC(url:String):void
		{
			_parser.setp = 1;
			_parser.load(url);
		}
		public function set lrcParser(value:LRCParser):void 
		{
			_parser = value;
			_parser.addEventListener(Event_.LOADER_COMPLETE, __LOADER_COMPLETE);
		}
		
		private function __LOADER_COMPLETE(e:Event_):void 
		{
			lyrice = _parser.lyrics;
		}
		public function get lyrice():Array 
		{
			return _lyrice;
		}
		
		public function set lyrice(value:Array):void 
		{
			_lyrice = value;
			
			create()
		}
		public function set panel(value:Panel):void 
		{
			_panel = value;
		}
		private function create():void 
		{
			_wordArr=[]
			while (this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
			for (var i:int = 0; i <_lyrice .length; i++) 
			{
				var item:LrcVO = _lyrice[i];
				//var l:LabelComponent = new LabelComponent(item.timeArr[0]+"-"+item.lyrics);
				var l:LabelComponent = new LabelComponent(item.lyrics);
				l.y = this.height;
				addChild(l);
				item.timeArr;
				var o1:Object={}
				for (var j:int = 0; j < item.timeArr.length; j++) 
				{
					var item2:Number =  item.timeArr[j];
					o1[item2] = l;
				}
				_wordArr.push(o1);
				
			}
			stage.invalidate();
		}
		
		public function show(time:Number):void 
		{
			this.y
			
			time = Number(time.toFixed(0));
			//trace( "time : " + time );
			if(lastLabel)lastLabel.textFormat = new TextFormat("_sans", 12, 0x000000, false);
			for (var i:int = 0; i <_wordArr.length; i++) 
			{
				var item:Object = _wordArr[i];
				var find:Boolean = false;
				for (var name:String in item) 
				{
					//trace( "name : " + name );
					var la:LabelComponent = item[name];
					la.textFormat = new TextFormat("_sans", 12, 0x000000, false);
					var n:Number = Number(name);
					if (time >= n)
					{
						//la.textFormat = new TextFormat("_sans", 12, 0xff0000, true);
						lastLabel = la;
					}else 
					{
						if (lastLabel)
						{
							if(!pthis)pthis = this.localToGlobal(new Point())
							var pla:Point = lastLabel.localToGlobal(new Point())
							
							pla = this.globalToLocal(pla);
							//trace( "pla : " + pla );
							var per:Number = (pla.y -100)/ (this.height - _panel.contentHeight);
							//trace( "per : " + per );
							_panel.dragBarPostionPercent = per;
							
							/*if ((pla.y-pthis.y) >=100)
							{
								var yy:Number = -(pla.y - pthis.y);
								trace( "yy : " + yy );
								var pthis2:Point = this.globalToLocal(new Point(pla.x, pthis.y-100))
								trace( "pthis2 : " + pthis2 );
								//TweenLite.to(this, 0.2, { y:yy ,overwrite:0} );
								this.y = pthis2.y;
							}*/
							
							lastLabel.textFormat = new TextFormat("_sans", 12, 0xff0000, true);
						}
						return;
					}
				}
			}
		}
		
		
	}

}