package cn.hcxmflash.managers
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	

	public class PopUpManager
	{
	
    public static function addPopUp(popUp:DisplayObject, parent:DisplayObjectContainer):void
    {
    	parent.addChild(popUp);
    }
    
  
    public static function removePopUp(popUp:DisplayObject):void
    {
		popUp.parent.removeChild(popUp);
    }
	}
}