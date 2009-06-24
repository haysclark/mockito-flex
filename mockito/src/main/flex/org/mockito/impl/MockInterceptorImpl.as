package org.mockito.impl
{
    import flash.utils.Dictionary;
    
    import mx.collections.ArrayCollection;
    
    import org.mockito.api.Answer;
    import org.mockito.api.Invocation;
    import org.mockito.api.Invocations;
    import org.mockito.api.Matcher;
    import org.mockito.api.MockInterceptor;
    import org.mockito.api.Verifier;

    public class MockInterceptorImpl implements MockInterceptor
    {
        public var invocationsMap:Dictionary = new Dictionary();
        
        private var matchers:Array = new Array();

        private var _verifier:Verifier;
        
        private var latestInvocation:Invocation;

        public function MockInterceptorImpl()
        {
        }

        public function methodCalled(invocation:Invocation):*
        {
            invocation.useMatchers(matchers);
            matchers = [];
            if (verifier)
            {
                try
                {
                    var invocations:Invocations = getInvocationFor(invocation.target);
                    verifier.verify(invocation, invocations);
                    return null;
                }
                finally
                {
                    verifier = null;
                }
            }
            else
            {
                // store invocations for later verification or execute stub
                // consider using asmock facitilities for the stubbing
                rememberInvocation(invocation);
            }

            return getInvocationFor(invocation.target).answerFor(invocation);
        }

        public function rememberInvocation(invocation:Invocation):void
        {
            var invocations:Invocations = getInvocationFor(invocation.target);
            invocations.addInvocation(invocation);
            latestInvocation = invocation;
        }
        
        public function stubLatestInvocation(answer:Answer):void
        {
            if (!latestInvocation)
                throw new MissingMethodCallToStub();
            latestInvocation.addAnswer(answer);
        }

        protected function getInvocationFor(target:Object):Invocations
        {
            var invocations:Invocations = invocationsMap[target];
            if (!invocations)
            {
                invocations = new InvocationsImpl();
                invocationsMap[target] = invocations;
            }
            return invocations;
        }

        public function getInvocations(mock:Object):ArrayCollection
        {
            return getInvocationFor(mock).getInvocations();
        }

        public function set verifier(value:Verifier):void
        {
            _verifier = value;
        }

        public function get verifier():Verifier
        {
            return _verifier;
        }
        
        public function addMatcher(matcher:Matcher):void
        {
            this.matchers.push(matcher);
        }
    }
}