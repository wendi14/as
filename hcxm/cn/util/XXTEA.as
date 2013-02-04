package hcxm.cn.util{
	/**
	 * [AS3]XXTEA加密算法的AS3版

引用XXTEA文章说明资料：
“... XXTEA 算法很安全，而且非常快速，非常适合应用于 Web 开发中。
 * 但目前似乎很少有人将该算法用于实际开发中。
 * 甚至国内尚无介绍该算法的文章（至少在 Google 上搜索不到这方面的中文文章，
 * 关于密码学算法的书中也未见提及）。
 * 我在 Google 上搜索到了几个国外的 XXTEA 算法的实现（见 参考文献 ）...” 。
	 * */
        import hcxm.cn.string.StringUtil
        public class XXTEA{
                
                public function XXTEA(){
                        throw new Error("XXTEA class is static container only");
                }
                
                private static function long2str(v:Array,w:Boolean):String {
                        var vl:uint = v.length;
                        var sl = v[vl - 1] & 0xffffffff;
                        for (var i:uint = 0; i < vl; i++){
                                v[i] = String.fromCharCode(v[i] & 0xff,
                                                           v[i] >>> 8 & 0xff,
                                v[i] >>> 16 & 0xff,
                                v[i] >>> 24 & 0xff);
                        }
                        if(w){
                                return v.join('').substring(0, sl);
                        }
                        else {
                                return v.join('');
                        }
                }
                
                private static function str2long(s:String,w:Boolean):Array {
                        var len:uint = s.length;
                        var v:Array = new Array();
                        for (var i:uint = 0; i < len; i += 4){
                                v[i >> 2] = s.charCodeAt(i)
                                | s.charCodeAt(i + 1) << 8
                                | s.charCodeAt(i + 2) << 16
                                | s.charCodeAt(i + 3) << 24;
                        }
                        if (w) {
                                v[v.length] = len;
                        }
                        return v;
                }
                
                public static function encrypt(char:String,key:String):String{
                        if(char == ""){
                                return "";
                        }
                        var v:Array = str2long(StringUtil.utf16to8(char), true);
                        var k:Array = str2long(key, false);
                        var n:uint = v.length - 1;
                        
                        var z:Number = v[n];
                        var y:Number = v[0];
                        var delta:Number = 0x9E3779B9;
                        var mx:Number;
                        var q:Number = Math.floor(6 + 52 / (n + 1))
                        var sum:Number = 0;
                        while (q-- > 0) {
                                sum = sum + delta & 0xffffffff;
                                var e:Number = sum >>> 2 & 3;
                                for (var p:uint = 0; p < n; p++) {
                                        y = v[p + 1];
                                        mx = (z >>> 5 ^ y << 2) + (y >>> 3 ^ z << 4) ^ (sum ^ y) + (k[p & 3 ^ e] ^ z);
                                        z = v[p] = v[p] + mx & 0xffffffff;
                                }
                                y = v[0];
                                mx = (z >>> 5 ^ y << 2) + (y >>> 3 ^ z << 4) ^ (sum ^ y) + (k[p & 3 ^ e] ^ z);
                                z = v[n] = v[n] + mx & 0xffffffff;
                        }
                        return long2str(v, false);
                }
                
                public static function decrypt(char:String,key:String):String{
                        if (char == "") {
                                return "";
                        }
                        var v:Array = str2long(char, false);
                        var k:Array = str2long(key, false);
                        var n:uint = v.length - 1;
                        
                        var z:Number = v[n - 1];
                        var y:Number = v[0];
                        var delta:Number = 0x9E3779B9;
                        var mx:Number;
                        var q:Number = Math.floor(6 + 52 / (n + 1));
                        var sum:Number = q * delta & 0xffffffff;
                        while (sum != 0) {
                                var e:Number = sum >>> 2 & 3;
                                for (var p:uint = n; p > 0; p--) {
                                        z = v[p - 1];
                                        mx = (z >>> 5 ^ y << 2) + (y >>> 3 ^ z << 4) ^ (sum ^ y) + (k[p & 3 ^ e] ^ z);
                                        y = v[p] = v[p] - mx & 0xffffffff;
                                }
                                z = v[n];
                                mx = (z >>> 5 ^ y << 2) + (y >>> 3 ^ z << 4) ^ (sum ^ y) + (k[p & 3 ^ e] ^ z);
                                y = v[0] = v[0] - mx & 0xffffffff;
                                sum = sum - delta & 0xffffffff;
                        }
                        
                        return StringUtil.utf8to16(long2str(v, true));
                }
        }
}