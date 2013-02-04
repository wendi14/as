package hcxm.cn.controls.page.model
{
	[Bindable]
	public class ModelPage
	{
		private static var _ins
		public function ModelPage()
		{
		}
		public static function getIns():ModelPage
		{
			if(_ins==null)_ins=new ModelPage();
			return _ins;
		}
		public var Count:int;//总的记录;
		public var PageSize:int=20;//默认20条每页
		public var PageTotal:int=1;//总页数;
		public var PageNow:int=1;//当前页;
		
		public var PageArrary:Array=[1];
		
		public var prevEnabled:Boolean=false;
		public var nextEnabled:Boolean=false;
		public var firstEnabled:Boolean=false;
		public var lastEnabled:Boolean=false;
		/**
		 * 初始化
		 * @param cou
		 * */
		public function init(cou):void
		{
			this.Count=cou
			var int1=int(this.Count/this.PageSize);
			if(this.Count%this.PageSize>0){int1+=1};
			this.PageTotal=int1;
			this.PageArrary=[]
			var ta:Array=[];
			this.checkAllEnabled()
			for(var i:int=1;i<=this.PageTotal;i++)
			{
				ta.push(i);
			}
			this.PageArrary=ta;			
		}
		public function checkAllEnabled():void
		{
			getNextEnabled();
			getPrevEnabled();
			getFirstEnabled();
		}
		public function getNextEnabled():void
		{
			if(PageNow<PageTotal)
			{
				nextEnabled=true;
			}else
			{
				 nextEnabled=false;;
			}
		}
		public function getPrevEnabled():void
		{
			if(PageNow>1)
			{
				prevEnabled=true;;
			}else
			{
				prevEnabled=false;
			}
		}
		public function getFirstEnabled():void
		{
			if(PageNow>1)
			{
				firstEnabled=true;
			}else
			{
				firstEnabled=false;
			}
		}
		public function getlastEnabled():void
		{
			if(PageNow<PageTotal)
			{
				lastEnabled=true;
			}else
			{
				lastEnabled=false;
			}
		}
	}
}