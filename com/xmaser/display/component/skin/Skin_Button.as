package com.xmaser.display.component.skin 
{
	/**
	 * ...
	 * @author 小火柴
	 */
	public class Skin_Button 
	{
		public var normal:Class
		public var over:Class
		public var down:Class
		public var selected:Class
		public var disabled:Class
		
		public var selected_normal:Class;
		public var selected_over:Class;
		public var selected_down:Class;
		public var selected_selected:Class;
		public var selected_disabled:Class;
		public function Skin_Button(n:*=null,o:*=null,down:*=null,s:*=null,dis:*=null,s_n:*=null,s_o:*=null,s_d:*=null,s_s:*=null,s_dis:*=null) 
		{
			if (n is Class)
			{
				this.normal = n;
				this.over = o;
				this.down = down;
				this.selected = s;
				this.disabled = dis;
				
				if (!this.over)
				{
					this.over = n;
				}
				if (!this.down) 
				{
					this.down = n;
				}
				if (!this.selected) 
				{
					this.selected = n;
				}
				if (!this.disabled)
				{
					this.disabled = n;
				}
				
			}
			this.selected_normal = s_n;
			this.selected_over = s_o;
			this.selected_down = s_d;
			this.selected_selected = s_s;
			this.selected_disabled = s_dis;
		}
		
	}

}