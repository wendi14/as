package cn.hcxmflash.component
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author 小火柴
	 */
	public class Test extends Sprite
	{
		
		public function Test() 
		{
			
			var b:ButtonComponent = new ButtonComponent(null, 4,"<font color='#ff0000'>my first button</font>");
			
			addChild(b)
			b.disabled = true;
			
			
			b.x=100
			addChild(new LabelComponent("label",'',12,0,false,b))
		}
		
	}

}