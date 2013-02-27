package com.xmaser.utils 
{

    public class StringUtil extends Object
    {
        public static const TAIL:String = "…";

        public function StringUtil()
        {
            return;
        }// end function

        public static function getFirstA_ZChar(param1:String) : String
        {
            var _loc_2:String = null;
            var _loc_3:int = 0;
            var _loc_4:Array = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
            _loc_2 = param1.substr(_loc_3, (_loc_3 + 1)).toUpperCase();
            while (_loc_4.indexOf(_loc_2) == -1)
            {
                
                _loc_2 = param1.substr(_loc_3, (_loc_3 + 1)).toUpperCase();
                _loc_3++;
            }
            return _loc_2;
        }// end function        
		
		/**
		 * 把首字母转化为小写
		 * @param	param1
		 * @return
		 */
		public static function UpperCaseFirstChar(param1:String) : String
        {
             var f:String = getFirstA_ZChar(param1);
			 var res:String = f + param1.substr(1, param1.length);
			 
			 return res;
        } 		
		
		/**
		 * 把首字母转化为小写，其它的转化为小写
		 * @param	param1
		 * @return
		 */
		public static function UpperCaseFirstCharAndOtherLowerCase(param1:String) : String
        {
             var f:String = getFirstA_ZChar(param1);
			 var res:String = f +( param1.substr(1, param1.length)).toLowerCase();
			 
			 return res;
        } 

        public static function trim(param1:String) : String
        {
            if (param1 == null)
            {
                return null;
            }
            return param1.replace(/^\s+|\s+$/gs, "");
        } 

        public static function isEmail(param1:String) : Boolean
        {
            if (param1)
            {
                return trim(param1).match(/\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b/gi).length == 1 ? (true) : (false);
            }
            return false;
        }// end function

        public static function isMobileNO(param1:String) : Boolean
        {
            if (param1 && param1.length == 11)
            {
                return param1.match(/\d{11}/).length == 1 ? (true) : (false);
            }
            return false;
        }// end function

        public static function trip(param1:String, param2:int, param3:Boolean = true, param4:String = "…") : String
        {
            var _loc_5:String = null;
            if (param1.length > param2)
            {
                _loc_5 = param1.substr(0, param2);
                if (param3)
                {
                    _loc_5 = _loc_5 + param4;
                }
                return _loc_5;
            }
            return param1;
        }// end function

        public static function clearEnterString(param1:String) : String
        {
            if (param1)
            {
                return param1.replace(/\s/g, " ");
            }
            return "";
        }// end function

    }
}
