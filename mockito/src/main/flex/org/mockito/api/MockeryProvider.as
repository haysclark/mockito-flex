package org.mockito.api
{
    public interface MockeryProvider
    {
        function getMockCreator():MockCreator;
        
        function getMockInterceptor():MockInterceptor
    }
}