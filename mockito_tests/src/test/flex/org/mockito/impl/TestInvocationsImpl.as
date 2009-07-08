package org.mockito.impl
{
    import flexunit.framework.TestCase;

    public class TestInvocationsImpl extends TestCase
    {
        public function TestInvocationsImpl()
        {
            super();
        }
        
        public function testWillNotReturnStubbedInvocation():void
        {
            // given
            var stubbed:InvocationImpl = new InvocationImpl({}, "abc", []);
            stubbed.addAnswer(new ReturningAnswer(""));
            var regular:InvocationImpl = new InvocationImpl({}, "abc", []);
            var invocations:InvocationsImpl = new InvocationsImpl();
            // when
            invocations.addInvocation(stubbed);
            invocations.addInvocation(regular);
            // then
            assertEquals(1, invocations.getEncounteredInvocations().length);
            assertEquals(regular, invocations.getEncounteredInvocations().getItemAt(0));
        }
    }
}