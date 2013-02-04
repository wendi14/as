package hcxm.cn.util {
	
	/**
	* ...
	* @author Default
	*/
	public class ColRow {
		private var total
		private var perCol;
		private var rowTotal;
		/**
		 * 构造函数
		 * @param	_total 总共有几个
		 * @param	_perCol 每行几个
		 */
		public function ColRow(_total:Number,_perCol) {
			total = _total;
			perCol = _perCol;
			
		}
		/**
		 * 最后返回一组数组[0,0][1,0]
		 * @return 第一是x的位置，第二是y的位置
		 */
		public function start():Array {
			rowTotal=Math.ceil(total/perCol)
			var res = [];
			var k = 0;
			var x = 0;
			for (var i:int = 0; i < total; i++) {
				
				if (x == perCol ) {
					x = 0;
					k++;
				}
				res[i] = [x, k];
				x++;
			}
			return res;
		}
		
	}
	
}