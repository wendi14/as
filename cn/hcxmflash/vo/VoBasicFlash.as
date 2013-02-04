package cn.hcxmflash.vo 
{
	import cn.hcxmflash.utils.DescribeClass;
	/**
	 * ...
	 * @author hcxmflash.cn
	 */
	public class VoBasicFlash extends Object
	{
		
		public function VoBasicFlash() 
		{
			
		}
		public function buildFromObject(o:Object):void
		{
			var thisOb:Object = DescribeClass.describe_flash(this);
			for (var name:String in thisOb) 
			{
				this[name] = o[name];
			}
		}
		public function buildFormXMLAttr(xml:XML):void
		{
			var thisOb:Object = DescribeClass.describe_flash(this);
			for (var name:String in thisOb) 
			{
				try 
				{
					this[name] = xml.@[name]
				}catch (err:Error)
				{
					trace( "err : " + err );
					
				}
			}
		}
		public function buildFormXML(xml:XML):void
		{
			var thisOb:Object = DescribeClass.describe_flash(this);
			for (var name:String in thisOb) 
			{
				
				
				try 
				{
					
					this[name] = xml[name].text();
					if (typeof(this[name]) == 'boolean')
					{
						if ( xml[name].text() == "true"||Number(xml[name].text())>0)
						{
							this[name] = true;	
						}else
						{
							this[name] = false;
						}
					}
					
					//trace("this[name] : " + this[name]);
				}catch (err:Error)
				{
					
				}
			
				
			}
				
		}
		public function cloneToObject():Object
		{
			var thisOb:Object = DescribeClass.describe_flash(this);
			var resObj:Object = { };
			
			for (var name:String in thisOb) 
			{
				resObj[name] = this[name];
			}
			return resObj;
			
		}
		public function toString():String
		{
			var thisOb:Object = DescribeClass.describe_flash(this);
			var str:String = '{';
			for (var name:String in thisOb) 
			{
				//this[name] = thisOb[name];
				str += "|"+name +":"+ this[name];
			}
			str += "}";
			return str;
		}
		
	}

}