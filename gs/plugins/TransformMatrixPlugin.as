/**
 * VERSION: 0.91
 * DATE: 6/11/2009
 * ACTIONSCRIPT VERSION: 3.0 
 * UPDATES & MORE DETAILED DOCUMENTATION AT: http://www.TweenMax.com
 **/
package gs.plugins {
	import flash.display.*;
	import flash.geom.Matrix;
	import flash.geom.Transform;
	
	import gs.*;
/**
 * TransformMatrixPlugin allows you to tween a DisplayObject's transform.matrix values directly 
 * (<code>a, b, c, d, tx, and ty</code>) or use common properties like <code>x, y, scaleX, scaleY, skewX, skewY,</code> and <code>rotation</code>.
 * <br /><br />
 * 
 * <b>USAGE:</b><br /><br />
 * <code>
 * 		import gs.TweenLite; <br />
 * 		import gs.plugins.TransformMatrixPlugin; <br />
 * 		TweenPlugin.activate([TransformMatrixPlugin]); //activation is permanent in the SWF, so this line only needs to be run once.<br /><br />
 * 
 * 		TweenLite.to(mc, 1, {transformMatrix:{x:50, y:300, scaleX:2, scaleY:2}}); <br /><br />
 * 		
 * 		//-OR-<br /><br />
 * 
 * 		TweenLite.to(mc, 1, {transformMatrix:{tx:50, ty:300, a:2, d:2}}); <br /><br />
 * 
 * </code>
 * 
 * <b>Copyright 2009, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 */
	public class TransformMatrixPlugin extends TweenPlugin {
		/** @private **/
		public static const VERSION:Number = 0.91;
		/** @private **/
		public static const API:Number = 1.0; //If the API/Framework for plugins changes in the future, this number helps determine compatibility
		/** @private **/
		private static const _DEG2RAD:Number = Math.PI / 180;
		
		/** @private **/
		protected var _transform:Transform;
		/** @private **/
		protected var _matrix:Matrix;
		/** @private **/
		protected var _txStart:Number;
		/** @private **/
		protected var _txChange:Number = 0;
		/** @private **/
		protected var _tyStart:Number;
		/** @private **/
		protected var _tyChange:Number = 0;
		/** @private **/
		protected var _aStart:Number;
		/** @private **/
		protected var _aChange:Number = 0;
		/** @private **/
		protected var _bStart:Number;
		/** @private **/
		protected var _bChange:Number = 0;
		/** @private **/
		protected var _cStart:Number;
		/** @private **/
		protected var _cChange:Number = 0;
		/** @private **/
		protected var _dStart:Number;
		/** @private **/
		protected var _dChange:Number = 0;
		
		/** @private **/
		public function TransformMatrixPlugin() {
			super();
			this.propName = "transformMatrix";
			this.overwriteProps = ["x","y","scaleX","scaleY","transformMatrix","transformAroundPoint","transformAroundCenter"];
		}
		
		/** @private **/
		override public function onInitTween($target:Object, $value:*, $tween:TweenLite):Boolean {
			_transform = $target.transform as Transform;
			_matrix = _transform.matrix;
			var matrix:Matrix = _matrix.clone();
			_txStart = matrix.tx;
			_tyStart = matrix.ty;
			_aStart = matrix.a;
			_bStart = matrix.b;
			_cStart = matrix.c;
			_dStart = matrix.d;
			
			if ("x" in $value) {
				_txChange = (typeof($value.x) == "number") ? $value.x - _txStart : Number($value.x);
			} else if ("tx" in $value) {
				_txChange = $value.tx - _txStart;
			}
			if ("y" in $value) {
				_tyChange = (typeof($value.y) == "number") ? $value.y - _tyStart : Number($value.y);
			} else if ("ty" in $value) {
				_tyChange = $value.ty - _tyStart;
			}
			if ("a" in $value) {
				_aChange = $value.a - _aStart;
			}
			if ("b" in $value) {
				_bChange = $value.b - _bStart;
			}
			if ("c" in $value) {
				_cChange = $value.c - _cStart;
			}
			if ("d" in $value) {
				_dChange = $value.d - _dStart;
			}
			
			if (("rotation" in $value) || ("scale" in $value) || ("scaleX" in $value) || ("scaleY" in $value) || ("skewX" in $value) || ("skewY" in $value)) {
				var ratioX:Number, ratioY:Number;
				var scaleX:Number = Math.sqrt(matrix.a * matrix.a + matrix.b * matrix.b); //Bugs in the Flex framework prevent DisplayObject.scaleX from working consistently, so we must determine it using the matrix.
				if (matrix.a < 0 && matrix.d > 0) {
					scaleX = -scaleX;
				}
				var scaleY:Number = Math.sqrt(matrix.c * matrix.c + matrix.d * matrix.d); //Bugs in the Flex framework prevent DisplayObject.scaleY from working consistently, so we must determine it using the matrix.
				if (matrix.d < 0 && matrix.a > 0) {
					scaleY = -scaleY;
				}
				if ("rotation" in $value) {
					matrix.tx = 0;
					matrix.ty = 0;
					if (typeof($value.rotation) == "number") {
						var angle:Number = Math.atan2(matrix.b, matrix.a); //Bugs in the Flex framework prevent DisplayObject.rotation from working consistently, so we must determine it using the matrix
						if (matrix.a < 0 && matrix.d >= 0) {
							angle += (angle <= 0) ? Math.PI : -Math.PI;
						}
						matrix.rotate(($value.rotation * _DEG2RAD) - angle);
					} else {
						matrix.rotate(Number($value.rotation) * _DEG2RAD);
					}
				}
				if ("scale" in $value) {
					ratioX = Number($value.scale) / scaleX;
					ratioY = Number($value.scale) / scaleY;
					if (typeof($value.scale) != "number") { //relative value
						ratioX += 1;
						ratioY += 1;
					}
				} else {
					if ("scaleX" in $value) {
						ratioX = Number($value.scaleX) / scaleX;
						if (typeof($value.scaleX) != "number") { //relative value
							ratioX += 1;
						}
					}
					if ("scaleY" in $value) {
						ratioY = Number($value.scaleY) / scaleY;
						if (typeof($value.scaleY) != "number") { //relative value
							ratioY += 1;
						}
					}
				}
				if ("skewX" in $value) {
					if (typeof($value.skewX) == "number") {
						matrix.c = Math.tan(0 - ($value.skewX * _DEG2RAD));
					} else {
						matrix.c += Math.tan(0 - (Number($value.skewX) * _DEG2RAD));
					}
				}
				if ("skewY" in $value) {
					if (typeof($value.skewY) == "number") {
						matrix.b = Math.tan($value.skewY * _DEG2RAD);
					} else {
						matrix.b += Math.tan(Number($value.skewY) * _DEG2RAD);
					}
				}
				if (ratioX) {
					matrix.a *= ratioX;
					matrix.b *= ratioX;
				}
				if (ratioY) {
					matrix.c *= ratioY;
					matrix.d *= ratioY;
				}
				_aChange = matrix.a - _aStart;
				_bChange = matrix.b - _bStart;
				_cChange = matrix.c - _cStart;
				_dChange = matrix.d - _dStart;
			}
			
			return true;
		}
		
		/** @private **/
		override public function set changeFactor($n:Number):void {
			if (_aChange) {
				_matrix.a = _aStart + ($n * _aChange);
			}
			if (_bChange) {
				_matrix.b = _bStart + ($n * _bChange);
			}
			if (_cChange) {
				_matrix.c = _cStart + ($n * _cChange);
			}
			if (_dChange) {
				_matrix.d = _dStart + ($n * _dChange);
			}
			if (_txChange) {
				_matrix.tx = _txStart + ($n * _txChange);
			}
			if (_tyChange) {
				_matrix.ty = _tyStart + ($n * _tyChange);
			}
			_transform.matrix = _matrix;
		}

	}
}