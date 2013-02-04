package com.xmaser.f3d.a3d.utils 
{
	import alternativa.engine3d.loaders.ParserCollada;
	import alternativa.engine3d.objects.Mesh;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class ModelLoader extends EventDispatcher 
	{
		private var _loader:URLLoader;
		private var _baseURL:String;
		private var _mesh:Mesh;
		
		public function ModelLoader(url:String,baseURL:String="") 
		{
			this._baseURL = baseURL;
			_loader = new URLLoader(new URLRequest(url));
			_loader.dataFormat = URLLoaderDataFormat.BINARY;
			_loader.addEventListener(Event.COMPLETE, __COMPLETE);
			
			
		}
		
		private function __COMPLETE(e:Event):void 
		{
			var d:*= e.target.data;
			
			var parser:ParserCollada = new ParserCollada();
			parser.parse(XML(d),_baseURL);
			
			for each (var item:* in parser.objects) 
			{
				//trace( "item : " + item );
				if (item is Mesh) 
				{
					_mesh = item;
				}
			}
			dispatchEvent(e);
		}
		
		public function get mesh():Mesh 
		{
			return _mesh;
		}
		
	}

}