package org.mockito.api
{
    public interface Stubber
    {
        function willReturn(value:*):void;
        function willThrow(errorToThrow:Error):void;
        function will(answer:Answer):void;        
    }
}