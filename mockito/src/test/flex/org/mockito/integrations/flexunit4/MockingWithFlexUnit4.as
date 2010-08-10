package org.mockito.integrations.flexunit4
{
import org.flexunit.rules.IMethodRule;
import org.mockito.TestClass;
import org.mockito.integrations.verify;

public class MockingWithFlexUnit4
{
    [Mock(type="org.mockito.TestClass")]
    public var mockie:TestClass;

    [Rule]
    public var mockitoRule:IMethodRule = new MockitoRule();
    
    public function MockingWithFlexUnit4()
    {
    }

    [Test]
    public function shouldVerifyMockInvocation():void
    {
        // when
        mockie.argumentless();
        // then
        verify().that(mockie.argumentless());
    }
}
}