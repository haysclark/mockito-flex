package org.mockito.impl
{
    import mx.collections.ArrayCollection;
    
    import org.mockito.api.Invocation;
    import org.mockito.api.Invocations;

    public class InvocationsImpl implements Invocations
    {
        private var invocations:ArrayCollection;
        
        public function InvocationsImpl()
        {
            invocations = new ArrayCollection();
            invocations.filterFunction = filterOutStubbed;
            invocations.refresh();
        }

        public function addInvocation(iv:Invocation):void
        {
            invocations.addItem(iv);
        }
        
        public function getInvocations():ArrayCollection
        {
            invocations.refresh();
            return invocations;
        }
        
        public function answerFor(actualInvocation:Invocation):*
        {
            for each (var invocation:Invocation in invocations.source)
            {
                if (invocation.matches(actualInvocation))
                {
                    return invocation.answer();
                }
            }
            return null;
        }
        
        private function filterOutStubbed(item:Invocation):Boolean 
        {
            return !item.isStubbed();
        }
    }
}