/*
	ADOBE SYSTEMS INCORPORATED
 	Copyright 2008 Adobe Systems Incorporated
 	All Rights Reserved.

	NOTICE:  Adobe permits you to use, modify, and distribute this file in accordance with the 
	terms of the Adobe license agreement accompanying it.  If you have received this file from a 
	source other than Adobe, then your use, modification, or distribution of it requires the prior 
	written permission of Adobe.
*/
package fl.controls
{
	import fl.core.InvalidationType;
	import fl.core.UIComponent;
	import fl.events.ScrollEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	/* List all classes from TLF so that we can force each to be linked into TextLayout.swc */

	import flashx.textLayout.conversion.ITextImporter; ITextImporter; 
	import flashx.textLayout.conversion.ITextExporter; ITextExporter; 
	import flashx.textLayout.conversion.ConversionType; ConversionType;
	import flashx.textLayout.conversion.ImportExportConfiguration; ImportExportConfiguration;
	import flashx.textLayout.conversion.TextFilter; TextFilter;

	import flashx.textLayout.compose.IFlowComposer; IFlowComposer;
	import flashx.textLayout.compose.FlowComposerBase; FlowComposerBase;
	import flashx.textLayout.compose.StandardFlowComposer; StandardFlowComposer;
	
	import flashx.textLayout.container.ColumnState; ColumnState;		
	import flashx.textLayout.container.IContainerController; IContainerController;
	import flashx.textLayout.container.DisplayObjectContainerController; DisplayObjectContainerController;
	import flashx.textLayout.container.ScrollPolicy; flashx.textLayout.container.ScrollPolicy;
	
	import flashx.textLayout.elements.BreakElement; BreakElement;
	import flashx.textLayout.elements.Configuration; Configuration;
	import flashx.textLayout.elements.ContainerFormattedElement; ContainerFormattedElement;
	import flashx.textLayout.elements.DivElement; DivElement;
	import flashx.textLayout.elements.FlowElement; FlowElement;
	import flashx.textLayout.elements.FlowGroupElement; FlowGroupElement;
	import flashx.textLayout.elements.FlowLeafElement; FlowLeafElement;
	import flashx.textLayout.elements.IConfiguration; IConfiguration;
	import flashx.textLayout.elements.InlineGraphicElement; InlineGraphicElement;
	import flashx.textLayout.elements.InlineGraphicElementStatus; InlineGraphicElementStatus;
	import flashx.textLayout.elements.LinkElement; LinkElement;
	import flashx.textLayout.elements.LinkState; LinkState;
	import flashx.textLayout.elements.ParagraphElement; ParagraphElement;
	import flashx.textLayout.elements.ParagraphFormattedElement; ParagraphFormattedElement;
	import flashx.textLayout.elements.SpanElement; SpanElement;
	import flashx.textLayout.elements.SpecialCharacterElement; SpecialCharacterElement;
	import flashx.textLayout.elements.SubParagraphGroupElement; SubParagraphGroupElement;
	import flashx.textLayout.elements.TabElement; TabElement;
	import flashx.textLayout.elements.TCYElement; TCYElement;
	import flashx.textLayout.elements.TextFlow; TextFlow;
	import flashx.textLayout.elements.TextFlowLine; TextFlowLine;
	import flashx.textLayout.elements.TextFlowLineLocation; TextFlowLineLocation;

	import flashx.textLayout.edit.ISelectionManager; ISelectionManager;
	import flashx.textLayout.edit.IEditManager; IEditManager;
	import flashx.textLayout.edit.IUndoManager; IUndoManager;
	import flashx.textLayout.edit.EditingMode; EditingMode;
	import flashx.textLayout.edit.EditManager; EditManager;
	import flashx.textLayout.edit.ElementRange; ElementRange;
	import flashx.textLayout.edit.SelectionFormat; SelectionFormat;
	import flashx.textLayout.edit.SelectionManager; SelectionManager;
	import flashx.textLayout.edit.SelectionState; SelectionState;
	import flashx.textLayout.edit.TextRange; TextRange;
	import flashx.textLayout.edit.TextScrap; TextScrap;
	import flashx.textLayout.edit.UndoManager; UndoManager;

	import flashx.textLayout.events.CompositionCompletionEvent; CompositionCompletionEvent;
	import flashx.textLayout.events.FlowElementMouseEvent; FlowElementMouseEvent;
	import flashx.textLayout.events.FlowOperationEvent; FlowOperationEvent;
	import flashx.textLayout.events.ScrollEvent; flashx.textLayout.events.ScrollEvent;
	import flashx.textLayout.events.SelectionEvent; SelectionEvent;
	import flashx.textLayout.events.StatusChangeEvent; StatusChangeEvent;

	import flashx.textLayout.formats.ICharacterFormat; ICharacterFormat;
	import flashx.textLayout.formats.IContainerFormat; IContainerFormat;
	import flashx.textLayout.formats.IParagraphFormat; IParagraphFormat;
	import flashx.textLayout.formats.ITabStopFormat;   ITabStopFormat;
	import flashx.textLayout.formats.BaselineOffset; BaselineOffset;
	import flashx.textLayout.formats.BaselineShift; BaselineShift;
	import flashx.textLayout.formats.BlockProgression; BlockProgression;
	import flashx.textLayout.formats.CharacterFormat; CharacterFormat;
	import flashx.textLayout.formats.ContainerFormat; ContainerFormat;
	import flashx.textLayout.formats.Direction; Direction;
	import flashx.textLayout.formats.FormatValue; FormatValue;
	import flashx.textLayout.formats.JustificationRule; JustificationRule;
	import flashx.textLayout.formats.LeadingDirection; LeadingDirection;
	import flashx.textLayout.formats.LineBreak; LeadingDirection;
	import flashx.textLayout.formats.LineOffsetBasis; LineOffsetBasis;
	import flashx.textLayout.formats.ParagraphFormat; ParagraphFormat;
	import flashx.textLayout.formats.TabStopFormat; TabStopFormat;
	import flashx.textLayout.formats.TextAlign; TextAlign;
	import flashx.textLayout.formats.TextDecoration; TextDecoration;
	import flashx.textLayout.formats.VerticalAlign; VerticalAlign;
	import flashx.textLayout.formats.WhiteSpaceCollapse; WhiteSpaceCollapse;
			
	import flashx.textLayout.factory.TextLineFactory; TextLineFactory;
	
	import flashx.textLayout.operations.ApplyFormatOperation; ApplyFormatOperation;
	import flashx.textLayout.operations.ApplyFormatToElementOperation; ApplyFormatToElementOperation;
	import flashx.textLayout.operations.ApplyLinkOperation; ApplyLinkOperation;
	import flashx.textLayout.operations.ApplyTCYOperation; ApplyTCYOperation;
	import flashx.textLayout.operations.CompositeOperation; CompositeOperation;
	import flashx.textLayout.operations.CutOperation; CutOperation;
	import flashx.textLayout.operations.DeleteTextOperation; DeleteTextOperation;
	import flashx.textLayout.operations.FlowOperation; FlowOperation;
	import flashx.textLayout.operations.FlowTextOperation; FlowTextOperation;
	import flashx.textLayout.operations.InsertInlineGraphicOperation; InsertInlineGraphicOperation;
	import flashx.textLayout.operations.InsertTextOperation; InsertTextOperation;
	import flashx.textLayout.operations.ModifyInlineGraphicOperation; ModifyInlineGraphicOperation;
	import flashx.textLayout.operations.PasteOperation; PasteOperation;
	import flashx.textLayout.operations.RedoOperation; RedoOperation;
	import flashx.textLayout.operations.SplitParagraphOperation; SplitParagraphOperation;
	import flashx.textLayout.operations.UndoOperation; UndoOperation;
	
	import flashx.textLayout.utils.TextRangeUtil; TextRangeUtil;
	import flashx.textLayout.utils.CharacterUtil; CharacterUtil;

	import flashx.textLayout.BuildInfo; BuildInfo;

	/**
	 * Dispatched after the content is scrolled.
     	 *
     	 * @eventType fl.events.ScrollEvent.SCROLL
     	 *
     	 * @example This example adds an event listener to the text flow to listen for <code>scroll</code> events. When they occur
     	 * it calls <code>trace()</code> to display the horizontal and vertical scroll positions. The <code>tlfObj</code> object
     	 * is an instance name of the TextLayout control on the stage.
	 *	
	 * <listing version="3.0">
	 * import fl.events.ScrollEvent;
	 *	
	 * tlfObj.textFlow.addEventListener(ScrollEvent.SCROLL, scrollHandler);
	 *	
	 * function scrollHandler(evtObj:Event):void 
	 * {
	 *      trace("Horizontal Scroll Position: " + tlfObj.textFlow.flowComposer.getControllerAt(0).horizontalScrollPosition);
	 *      trace("Vertical Scroll Position: " + tlfObj.textFlow.flowComposer.getControllerAt(0).verticalScrollPosition);
	 * }
	 * </listing>
     	 *
     	 * @playerversion Flash 10
     	 * @playerversion AIR 1.5
     	 * @langversion 3.0
     	 * 
     	 * @see fl.events.ScrollEvent
	 *
     	 */
     	 
	[Event(name="scroll", type="flashx.textLayout.events.ScrollEvent")]

   //--------------------------------------
    //  Styles
    //--------------------------------------
    /**
     * @copy fl.controls.ScrollBar#style:downArrowDisabledSkin
     *
     * @default ScrollArrowDown_disabledSkin
     *
     * @playerversion Flash 10
     * @playerversion AIR 1.5
     * @langversion 3.0
     */
    [Style(name="downArrowDisabledSkin", type="Class")]
    
    
    /**
     * @copy fl.controls.ScrollBar#style:downArrowDownSkin
     *
     * @default ScrollArrowDown_downSkin
     *
     * @playerversion Flash 10
     * @playerversion AIR 1.5
     * @langversion 3.0
     */
    [Style(name="downArrowDownSkin", type="Class")]
    
    
    /**
     * @copy fl.controls.ScrollBar#style:downArrowOverSkin
     *
     * @default ScrollArrowDown_overSkin
     *
     * @playerversion Flash 10
     * @playerversion AIR 1.5
     * @langversion 3.0
     */
    [Style(name="downArrowOverSkin", type="Class")]

    /**
     * @copy fl.controls.ScrollBar#style:downArrowUpSkin
     *
     * @default ScrollArrowDown_upSkin
     *
     * @playerversion Flash 10
     * @playerversion AIR 1.5
     * @langversion 3.0
     */
    [Style(name="downArrowUpSkin", type="Class")]

    /**
     * @copy fl.controls.ScrollBar#style:thumbDisabledSkin
     *
     * @default ScrollThumb_upSkin
     *
     * @playerversion Flash 10
     * @playerversion AIR 1.5
     * @langversion 3.0
     */
    [Style(name="thumbDisabledSkin", type="Class")]

    /**
     * @copy fl.controls.ScrollBar#style:thumbDownSkin
     *
     * @default ScrollThumb_downSkin
     *
     * @playerversion Flash 10
     * @playerversion AIR 1.5
     * @langversion 3.0
     */
    [Style(name="thumbDownSkin", type="Class")]

    /**
     * @copy fl.controls.ScrollBar#style:thumbOverSkin
     *
     * @default ScrollThumb_overSkin
     *
     * @playerversion Flash 10
     * @playerversion AIR 1.5
     * @langversion 3.0
     */
    [Style(name="thumbOverSkin", type="Class")]

    /**
     * @copy fl.controls.ScrollBar#style:thumbUpSkin
	 *
     * @default ScrollThumb_upSkin
     * 
     * @playerversion Flash 10
     * @playerversion AIR 1.5
     * @langversion 3.0
     */
    [Style(name="thumbUpSkin", type="Class")]

    /**
     * @copy fl.controls.ScrollBar#style:trackDisabledSkin
     *
     * @default ScrollTrack_Skin
     *
     * @playerversion Flash 10
     * @playerversion AIR 1.5
     * @langversion 3.0
     */
    [Style(name="trackDisabledSkin", type="Class")]

    /**
     * @copy fl.controls.ScrollBar#style:trackDownSkin
     *
     * @default ScrollTrack_Skin
     *
     * @playerversion Flash 10
     * @playerversion AIR 1.5
     * @langversion 3.0
     */
    [Style(name="trackDownSkin", type="Class")]
    /**
     * @copy fl.controls.ScrollBar#style:trackOverSkin
     *
     * @default ScrollTrack_Skin
     *
     * @playerversion Flash 10
     * @playerversion AIR 1.5
     * @langversion 3.0
     */
    [Style(name="trackOverSkin", type="Class")]
    /**
     * @copy fl.controls.ScrollBar#style:trackUpSkin
     *
     * @default ScrollTrack_Skin
     *
     * @playerversion Flash 10
     * @playerversion AIR 1.5
     * @langversion 3.0
     */
    [Style(name="trackUpSkin", type="Class")]
    /**
     * @copy fl.controls.ScrollBar#style:upArrowDisabledSkin
     *
     * @default ScrollArrowUp_disabledSkin
     *
     * @playerversion Flash 10
     * @playerversion AIR 1.5
     * @langversion 3.0
     */
    [Style(name="upArrowDisabledSkin", type="Class")]
    /**
     * @copy fl.controls.ScrollBar#style:upArrowDownSkin
     *
     * @default ScrollArrowUp_downSkin
     *
     * @playerversion Flash 10
     * @playerversion AIR 1.5
     * @langversion 3.0
     */
    [Style(name="upArrowDownSkin", type="Class")]
    /**
     * @copy fl.controls.ScrollBar#style:upArrowOverSkin
     *
     * @default ScrollArrowUp_overSkin
     *
     * @playerversion Flash 10
     * @playerversion AIR 1.5
     * @langversion 3.0
     */
    [Style(name="upArrowOverSkin", type="Class")]
    /**
     * @copy fl.controls.ScrollBar#style:upArrowUpSkin
     *
     * @default ScrollArrowUp_upSkin
     *
     * @playerversion Flash 10
     * @playerversion AIR 1.5
     * @langversion 3.0
     */
    [Style(name="upArrowUpSkin", type="Class")]
    /**
     * @copy fl.controls.ScrollBar#style:thumbIcon
     *
     * @default ScrollBar_thumbIcon
     *
     * @playerversion Flash 10
     * @playerversion AIR 1.5
     * @langversion 3.0
     */
    [Style(name="thumbIcon", type="Class")]
   	
	/**
     * @copy fl.controls.BaseButton#style:repeatDelay
	 * 
     * @default 500
     *
     * @playerversion Flash 10
     * @playerversion AIR 1.5
     * @langversion 3.0
     */
    [Style(name="repeatDelay", type="Number", format="Time")]
	 
	 /**
     * @copy fl.controls.BaseButton#style:repeatInterval
     * 
     * @default 35
     *
     * @playerversion Flash 10
     * @playerversion AIR 1.5
     * @langversion 3.0
     */
    [Style(name="repeatInterval", type="Number", format="Time")]
	
	/*
	 * Require Player 10.
	 * 
	 */
	[minimumPlayerVersion("10")]


	/**
	 * The TextLayout class defines the Flash TextLayout component, which is an extensible framework for handling all aspects
	 * of creating and editing text. Some of the capabilities that the TextLayout component supports include:
	 * 
	 * <ul>
	 *	<li>Improved language support (including Middle Eastern, Far Eastern, Indic, and European)</li>
	 * 	<li>Advanced typographic features</li>
	 * 	<li>Advanced layout</li>
	 * 	<li>Full text formatting, editing and selection support (including cut, copy, paste)</li>
	 * 	<li>Undo and redo operations</li>
	 * 	<li>Linked containers</li>
	 * 	<li>Vertical justification</li>
	 * 	<li>Columns</li>
	 *	<li>Tables</li>
	 * 	<li>Import/export to XML</li>
	 * </ul>
	 *
	 * The TextLayout component is built on the Text Layout Framework, which is constructed from the APIs in the
	 * flashx.textLayout packages. Refer to the classes in those packages for more information on working with text
	 * in the TextLayout component.
	 *
	 * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 *
	 * @see.flashx.textLayout.elements.TextFlow
	 *
	 */

	public class TextLayout extends UIComponent
	{
		// TextContainer vars
		/** @private */
		protected var _container:Sprite;
		/** @private */
		protected var _clipContent:Sprite;
		
		/** The TextLayout display controller, which manages the composition and display of the text flow in a container. 
		 * @private 
		 */
		protected var _flowComposer:IFlowComposer;
		/** @private */
		protected var _containerController:IContainerController;
		
		/** @private */
		private var xml:XML = new XML(defaultXFL());
		/** @private */
		private static const DEFAULT_XFL:String = "<TextFlow editingMode='readSelect' horizontalScrollPolicy='auto' verticalScrollPolicy='auto' paddingTop='5' paddingBottom='5' paddingLeft='5' paddingRight='5' xmlns:flow='http://ns.adobe.com/textLayout/2008'><flow:p><flow:span></flow:span></flow:p></TextFlow>";

		/** @private */
		protected var _verticalScrollBar:fl.controls.ScrollBar;
		/** @private */
		protected var _horizontalScrollBar:fl.controls.ScrollBar;

		/** @private */
		protected static const SCROLL_BAR_STYLES:Object = {
											upArrowDisabledSkin: "upArrowDisabledSkin",
											upArrowDownSkin:"upArrowDownSkin",
											upArrowOverSkin:"upArrowOverSkin",
											upArrowUpSkin:"upArrowUpSkin",
											downArrowDisabledSkin:"downArrowDisabledSkin",
											downArrowDownSkin:"downArrowDownSkin",
											downArrowOverSkin:"downArrowOverSkin",
											downArrowUpSkin:"downArrowUpSkin",
											thumbDisabledSkin:"thumbDisabledSkin",
											thumbDownSkin:"thumbDownSkin",
											thumbOverSkin:"thumbOverSkin",
											thumbUpSkin:"thumbUpSkin",
											thumbIcon:"thumbIcon",
											trackDisabledSkin:"trackDisabledSkin",
											trackDownSkin:"trackDownSkin",
											trackOverSkin:"trackOverSkin",
											trackUpSkin:"trackUpSkin",
											repeatDelay:"repeatDelay",
											repeatInterval:"repeatInterval"
											};

		/** @private */
		private static var defaultStyles:Object = {	 
											repeatDelay:500,repeatInterval:35,
											skin:"ScrollPane_upSkin",
											contentPadding:0,
											disabledAlpha:0.5
											};

		/**
         * Constructor - creates a new TextLayout component instance.
         *
         * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 */
		public function TextLayout()
		{
			super();
			// TextContainer constructor stuff
			_container = null;
			_containerController = null;
			_flowComposer = null;
						
			// set the version variable
			version = BuildInfo.kBuildNumber;
			
			parseXML();
		}
		
	/**
         * @copy fl.core.UIComponent#getStyleDefinition()
         *
         * @see fl.core.UIComponent#getStyle() UIComponent.getStyle() 
         * @see fl.core.UIComponent#setStyle() UIComponent.setStyle()
         * @see fl.managers.StyleManager StyleManager
         *
         * @playerversion Flash 10
	 * @playerversion AIR 1.5
	 * @langversion 3.0
	 */
	 
		public static function getStyleDefinition():Object { 
			return mergeStyles(defaultStyles, ScrollBar.getStyleDefinition());
		}

		/** @private */
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			// remove all event listeners
			if (child == _clipContent) {
				_verticalScrollBar.removeEventListener(flashx.textLayout.events.ScrollEvent.SCROLL, handleVScroll);
				_horizontalScrollBar.removeEventListener(flashx.textLayout.events.ScrollEvent.SCROLL, handleHScroll);
				if (_containerController.textFlow) {
					_containerController.textFlow.removeEventListener(CompositionCompletionEvent.COMPOSITION_COMPLETE, composeComplete);
					_containerController.textFlow.removeEventListener(flashx.textLayout.events.ScrollEvent.SCROLL, controllerScrolled);
					_containerController.textFlow.removeEventListener(StatusChangeEvent.INLINE_GRAPHIC_STATUS_CHANGED,recomposeOnLoadComplete);				
				}
			}
			return super.removeChild(child);
		}

		// override in order to remove event listeners -- see removeChild()
		/** @private */
		override public function removeChildAt(index:int):DisplayObject
		{
			var child:DisplayObject = getChildAt(index);
			if (child)
				return removeChild(child);
			return null;
		}

		[Inspectable(defaultValue="<TextFlow editingMode='readSelect' horizontalScrollPolicy='auto' verticalScrollPolicy='auto' paddingTop='5' paddingBottom='5' paddingLeft='5' paddingRight='5' xmlns:flow='http://ns.adobe.com/textLayout/2008'><flow:p><flow:span>TextLayout Sample Text.</flow:span></flow:p></TextFlow>")]
		/**
         	* The XML Markup that represents the text and its formatting.
         	*
         	* @playerversion Flash 10
	 	* @playerversion AIR 1.5
	 	* @langversion 3.0
	 	*/
	 
		public function set xmlText (val:String):void
		{
			var originalWhitespace:Boolean = XML.ignoreWhitespace;
			var originalProcessingInstructions:Boolean = XML.ignoreProcessingInstructions;
			try
			{
				XML.ignoreProcessingInstructions = false;		
				XML.ignoreWhitespace = false;
				xml = new XML(val);				
			}			
			finally
			{
				XML.ignoreWhitespace = originalWhitespace;
				XML.ignoreProcessingInstructions = originalProcessingInstructions;
			}	
						
			parseXML();
		}
		
		public function get xmlText():String
		{
			var mode:String = EditingMode.READ_ONLY;
			if (textFlow.interactionManager) {
				if (textFlow.interactionManager is EditManager)
					mode = EditingMode.READ_WRITE;
				if (textFlow.interactionManager is SelectionManager)
					mode = EditingMode.READ_SELECT;
			}
			xml.@editingMode = mode;
			xml.@verticalScrollPolicy = _containerController.verticalScrollPolicy;
			xml.@horizontalScrollPolicy = _containerController.horizontalScrollPolicy;
			
			return xml.toString();
		}
		
		[Inspectable(defaultValue="auto",enumeration="on,off,auto")]
		/**
         	 * Gets or sets a value that indicates the state of the horizontal scroll
		 * bar. A value of <code>ScrollPolicy.ON</code> indicates that the horizontal
		 * scroll bar is always on; a value of <code>ScrollPolicy.OFF</code> indicates
		 * that the horizontal scroll bar is always off; and a value of <code>ScrollPolicy.AUTO</code>
		 * indicates that its state automatically changes based on the amount and size of
		 * the content.
		 *
		 * @default ScrollPolicy.AUTO
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0
		 *
		 * @see flashx.textLayout.container.ScrollPolicy
		 */
		 
		public function get horizontalScrollPolicy():String
		{
			return _containerController.horizontalScrollPolicy;
		}
		
		public function set horizontalScrollPolicy(scrollPolicy:String):void
		{
			if (scrollPolicy != _containerController.horizontalScrollPolicy) {
				_containerController.horizontalScrollPolicy = scrollPolicy;
				xml.@horizontalScrollPolicy = scrollPolicy;
				calculateAvailableSize();
			}
		}
		
		[Inspectable(defaultValue="auto",enumeration="on,off,auto")]
		
		/**
                 * Gets or sets a value that indicates the state of the vertical scroll
		 * bar. A value of <code>ScrollPolicy.ON</code> indicates that the vertical
		 * scroll bar is always on; a value of <code>ScrollPolicy.OFF</code> indicates
		 * that the vertical scroll bar is always off; and a value of <code>ScrollPolicy.AUTO</code>
		 * indicates that its state automatically changes based on the amount and size of
		 * the content.
		 *
		 * @default ScrollPolicy.AUTO
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0
		 * 
		 * @see flashx.textLayout.container.ScrollPolicy
		 */
		 
		public function get verticalScrollPolicy():String
		{
			return _containerController.verticalScrollPolicy;
		}

		public function set verticalScrollPolicy(scrollPolicy:String):void
		{
			if (scrollPolicy != _containerController.verticalScrollPolicy) {
				_containerController.verticalScrollPolicy = scrollPolicy;
				xml.@verticalScrollPolicy = scrollPolicy;
				calculateAvailableSize();
			}
		}

		/**
         	 * Returns a string indicating the TextLayout build number. You can use the build number 
         	 * to identify the version of the component that you're using.
		 *
		 * @return the build number of the TextLayout component.
		 *
		 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0
		 */
		 
		public function getBuildNumber(): String
		{
			return BuildInfo.kBuildNumber;
		}
		
		/** @private */
		static private function defaultXFL() : String
		{
			return DEFAULT_XFL;
		}
		
		/** @private */
		public override function set width(w:Number) : void
		{
			super.width = w;
			_containerController.setCompositionSize(width, height);
			calculateAvailableSize();
		}

		/** @private */
		public override function set height(h:Number) : void
		{
			super.height = h;
			_containerController.setCompositionSize(width, height);
			calculateAvailableSize();
		}
		
		/** @private */
		public override function setSize(w:Number, h:Number) : void
		{
			super.setSize(w, h);
			if (_containerController) {
				_containerController.setCompositionSize(w, h);
				calculateAvailableSize();
			}
		}

		/** @private */
		protected function parseXML():void
		{
			// remove any existing children
			while (numChildren)
				removeChildAt(0);
							
			// parse the xml
			var editingMode:String = EditingMode.READ_SELECT;
			if (xml.@editingMode != undefined)
				editingMode = xml.@editingMode;
				
			var _textFlow:TextFlow = TextFilter.importToFlow(xml, TextFilter.TEXT_LAYOUT_FORMAT);

			// set the container/controller
			_flowComposer = _textFlow.flowComposer;
			_container = new Sprite();
			_containerController = new DisplayObjectContainerController(_container);
			_flowComposer.addController(_containerController);
			
			// interactionManager
			var im:ISelectionManager = null
			if (editingMode == EditingMode.READ_SELECT)
				im = new SelectionManager();
			if (editingMode == EditingMode.READ_WRITE)
				im = new EditManager(new UndoManager());
			xml.@editingMode = editingMode;
				
			_containerController.verticalScrollPolicy = xml.@verticalScrollPolicy;
			_containerController.horizontalScrollPolicy = xml.@horizontalScrollPolicy;
			
			_textFlow.interactionManager = im;


			// set the compose size to the size of the UIComponent.
			_containerController.setCompositionSize(width, height);

			// this is a scrollable container. And, super.parseXML set the ScrollPolicy to OFF, so, reset it now to AUTO, the default.
//			_containerController.verticalScrollPolicy = ScrollPolicy.AUTO;
//			_containerController.horizontalScrollPolicy = ScrollPolicy.AUTO;
			addChild(_verticalScrollBar);
			addChild(_horizontalScrollBar);
			_clipContent = new Sprite();
			_clipContent.scrollRect = new Rectangle(0, 0, width, height);
			addChild(_clipContent);
			_clipContent.addChild(_container);
			_verticalScrollBar.addEventListener(flashx.textLayout.events.ScrollEvent.SCROLL,handleVScroll, false, 0, true);
			_horizontalScrollBar.addEventListener(flashx.textLayout.events.ScrollEvent.SCROLL,handleHScroll, false, 0, true);
			
			_containerController.textFlow.addEventListener(CompositionCompletionEvent.COMPOSITION_COMPLETE, composeComplete, false, 0, true);
			_containerController.textFlow.addEventListener(flashx.textLayout.events.ScrollEvent.SCROLL, controllerScrolled, false, 0, true);
			_containerController.textFlow.addEventListener(StatusChangeEvent.INLINE_GRAPHIC_STATUS_CHANGED,recomposeOnLoadComplete,false,0,true);			
		}

		/** @private */
		override protected function draw():void
		{
			var needDrawLayout:Boolean = isInvalid(InvalidationType.SIZE, InvalidationType.STATE);
			if (textFlow) {
				textFlow.flowComposer.updateAllContainers();
			}
			super.draw();
			if (needDrawLayout)
				drawLayout();
		}

		/** @private */
		private function positionScrollBars():void
		{
			if (_verticalScrollBar) {
				_verticalScrollBar.x = width - ScrollBar.WIDTH;
				_verticalScrollBar.y = 0;
				_verticalScrollBar.height = _horizontalScrollBar.visible ? height - ScrollBar.WIDTH : height;
				_verticalScrollBar.width = ScrollBar.WIDTH;
			}

			if (_horizontalScrollBar) {
				_horizontalScrollBar.x = 0;
				_horizontalScrollBar.y = height - ScrollBar.WIDTH;
				_horizontalScrollBar.width = _verticalScrollBar.visible ? width - ScrollBar.WIDTH : width;
				_horizontalScrollBar.height = ScrollBar.WIDTH;
			}
		}
		
		/** @private */
		override protected function configUI():void
		{
			super.configUI();

			// set up vertical scroll bar:
			_verticalScrollBar = new ScrollBar();
			_verticalScrollBar.enabled = false;
			copyStylesToChild(_verticalScrollBar, SCROLL_BAR_STYLES);

			// set up horizontal scroll bar:
			_horizontalScrollBar = new ScrollBar();
			_horizontalScrollBar.direction = ScrollBarDirection.HORIZONTAL;
			_horizontalScrollBar.enabled = false;
			copyStylesToChild(_horizontalScrollBar, SCROLL_BAR_STYLES);
			
			positionScrollBars();
		}

		// callfack from textFlow -- the containerController handled a scroll, so we need to update our
		// scroll bars to reflect the change.
		/** @private */
		protected function controllerScrolled(event:Event):void
		{
			_verticalScrollBar.removeEventListener(flashx.textLayout.events.ScrollEvent.SCROLL, handleVScroll);
			_verticalScrollBar.scrollPosition = _containerController.verticalScrollPosition;
			setVScrollProperties();
			_verticalScrollBar.addEventListener(flashx.textLayout.events.ScrollEvent.SCROLL, handleVScroll, false, 0, true);

			_horizontalScrollBar.removeEventListener(flashx.textLayout.events.ScrollEvent.SCROLL, handleHScroll);
			_horizontalScrollBar.scrollPosition = _containerController.horizontalScrollPosition;
			setHScrollProperties();
			_horizontalScrollBar.addEventListener(flashx.textLayout.events.ScrollEvent.SCROLL, handleHScroll, false, 0, true);
		}
		

		// callback from textFlow that a inline graphic has been loaded
		/** @private */
		private function recomposeOnLoadComplete(e:StatusChangeEvent):void
		{
			if (e.element.getTextFlow() == _containerController.textFlow && e.status == InlineGraphicElementStatus.SIZE_PENDING)
				_containerController.textFlow.flowComposer.updateAllContainers();
		}		

		// callback from textFlow that a recompose operation has completed.		
		/** @private */
		protected function composeComplete(event:CompositionCompletionEvent):void
		{
			drawLayout();
		}
		
		// callback function for handling when our scrollbars have been pressed
		/** @private */
		protected function handleHScroll(event:fl.events.ScrollEvent):void
		{
			_containerController.horizontalScrollPosition += event.delta;
			setHScrollProperties();
		}
		
		// callback function for handling when our scrollbars have been pressed
		/** @private */
		protected function handleVScroll(event:fl.events.ScrollEvent):void
		{
			_containerController.verticalScrollPosition += event.delta;
			setVScrollProperties();
		}

		/**	
         	* @private (protected)
         	*
         	* @langversion 3.0
         	* @playerversion Flash 10.0.0.0
		*/
		
		protected function setStyles():void
		{
			copyStylesToChild(_verticalScrollBar,SCROLL_BAR_STYLES);
			copyStylesToChild(_horizontalScrollBar,SCROLL_BAR_STYLES);
		}

		/** @private */
		private function setVScrollProperties():void
		{
			if (!_verticalScrollBar.enabled)
				return;
			_verticalScrollBar.lineScrollSize = 1 * _containerController.textFlow.configuration.scrollDragPixels;
			_verticalScrollBar.setScrollProperties(_containerController.compositionHeight, 0, 
				_containerController.contentHeight - _containerController.compositionHeight,
				_containerController.textFlow.configuration.scrollPagePercentage * _containerController.compositionHeight);
		}
		
		/** @private */
		private function setHScrollProperties():void
		{
			if (!_horizontalScrollBar.enabled)
				return;
			_horizontalScrollBar.lineScrollSize = 1 * _containerController.textFlow.configuration.scrollDragPixels;
			var wmode:String = _containerController.rootElement.computedContainerFormat.blockProgression;
			var minScroll:Number = 0;
			var maxScroll:Number = _containerController.contentWidth - _containerController.compositionWidth;
			// vertical text
			if (wmode == BlockProgression.RL) {
				minScroll = -maxScroll;
				maxScroll = 0;
			}
			_horizontalScrollBar.setScrollProperties(_containerController.compositionWidth, minScroll, maxScroll,
				_containerController.textFlow.configuration.scrollPagePercentage * _containerController.compositionWidth);
		}
		
		/** @private */
		protected function calculateAvailableSize():void
		{
			var compW:Number = _containerController.compositionWidth;
			var compH:Number = _containerController.compositionHeight;
			
			var vScroll:Boolean = (_containerController.verticalScrollPolicy == flashx.textLayout.container.ScrollPolicy.ON) ||
				(_containerController.verticalScrollPolicy == flashx.textLayout.container.ScrollPolicy.AUTO && _container.scrollRect != null && _containerController.contentHeight > _containerController.compositionHeight);

			var hScroll:Boolean = (_containerController.horizontalScrollPolicy == flashx.textLayout.container.ScrollPolicy.ON) ||
				(_containerController.horizontalScrollPolicy == flashx.textLayout.container.ScrollPolicy.AUTO && _container.scrollRect != null && _containerController.contentWidth > _containerController.compositionWidth);

			_verticalScrollBar.visible = visible && vScroll;
			_horizontalScrollBar.visible = visible && hScroll;

			var w:Number = _verticalScrollBar.visible ? width - ScrollBar.WIDTH : width;
			var h:Number = _horizontalScrollBar.visible ? height - ScrollBar.WIDTH : height;
			if (compW != w || compH != h) {
				_containerController.setCompositionSize(w, h);
				textFlow.flowComposer.updateAllContainers();
				invalidate(InvalidationType.SIZE);
			}	
		}

		/** @private */
		protected function drawLayout():void
		{
			_clipContent.scrollRect.width = width;
			_clipContent.scrollRect.height = height;

			calculateAvailableSize();
			positionScrollBars();

			_verticalScrollBar.enabled = enabled && _container.scrollRect && _containerController.contentHeight > _containerController.compositionHeight;
			setVScrollProperties();
			_verticalScrollBar.drawNow();

			_horizontalScrollBar.enabled = enabled && _container.scrollRect && _containerController.contentWidth > _containerController.compositionWidth;
			setHScrollProperties();
			_horizontalScrollBar.drawNow();
		}
		
		/**
         	 * The TextFlow object that is responsible for managing the text content.
         	 *
          	 * @playerversion Flash 10
		 * @playerversion AIR 1.5
		 * @langversion 3.0
		 *
		 * @see flashx.textLayout.elements.TextFlow
		 */
		 
		public function get textFlow():TextFlow
		{
			return _containerController.textFlow;
		}
		
	}
}
