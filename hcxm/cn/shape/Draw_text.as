package hcxm.cn.shape
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import hcxm.cn.shape.controlClass.RichTextArea;
	import hcxm.cn.shape.manager.DrawManager;
	
	import mx.controls.Button;
	import mx.controls.Text;
	import mx.events.FlexEvent;
	public class Draw_text extends DrawBasic
	{
	/**
		 * 在 mc 中画
		 * */
		public function Draw_text(mc:Sprite)
		{
			super(mc);
		}

		var ds:DragedSprite
		
		var k=0
		public var isDrawNewText:Boolean=true;
		
		override protected function _MOUSE_DOWN(e:MouseEvent):void
		{
			super._MOUSE_DOWN(e);			
			//Debug.trace_("DrawManager.isModi="+DrawManager.isModi)
			if(DrawManager.isModi)
			{
				//DrawManager.dragedSprite.showKuan()
				return;
			}
			
			if(!isDraw)return;
			var ta:Object=e.target;
			k++
			
			if(!isEnabledDraw)return;
			if(ta is Button)
			{
				if(ds)
				{
					ds.textarea.mouseChildren=false;
					ds.textarea.mouseEnabled=false;
					ds.setFocus();
					if(ds.textarea.text=="")
					{
						ds.removeChild(ds.textarea)
					}else
					{
						
						ds.textarea.showImgtext()
					}
					ds=null;
					return;
				}
				return;
			}
			if(ta==DrawManager.drawCanvs&&ds)
			{
				ds.textarea.mouseChildren=false;
				ds.textarea.mouseEnabled=false;
				ds.setFocus();
				
				if(ds.textarea.text=="")
				{
					ds.removeChild(ds.textarea)
				}else
				{
					
					ds.textarea.showImgtext()
				}
				ds=null;
				return;
			}
	/* 		if(!isDrawNewText)
			{
				if(k==3)
				{
					isDrawNewText=true;
					k=0
				}
				
				return;
			} */
			
			ds=new DragedSprite();
			ds.Ower=this;
			ds.x=e.stageX-canvaMc.x
			ds.y=e.stageY-canvaMc.y;
			ds.name="dragSpritet_txt"+k
			
			canvaMc.addChild(ds);
			ga=ds.Pen;
			
			var textara:RichTextArea=new RichTextArea()
			ds.addChild(textara)
			textara.width=20
			textara.height=20
			DrawManager.NoCursor();
			textara.setFocus()
			ds.textarea=textara;
			isDrawNewText=false;
		}
		var xx=0;
		var yy=0;
		var exx
		var eyy
		override protected function _MOUSE_MOVE(e:MouseEvent):void
		{
			
			if(!isDraw||!isEnabledDraw)return;
			
			
		}
		override protected function _MOUSE_UP(e:MouseEvent):void
		{
			super._MOUSE_UP(e);
			if(!isEnabledDraw)return;
			if(ds)
			{
				if(ds.isDrawOver==true)return;
			}else
			{
				return;
			}
			ds.kxx=xx;
			ds.kyy=yy;
			ds.rx=xx
			ds.ry=yy
				
			ds.isDrawOver=true;	
		}
		
		override public function manualDraw():void
		{
			var ob:DragedSprite=DrawManager.dragedSprite;

			ob.textarea.setStyle("fontSize",this.TEXTVO.size);
			ob.textarea.setStyle("color",this.TEXTVO.color);
			ob.textarea.setStyle("fontWeight",this.TEXTVO.bold);
			ob.textarea.setStyle("fontStyle",this.TEXTVO.xie);
			ob.textarea.setStyle("textDecoration",this.TEXTVO.underline);
			/*ob.textarea.visible=false;
			 var te:Text=new Text()
	    	ob.textarea.addChild(te)
	    	te.text=ob.textarea.text;
	    	te.setStyle("fontSize",this.TEXTVO.size); */
			
			
			_uc(null)
			
		}
		 private function _uc(e:FlexEvent):void
	    {
	    	var ob:DragedSprite=DrawManager.dragedSprite;
	    	ob.textarea.removeEventListener(FlexEvent.UPDATE_COMPLETE,_uc)
	    	
    		timer=new Timer(300,1)
    		timer.addEventListener(TimerEvent.TIMER_COMPLETE,_timerF);
    		timer.start()

	    }
	   	var timer:Timer
	    private function _timerF(e:TimerEvent):void
	    {
	    	var ob:DragedSprite=DrawManager.dragedSprite;
	    	ob.textarea.removeEventListener(FlexEvent.UPDATE_COMPLETE,_uc)
	    	ob.textarea.showImgtext();
	    	ob.showKuan();
	    	timer.removeEventListener(TimerEvent.TIMER_COMPLETE,_timerF)
	    	
	    	
	    }
		
			
	}
}