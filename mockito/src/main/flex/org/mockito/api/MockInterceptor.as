package org.mockito.api
{
    public interface MockInterceptor
    {
        function methodCalled(invocation:Invocation):*;
        
        function set verifier(verifier:Verifier):void;
        
        function stubLatestInvocation(answer:Answer):void;
        
        function addMatcher(matcher:Matcher):void
    }
}