package org.mockito
{
import org.mockito.impl.MatcherRequiredForEveryArgument;
import org.mockito.impl.matchers.GenericMatcher;

public class TestMatchers extends MockitoTestCase
{
    public function TestMatchers()
    {
        super([TestClass]);
    }

    public function testWillRemindUserThatHeNeedsCorrectNumberOfMatchers():void
    {
        // given
        var mockie:TestClass = TestClass(mock(TestClass));

        try
        {
            // when
            mockie.baz("one", any());
            fail();
        }
            //then
        catch (e:MatcherRequiredForEveryArgument) {
        }
    }

    public function testWillMultipleArgsMatchers():void
    {
        // given
        var mockie:TestClass = TestClass(mock(TestClass));

        //when
        mockie.baz("one", 145);

        // then
        verify().that(mockie.baz(eq("one"), any()));
    }

    public function testWillUseCustomArgumentMatcher():void
    {
        // given
        var mockie:TestClass = TestClass(mock(TestClass));

        //when
        mockie.baz("one two three", 10);

        // then
        verify().that(mockie.baz(argThat(new GenericMatcher("two", contains)), eq(10)));
    }

    private function contains(expected:String, actual:String):Boolean {
        return actual.indexOf(expected) != -1
    }
}
}