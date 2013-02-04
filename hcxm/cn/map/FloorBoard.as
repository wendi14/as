package hcxm.cn.map {
	import flash.display.Sprite
	/**
	* ...
	* @author DefaultUser (Tools -> Custom Arguments...)
	*/
	public class FloorBoard extends Sprite{
		/**
		 * 构建菱形地板
		 * @param	xNum	横几个(斜上)
		 * @param	yNum	竖几个(斜下)
		 * @param	squ	要用来做为地板的影片
		 */
		private var _containerMc:Sprite
		public function FloorBoard(xNum:Number, yNum:Number, squ) {
			draw(xNum, yNum, squ)
		}
		private function draw(xNum:Number, yNum:Number, squ) {
			var hen = xNum;
			var shu = yNum;
			var sp:Sprite = new Sprite()
			addChild(sp);
			this._containerMc = sp;
			sp.x=sp.y=200
			for (var i:int = 0; i < hen; i++) {
				for (var j:int = 0; j <shu ; j++) {
					var sq = new squ()
					sp.addChild(sq);
					sq.tt.text = i + ":" + j;
					sq.x =sq.width/2 *j+i*sq.width/2;
					sq.y = -sq.height / 2 * j+i*sq.height/2;
				}
			}
		}
		/**
		 * 取得用来装载方格的影片(容器 );
		 */
		public function get container() { return _containerMc; }
	}
}
