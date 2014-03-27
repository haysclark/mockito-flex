package org.mockito.integrations.flexunit4
{

import flash.events.TimerEvent;
import flash.utils.Timer;

import org.flexunit.asserts.assertEquals;
import org.flexunit.async.Async;
import org.flexunit.rules.IMethodRule;
import org.mockito.MockieClass;
import org.mockito.integrations.any;
import org.mockito.integrations.given;
import org.mockito.integrations.verify;

public class TestMockingWithFlexUnit4
{
    [Mock(type="org.mockito.MockieClass")]
    public var mockie:MockieClass;

    [Rule]
    public var mockitoRule:IMethodRule = new MockitoRule();
    
    public function TestMockingWithFlexUnit4()
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
    
    [Test(async)]
    public function shouldStubInAsyncTest()
    {
        given(mockie.asyncWithComplexCallback(any())).willReturn(100);

        var timer:Timer = new Timer(1000, 1);
        timer.addEventListener(TimerEvent.TIMER_COMPLETE, function() {
            trace(mockie.asyncWithComplexCallback(null));
        });

        Async.proceedOnEvent(this, timer, TimerEvent.TIMER_COMPLETE, 1000, function () {
            assertEquals(100, mockie.asyncWithComplexCallback(null));
        });

        timer.start();
    }
}
}