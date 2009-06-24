package org.mockito.api
{
    import org.mockito.api.Invocations;
    import org.mockito.api.Invocation;
    
    public interface Verifier
    {
        function verify(wanted:Invocation, invocations:Invocations):void;
    }
}