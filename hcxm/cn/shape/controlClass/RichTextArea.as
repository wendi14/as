package hcxm.cn.shape.controlClass
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	import hcxm.cn.debug.Debug;
	
	import mx.controls.TextArea;
	import mx.graphics.ImageSnapshot;
	
	/**
	 * @private
	 * Extends the TextArea and adds url and email highLighting to it
	 */
	public class RichTextArea extends TextArea
	{
		/**
		*@private
		 * Private variable for keeping changedTextFormat
		 */
		protected var _explicitHTMLText:String;
		
		//sometimes you want to turn this off
		protected var _highlightURLs:Boolean = true;
		
		public function get highlightURLs():Boolean
		{
			return _highlightURLs;
		}
		public function set highlightURLs(p_doit:Boolean):void
		{
			_highlightURLs = p_doit;
		}
		var oldWidth
		var oldHeight
		public function RichTextArea()
 		{
        	super();
			addEventListener(Event.CHANGE, onChange);

			this.wordWrap=false;
			this.horizontalScrollPolicy="off";
			oldWidth=20;
			oldHeight=2
			//this.selectable=false;
			setStyle("backgroundAlpha",0)
			this.setStyle("borderStyle","none")
			
    	}

	    override public function set text(p_text:String):void
	    {
	    	super.text = p_text;
	    	validateNow()
	    	
	    }

	    protected function onChange(p_evt:Event):void
	    {
			_explicitHTMLText = super.htmlText;
//	    	htmlText = super.text;
			
			
			validateNow()
			this.width=oldWidth+this.textWidth;
			this.height=oldHeight+this.textHeight;
			//this.width=this.textWidth
	    }

	    override protected function commitProperties():void
	    {
	    	super.commitProperties();
	    	
	    	this.width=this.textField.textWidth+20;
	    	this.height=this.textField.textHeight+oldHeight
	    }
	    override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
	    {
	    	super.updateDisplayList(unscaledWidth, unscaledHeight);
	    	
			if(styleC)
			{
				var textLinew:int = this.textField.textWidth
				var textLineh:int = this.textField.textHeight
				trace("textLineh	="+textLineh)
				this.width=textLinew;
				this.height=textLineh
			}
			styleC=false;
	    }
	    override public function styleChanged(styleProp:String):void
	    {
	    	super.styleChanged(styleProp);
	    	trace("-----------styleChanged");  
	    	invalidateDisplayList();
	    	
	    	styleC=true
	    }
	    private var styleC:Boolean=false;
	    public function showImgtext():void
	    {
		    
	    	var da:BitmapData=ImageSnapshot.captureBitmapData(this,new Matrix())
	    	var btimap:Bitmap=new Bitmap(da)
	    	//btimap.y=100
	    	btimap.smoothing=true;
	    	var ow=this.owner
	    	if(ow.bitmap)
	    	{
	    		ow.removeChild(ow.bitmap);
	    		ow.bitmap=null;
	    	}
	    	ow.addChild(btimap)
	    	ow.isShowImageText=true;
	    	ow.bitmap=btimap;
	    	//ow.showKuan()
	    }
	   
	     
	  
	}
}