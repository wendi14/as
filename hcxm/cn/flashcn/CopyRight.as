package hcxm.cn.flashcn
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import hcxm.cn.mouse.Mouse_Right_Menu;
	
	public class CopyRight
	{
		public function CopyRight(root)
		{
			var mr:Mouse_Right_Menu=new Mouse_Right_Menu(root);
			mr.addItem("厦门火柴工作坊 制作", _gomyhome);
			
		}
		private function _gomyhome(e):void
		{
			flash.net.navigateToURL(new URLRequest("http://www.hcxmflash.cn"));
		}
	}
}