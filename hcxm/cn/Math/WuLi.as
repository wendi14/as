package hcxm.cn.Math {
	
	/**
	* ...
	* @编写者： wendi(小火柴)
						http://www.hcxm.cn
	*/
	public class WuLi {
		
		public function WuLi() {
			
		}
		/**
		 * 碰撞之后的反弹力方法1  返回的值用于物体的速度
		 * @param	ball1M 第一个球的质量
		 * @param	ball1V 第一个球的速度
		 * @param	ball2M 第二个球的质量
		 * @param	ball2V 第二个球的速度
		 */
		public static function ZhuangBetweenTwo(ball1M,ball1V,ball2M,ball2V):Array {
			var arr:Array = [];
			var vx1 = ((ball1M - ball2M) * ball1V + 2 * ball2M * ball2V) / (ball1M + ball2M);
			var vx2 = ((ball2M - ball1M) * ball2V + 2 * ball1M * ball1V) / (ball1M + ball2M);
			arr.push(vx1)
			arr.push(vx2);
			return arr
		}
		/**
		 * 碰撞之后的反弹力方法2
		 * @param	ball1M 第一个球的质量
		 * @param	ball1V 第一个球的速度
		 * @param	ball2M 第二个球的质量
		 * @param	ball2V 第二个球的速度
		 */
		public static function ZhuangBetweenTwo2(ball1M,ball1V,ball2M,ball2V):Array {
			var arr:Array = [];
			var vxTotal = ball1V - ball2V;
			var vx1 = ((ball1M - ball2M) * ball1V + 2 * ball2M * ball2V) / (ball1M + ball2M);
			//var vx2 = ((ball2M - ball1M) * ball2V + 2 * ball1M * ball1V) / (ball1M + ball2M);
			var vx2 = vxTotal + vx1;
			arr.push(vx1)
			arr.push(vx2);
			return arr
		}		
		
	}
	
}