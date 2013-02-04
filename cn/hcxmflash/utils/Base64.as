package cn.hcxmflash.utils 
{
import flash.utils.*;

import flash.errors.EOFError;


public class Base64 {

// the Base64 "alphabet"

private static var _b64Chars:Array=new Array(

'A','B','C','D','E','F','G','H',

'I','J','K','L','M','N','O','P',

'Q','R','S','T','U','V','W','X',

'Y','Z','a','b','c','d','e','f',

'g','h','i','j','k','l','m','n',

'o','p','q','r','s','t','u','v',

'w','x','y','z','0','1','2','3',

'4','5','6','7','8','9','+','/'

)

// the reverse-lookup object used for decoding

private static var _b64Lookup:Object=_buildB64Lookup();

// the boolean to insert linebreaks after 76 chars into the Base64 encoded string

private static var _linebreaks:Boolean;



/*

* The class method for encoding an array of bytes to a Base64 encoded string.

*

* @param bArr A ByteArray containing values to encode

* @param linebreaks A boolean to insert a linebreak after 76 Base64-chars

* @return The Base64 encoded string

*

*/

public static function encode(bArr:ByteArray, linebreaks:Boolean=false):String

{

_linebreaks= linebreaks;

return _encodeBytes(bArr);

}



/*

* The class method for decoding a Base64 encoded string to an array of bytes.

*

* @param str A Base64 encoded string

* @return An array of bytes

*

*/

public static function decode(str:String):ByteArray

{

return _decodeSring(str);

}



/*

* The private helper class method to build an object used for reverse B64 char lookup.

*

* @return An object with each B64 char as a property containing the corresponding value

*

*/

private static function _buildB64Lookup():Object

{

var obj:Object=new Object();

for (var i:Number=0; i < _b64Chars.length; i++)

{

obj[_b64Chars[i]]=i;

}

return obj;

}



/*

* The private helper class method to determine whether a given char is B64 compliant.

*

* @param char A character as string (length=1)

* @return A boolean indicating the given char *is* in the B64 alphabet

*

*/

private static function _isBase64(char:String):Boolean

{

return _b64Lookup[char] != undefined;

}



/*

* The private class method for encoding an array of bytes into a B64 encoded string.

*

* @param bs An array of bytes

* @return The B64 encoded string

*

* @see Base64.encode()

*

*/

private static function _encodeBytes(bs:ByteArray):String

{

var b64EncStr:String=new String()

var bufferSize:uint;

var col:uint=0;

bs.position=0;

while (bs.position < bs.length)

{

bufferSize= bs.bytesAvailable >= 3 ? 3 : bs.bytesAvailable;

var byteBuffer:ByteArray=new ByteArray();

bs.readBytes(byteBuffer, 0, bufferSize);

b64EncStr+=( _b64EncodeBuffer(byteBuffer) );

col+=4;

if (_linebreaks && col%76 == 0) {

b64EncStr+=("\n");

col=0;

}

}

return b64EncStr.toString();

}



/*

* The private class method for encoding a buffer of 3 bytes (24bit) to 4 B64-chars

* (representing 6bit each => 24bit).

*

* @param buffer An array of bytes (1 <= length <= 3)

* @return The byte buffer encoded to 4 B64 chars as string

*

* @see Base64._encodeBytes()

*

*/

private static function _b64EncodeBuffer(buffer:ByteArray):String

{

var bufferEncStr:String=new String() ;

bufferEncStr+=( _b64Chars[buffer[0] >> 2] );

switch (buffer.length)

{

case 1 :

bufferEncStr+=( _b64Chars[((buffer[0] << 4) & 0x30)] );

bufferEncStr+=("==");

break;

case 2 :

bufferEncStr+=( _b64Chars[(buffer[0] << 4) & 0x30 | buffer[1] >> 4] );

bufferEncStr+=( _b64Chars[(buffer[1] << 2) & 0x3c] );

bufferEncStr+=("=");

break;

case 3 :

bufferEncStr+=( _b64Chars[(buffer[0] << 4) & 0x30 | buffer[1] >> 4] );

bufferEncStr+=( _b64Chars[(buffer[1] << 2) & 0x3c | buffer[2] >> 6] );

bufferEncStr+=( _b64Chars[buffer[2] & 0x3F] );

break;

default : trace("Base64 byteBuffer outOfRange");

}

return bufferEncStr.toString();

}



/*

* The private class method for decoding a string containing B64 chars to an array of bytes

*

* @param s The B64 encoded string

* @return A decoded array of bytes

*

* @see Base64.decode()

*

*/

private static function _decodeSring(s:String):ByteArray

{

var b64EncString:String = new String();

var b64DecBytes:ByteArray=new ByteArray();

var stringBuffer:String=new String();

var lgth:uint=b64EncString.length;

for (var i:uint=0; i < lgth; i++)

{

var char:String=b64EncString.charAt(i);

if (!StringUtil.isWhitespace(char) && (_isBase64(char) || char == "=")) {

stringBuffer+=(char);

if (stringBuffer.length == 4) {

b64DecBytes.writeBytes( _b64DecodeBuffer(stringBuffer) );

stringBuffer=new String();

}

}

}

b64DecBytes.position=0;

return b64DecBytes;

}



/*

* The private class method for decoding a string buffer of 4 B64 chars

* (each representing 6bit) to an array of 3 bytes.

*

* @param buffer A string containing B64 chars (length = 4)

* @return An array of bytes containing the decoded values

*

* @see Base64._decodeBytes()

*

*/

private static function _b64DecodeBuffer(buffer:String):ByteArray

{

var bufferEncBytes:ByteArray=new ByteArray();

var charValue1:uint=_b64Lookup[buffer.charAt(0)];

var charValue2:uint=_b64Lookup[buffer.charAt(1)];

var charValue3:uint=_b64Lookup[buffer.charAt(2)];

var charValue4:uint=_b64Lookup[buffer.charAt(3)];

bufferEncBytes.writeByte(charValue1 << 2 | charValue2 >> 4);

if (buffer.charAt(2) != "=") bufferEncBytes.writeByte(charValue2 << 4 | charValue3 >> 2);

if (buffer.charAt(3) != "=") bufferEncBytes.writeByte(charValue3 << 6 | charValue4);

return bufferEncBytes;

}

}

// 上面StringUtil类和StringBuilder类，是因为flex改成as3后所没有类，我这边自己重写一下(还没过多考虑到效率)！

// 下面Base64类，是在找到的flex版上改过来的！





}