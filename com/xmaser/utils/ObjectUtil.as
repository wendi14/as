package com.xmaser.utils 
{
	/**
	 * ...
	 * @author wdc
	 */
	public class ObjectUtil 
	{
		
		
		/**
		 * 获取 Object 的长度
		 * @param	obj
		 * @return
		 */
		public static function getLength(obj:Object):int
		{
			var len:int = 0;
			for (var name:String in obj) 
			{
				len++;
			}
			
			return len;
		}
		
		/**
		 * 删除对象中的某个值 ，会修改 obj 
		 * @param	obj
		 * @param	index
		 * @return	被删除的那个值
		 */
		public static function removeAtIndex(obj:Object, index:int):Object
		{
			var i:int = 0;
			var res:Object = { };
			var removed:Object
			for (var name:String in obj) 
			{
				if (index == i)
				{
					removed=obj[name];
				}else
				{
					res[name] = obj[name];
				}
				i++;
			} 
			for (var name2:String in obj) 
			{
				obj[name2] = null;
			}
			for  (var name3:String in res) 
			{
				obj[name3] = res[name3];
			}
			return removed;
		}
		
		public static function getAtIndex(obj:Object,index:int):Object
		{
			var len:int = 0;
			for (var name:String in obj) 
			{
				if (index == len)
				{
					
					return obj[name];
				}
			} 
			return null;
		}
		
		public static function getLast(obj:Object):Object
		{
			return getAtIndex(obj, getLength(obj) - 1);
		}
		
		public static function getFirst(obj:Object):Object
		{
			return getAtIndex(obj, 0);
		}
		
		/**
		 * 克隆一个
		 * @param	obj
		 * @return
		 */
		public static function clone(obj:Object):Object
		{
			var res:Object = { };
			for (var name:String in obj) 
			{
				res[name] = obj[name];
			}
			return res;
		}
		
		/**
		 * 将多个Object  合并成一个 Object ;
		 * @param	...args
		 * @return
		 */
		public static function join(...args):Object 
		{
			var res:Object = { };
			for (var i:int = 0; i < args.length; i++) 
			{
				var item: Object= args[i];
				for (var name:String in item) 
				{
					res[name] = item[name];
				}
			}
			return res;
		}
		public static function sortByDescending(obj:Object):Array
		{
			
			var r:Array = [];
		var arr:Array=[]
			for (var name1:String in obj) 
			{
				//trace(name1);
				r.push(name1);
			}
			r.sort();
			
			for (var i:int = 0; i < r.length; i++) 
			{
				var item:Object = obj[r[i]];
				arr.push(item);
			}
			return arr;
		}
	}

}