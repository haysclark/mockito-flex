package org.mockito.api
{
    import mx.collections.ArrayCollection;
    
    public interface Invocations
    {
        function addInvocation(iv:Invocation):void;
        
        function getInvocations():ArrayCollection;
        
        function answerFor(iv:Invocation):*;
        
    }
}