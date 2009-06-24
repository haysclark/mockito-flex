package org.mockito.impl
{
    import flexunit.framework.TestCase;

    import org.mockito.api.Invocation;
    import org.mockito.api.Matcher;
    import org.mockito.impl.matchers.Matchers;


    public class TestInvocationImpl extends TestCase
    {
        private var invocation:InvocationImpl = new InvocationImpl(null, "ala", []);

        public function TestInvocationImpl()
        {
        }

        public function testWillMatchSuccesfully():void
        {
            // given
            var target:Object = new Object();
            var methodName:String = "ma kota";
            var arguments:Array = [];

            var wanted:Invocation = new InvocationImpl(target, methodName, arguments);
            var other:Invocation = new InvocationImpl(target, methodName, arguments);

            // then
            assertTrue(wanted.matches(other));
        }

        public function testWillMatchArgumentless():void
        {
            assertTrue(invocation.argumentsMatch(null, null));
            assertTrue(invocation.argumentsMatch([], []));
            assertTrue(invocation.argumentsMatch(null, []));
            assertTrue(invocation.argumentsMatch([], null));
        }

        public function testWillNotMatchArgumentlessWithArgumensGiven():void
        {
            assertFalse(invocation.argumentsMatch(null, [1]));
            assertFalse(invocation.argumentsMatch([], [eq(1)]));
        }

        public function testWillMatchArguments():void
        {
            assertTrue(invocation.argumentsMatch([1, 2], [eq(1), eq(2)]));
            assertTrue(invocation.argumentsMatch([eq(1), eq(2)], [1, 2]));
            assertTrue(invocation.argumentsMatch(["abc"], [eq("abc")]));
            assertTrue(invocation.argumentsMatch([eq("abc")], ["abc"]));
        }

        public function testWillNotMatchNotMatchingArguments():void
        {
            assertFalse(invocation.argumentsMatch([eq(1)], [1, 2]));
            assertFalse(invocation.argumentsMatch([1, "abc"], [eq("abc")]));
        }

        private function eq(value:Object):Matcher
        {
            return Matchers.eq(value);
        }

        public function testWillTryToUseMatchersForArguments():void
        {
            //given
            invocation = new InvocationImpl(null, "ala", [100]);
            //when
            var argArray:Array = [eq(100)];
            invocation.useMatchers(argArray);
            //then
            assertStrictlyEquals(argArray, invocation.args);
        }

        public function testWillNotReplaceArgumentsWithEmptyMatchers():void
        {
            //given
            var argArray:Array = [100];
            invocation = new InvocationImpl(null, "ala", argArray);
            //when
            invocation.useMatchers([]);
            //then
            assertStrictlyEquals(argArray, invocation.args);
        }

        public function testWillShoutWhenMatchersCountDifferentFromArgCount():void
        {
            //given
            invocation = new InvocationImpl(null, "ala", [1, 2]);
            try
            {
                //when
                invocation.useMatchers([eq(100)]);
                fail();
                //then
            }
            catch (e:MatcherRequiredForEveryArgument)
            {
            }
        }
    }
}