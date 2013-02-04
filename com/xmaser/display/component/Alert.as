package com.xmaser.display.component 
{
	import com.xmaser.assets.asset_alert;
	import com.xmaser.display.component.Alert;
	import com.xmaser.display.component.butotn.ButtonComponent;
	import view.content.AlertContt;

	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author 小火柴
	 */
	public class Alert extends ComponentBasic 
	{
		protected var _title:String;
		protected var _msg:String;
		protected var _ww:Number;
		protected var _hh:int;
		static public var stage:Stage;
		protected var _bg:asset_alert;
		protected var _hold:Sprite;
		private var _clickFuncs:Array;
		private var _labs:Array;
		private var _buttons:Array=[];
		private var _cx:int;
		private var _cy:int;
		public function Alert(title:String, msg:String) 
		{
			_msg = msg;
			_title = title;
			
			super();
			if (!Alert.stage)
			{
				throw new Error("stage没有赋值")
			}
		}
		override protected function drawUI():void 
		{
			super.drawUI();
			_bg = new asset_alert()
			addChild(_bg);
			_hold = new Sprite();
			/*_hold.graphics.beginFill(0, 0.2);
			_hold.graphics.drawRect(0, 0, 240, 33);
			_hold.graphics.endFill();*/
			addChild(_hold);
			
			var tf1:TextFormat = new TextFormat("_sans", 12,0,true);
			if (_title)
			{
				var _txt_title:TextField = new TextField();
				_txt_title.autoSize = "left";
				_txt_title.selectable = false;
				_txt_title.text = _title;
				_txt_title.setTextFormat(tf1);
				_hold.addChild(_txt_title);
				
				_txt_title.x = 10; _txt_title.y = 0;
				_txt_title.y = 30 / 2 - _txt_title.height / 2;
			}
			var tf:TextFormat = new TextFormat("_sans", 12);
			tf.align = "center";
			if (_msg)
			{
				var _txt_msg:TextField = new TextField();
				_txt_msg.width = 220;
				//_txt_msg.border = true;
				_txt_msg.wordWrap = true;
				_txt_msg.autoSize = "center";
				
				_txt_msg.selectable=false
				
				_txt_msg.x = 10; _txt_msg.y = 40;
				_hold.addChild(_txt_msg);
				_txt_msg.htmlText = _msg;
				_txt_msg.setTextFormat(tf);
				
				
				var maxh:Number = Math.max(_txt_msg.height, 100);
				_bg.height=maxh
			}
			_bg.width = 240;
			
		}
		override protected function init():void 
		{
			super.init();
			
			
			_ww = stage.stageWidth;
			_hh = stage.stageHeight;
			
			
			
			
			if (_labs)
			{
				createButtons();
				var maxh:Number = Math.max(_hold.height+20, 100);
				_bg.height=maxh
				
			}
			
			if (_cx != -1)
			{
					_bg.x = _cx;
			}else
			{
				_bg.x = _ww / 2 - _bg.width / 2;
			}
			
			if (_cy!=-1) 
			{
				_bg.y = _cy;
			}else 
			{
				_bg.y = _hh / 2 - _bg.height / 2;
			}
			
			_hold.x = _bg.x
			_hold.y = _bg.y;
			
			
			this.graphics.beginFill(0xffffff, 0.1);
			this.graphics.drawRect(0, 0, _ww, _hh);
			this.graphics.endFill();
		}
		
		private function createButtons():void 
		{
			var hb:Sprite = new Sprite()
			_hold.addChild(hb);
			for (var i:int = 0; i < _labs.length; i++) 
			{
				var item:ButtonComponent = new ButtonComponent()
				item.label = _labs[i];
				item.name = "b" + i;
				_buttons.push(item);
				
				item.addEventListener(MouseEvent.CLICK, __CLICK);
				item.x = hb.width + 10;
				hb.addChild(item);
			}
			hb.y = _hold.height + 10;
			hb.x = 5+_hold.width / 2 - hb.width / 2
			trace( "_hold.width : " + _hold.width );
			trace( "hb.width : " + hb.width );

		}
		
		private function __CLICK(e:MouseEvent):void 
		{
			var nams:String = e.currentTarget.name;
			var id:int = int(nams.slice(1));
			if (_clickFuncs) 
			{
				_clickFuncs[id]();
			}else
			{
				
			}
			close()
		}
		
		private function close():void 
		{
			this.destory();
			Alert.stage.removeChild(this);
		}
		override public function destory():void 
		{
			removeChild(_hold);
			this.graphics.clear();
			_clickFuncs = _labs = null;
		}
		public static function show(title:String,msg:String,labs:Array=null,clickFuncs:Array=null,x:int=-1,y:int=-1):void
		{
			//var _alert:Alert = new Alert(title, msg);
			var _alert:AlertContt = new  AlertContt(title, msg);
			_alert.clickFuncs = clickFuncs;
			_alert.labs = labs;
			_alert.cx = x; _alert.cy = y;
			Alert.stage.addChild(_alert);
		}
		
		public function get title():String 
		{
			return _title;
		}
		
		public function get msg():String 
		{
			return _msg;
		}
		
		public function set clickFuncs(value:Array):void 
		{
			_clickFuncs = value;
		}
		
		public function set labs(value:Array):void 
		{
			_labs = value;
			if (value == null)
			{
				_labs=["ok"]
			}
			
		}
		
		public function set cx(value:int):void 
		{
			_cx = value;
		}
		
		public function set cy(value:int):void 
		{
			_cy = value;
		}
	}

}