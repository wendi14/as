package cn.hcxmflash.utils 
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class Singleton  extends EventDispatcher
	{
		static private var _insDict:Dictionary=new Dictionary();
		
		public function Singleton() 
		{
			var ca:Class = getDefinitionByName(getQualifiedClassName(this)) as Class;
			if (_insDict[ca])
			{
				throw new Error("已实例化"+this)
			}else
			{
				_insDict[ca] = this;
			}
		}
		public static function getIns(cla:Class):*
		{
			if (_insDict[cla]==null) 
			{
				
				_insDict[cla] =  new cla();
			}else 
			{
				return _insDict[cla];
			}
			return _insDict[cla];
		}
		
	}

}