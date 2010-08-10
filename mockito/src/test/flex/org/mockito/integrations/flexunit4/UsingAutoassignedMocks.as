package org.mockito.integrations.flexunit4
{
import org.flexunit.rules.IMethodRule;
import org.mockito.TestClass;
import org.mockito.integrations.verify;

public class UsingAutoassignedMocks
{
    [Mock(type="org.mockito.TestClass")]
    public var mockie:TestClass;

    [Mock(type="org.mockito.TestClass")]
    public var mockie2:TestClass;

    [Rule]
    public var mockitoRule:IMethodRule = new MockitoRule();
    
    public function UsingAutoassignedMocks()
    {
    }

    [Test]
    public function shouldAllowVerificationOnMockie():void
    {
        // when
        mockie.argumentless();
        // then
        verify().that(mockie.argumentless());
    }

    [Test]
    public function shouldAllowVerificationOnMockieTwo():void
    {
        // when
        mockie2.argumentless()
        // then
        verify().that(mockie2.argumentless());
    }
}
}