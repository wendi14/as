package hcxm.cn.media.ImgCase.control
{
	public interface IImageControl
	{
		function set imageSource(va):void;//设置展示的case
		function get imageSource();
		function goto(n):void;//让图像播到第几个
		function setBtn(n:int):void;//现在播到第n个了,让里面的按纽的状态跳到正在播的状态
	}
}