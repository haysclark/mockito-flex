package org.mockito.impl
{
    import asmock.framework.proxy.*;
    import asmock.reflection.*;
    
    import flexunit.framework.TestCase;

    public class TestAsmockMockery extends TestCase
    {
        private var repo:AsmockMockery;
        
        public var invocation:MockAsmockInvocation; 
        
        public var target:Object;
        
        public function TestAsmockMockery()
        {
            super();
        }
        
        override public function setUp():void
        {
            repo = new AsmockMockery();
            invocation = new MockAsmockInvocation();
            target = new Object();
        }
        
        public function testMethodCallWillCallInterceptor():void
        {
            invocation = new MockAsmockInvocation();
            invocation.method = createMethodInfo();
            // given
            var interceptor:MockMockInterceptor = new MockMockInterceptor();
            repo.interceptor = interceptor;
            assertEquals(0, interceptor.methodCalledCount);
            // when
            assertNull(repo.methodCall(invocation, target, null, null)); 
            // then
            assertEquals(1, interceptor.methodCalledCount);
        }
        
        private function createMethodInfo():MethodInfo
        {
            var type:Type = Type.getType(TestAsmockMockery);
            return new MethodInfo(type, "foo", "foo", MemberVisibility.PUBLIC, false, false, type, []);
        }
    }
}