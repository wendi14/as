package hcxm.cn.net.vo
{
	public class IpVO
	{
		public var IP:String;
		public var location:String;
		public var type:String;//电信，网通, adsl
		public function IpVO(ip:String="",lo:String="",ty:String="")
		{
			this.IP=ip
			this.location=lo;
			this.type=ty;
		}

	}
}