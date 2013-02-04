package com.jooce.net
{
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    import flash.net.URLRequestHeader;
    import flash.net.URLRequestMethod;
    import flash.utils.ByteArray;
    import flash.utils.Endian;
    
    public class UploadFile
    {
        public function UploadFile()
        {
        }
        
        /**
         * Uploads a file using a given URLLoader object.
         * 
         * @param loader The URLLoader object to use
         * @param url The location of the script recieving the upload
         * @param file The file to upload
         * @param fileName The name of the file
         * @param contentType The content-type of the file
         */    
        public function uploadFile(
                                loader:URLLoader,
                                url:String,
                                file:ByteArray,
                                fileName:String,
                                contentType:String = &apos;application/octet-stream&apos;
                                ):void
        {
            var i        :int;
            var boundary :String     = &apos;--&apos;;
            var request  :URLRequest = new URLRequest;
            var postData :ByteArray  = new ByteArray;
            var bytes    :String;
            
            for ( i = 0; i < 0x10; i++ )
                boundary += String.fromCharCode( int( 97 + Math.random() * 25 ) );
    
            loader.dataFormat = URLLoaderDataFormat.BINARY;
                        
            request.url = url;
            request.contentType = &apos;multipart/form-data; boundary=&apos; + boundary;
            request.method = URLRequestMethod.POST;
            
            postData.endian = Endian.BIG_ENDIAN;
            
            // -- + boundary
            postData.writeShort( 0x2d2d );
            for ( i = 0; i < boundary.length; i++ )
                postData.writeByte( boundary.charCodeAt( i ) );
            
            // line break
            postData.writeShort( 0x0d0a );
            
            // content disposition
            bytes = &apos;Content-Disposition: form-data; name="Filename"&apos;;
            for ( i = 0; i < bytes.length; i++ )
                postData.writeByte( bytes.charCodeAt( i ) );
            
            // 2 line breaks
            postData.writeInt( 0x0d0a0d0a );
            
            // file name
            postData.writeUTFBytes( fileName );
            
            // line break
            postData.writeShort( 0x0d0a );
            
            // -- + boundary
            postData.writeShort( 0x2d2d );
            for ( i = 0; i < boundary.length; i++ )
                postData.writeByte( boundary.charCodeAt( i ) );
            
            // line break
            postData.writeShort( 0x0d0a );
            
            // content disposition
            bytes = &apos;Content-Disposition: form-data; name="Filedata"; filename="&apos;;
            for ( i = 0; i < bytes.length; i++ )
                postData.writeByte( bytes.charCodeAt( i ) );
            
            // file name
            postData.writeUTFBytes( fileName );
            
            // missing "
            postData.writeByte( 0x22 );
            
            // line break
            postData.writeShort( 0x0d0a );
            
            // content type
            bytes = &apos;Content-Type: &apos; + contentType;
            for ( i = 0; i < bytes.length; i++ )
                postData.writeByte( bytes.charCodeAt( i ) );
            
            // 2 line breaks
            postData.writeInt( 0x0d0a0d0a );
            
            // file data
            postData.writeBytes( file, 0, file.length );
            
            // line break
            postData.writeShort( 0x0d0a );
            
            // -- + boundary
            postData.writeShort( 0x2d2d );
            for ( i = 0; i < boundary.length; i++ )
                postData.writeByte( boundary.charCodeAt( i ) );
    
            // line break            
            postData.writeShort( 0x0d0a );
            
            // upload field
            bytes = &apos;Content-Disposition: form-data; name="Upload"&apos;;
            for ( i = 0; i < bytes.length; i++ )
                postData.writeByte( bytes.charCodeAt( i ) );
            
            // 2 line breaks
            postData.writeInt( 0x0d0a0d0a );
            
            // submit
            bytes = &apos;Submit Query&apos;;
            for ( i = 0; i < bytes.length; i++ )
                postData.writeByte( bytes.charCodeAt( i ) );
            
            // line break
            postData.writeShort( 0x0d0a );
            
            // -- + boundary + --
            postData.writeShort( 0x2d2d );
            for ( i = 0; i < boundary.length; i++ )
                postData.writeByte( boundary.charCodeAt( i ) );
            postData.writeShort( 0x2d2d );
    
            request.data = postData;
            request.requestHeaders.push( new URLRequestHeader( &apos;Cache-Control&apos;, &apos;no-cache&apos; ) );
            loader.load( request );
        }

    }
}
