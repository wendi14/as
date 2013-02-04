package com.xmaser.bitmap
{
    import flash.display.*;
    import flash.geom.*;

    public class BitmapManager extends Object
    {

        public function BitmapManager()
        {
            return;
        }// end function

        public static function resizeBitmapData(param1:BitmapData, param2:Number) : BitmapData
        {
            var _loc_3:* = new BitmapData(Math.round(param1.width * param2), Math.round(param1.height * param2));
            var _loc_4:* = new Matrix(_loc_3.width / param1.width, 0, 0, _loc_3.height / param1.height, 0, 0);
            var _loc_5:* = new ColorTransform();
            _loc_3.draw(param1, _loc_4, _loc_5, null, null, true);
            return _loc_3;
        }// end function

        public static function resampleBitmapData(param1:BitmapData, param2:Number) : BitmapData
        {
            var _loc_3:BitmapData = null;
            var _loc_4:Number = NaN;
            if (param2 >= 1)
            {
                return resizeBitmapData(param1, param2);
            }
            _loc_3 = param1.clone();
            _loc_4 = 1;
            do
            {
                
                if (param2 < 0.5 * _loc_4)
                {
                    _loc_3 = resizeBitmapData(_loc_3, 0.5);
                    _loc_4 = 0.5 * _loc_4;
                    continue;
                }
                _loc_3 = resizeBitmapData(_loc_3, param2 / _loc_4);
                _loc_4 = param2;
            }while (_loc_4 != param2)
            return _loc_3;
        }// end function

        public static function reduceBitmapData(param1:BitmapData, param2:Number) : BitmapData
        {
            var _loc_3:* = new BitmapData(Math.round(param1.width * param2), Math.round(param1.height * param2));
            var _loc_4:* = new Matrix(_loc_3.width / param1.width, 0, 0, _loc_3.height / param1.height, 0, 0);
            _loc_3.draw(param1, _loc_4);
            return _loc_3;
        }// end function

    }
}
