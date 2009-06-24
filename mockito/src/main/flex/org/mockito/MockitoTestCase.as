package org.mockito
{
import flash.events.Event;
import flash.events.IEventDispatcher;

import flexunit.framework.TestCase;
import flexunit.framework.TestResult;

import org.mockito.api.Matcher;
import org.mockito.api.MethodSelector;
import org.mockito.api.MockCreator;
import org.mockito.api.Stubber;
import org.mockito.api.Verifier;
import org.mockito.impl.Times;
import org.mockito.impl.matchers.GenericMatcher;

public class MockitoTestCase extends TestCase
{
    private var _mockClasses:Array;
    protected var mockito:Mockito

    public function MockitoTestCase(mockClasses:Array)
    {
        _mockClasses = mockClasses;
    }

    public override function setUp():void
    {
        super.setUp();
    }

    public override function runWithResult(result:TestResult):void
    {
        if (mockito == null && _mockClasses)
        {
            mockito = new Mockito();
            var superRunWithResult:Function = super.runWithResult;

            var dispatcher : IEventDispatcher = mockito.prepare(_mockClasses);
            dispatcher.addEventListener(Event.COMPLETE, repositoryPreparedHandler);

            function repositoryPreparedHandler(event : Event) : void
            {
                superRunWithResult(result);
            }
        }
        else
        {
            super.runWithResult(result);
        }
    }

    public function mock(classToMock:Class, name:String = null, constructorArgs:Array = null):Object {
        return mockito.mock(classToMock, name, constructorArgs);
    }

    public function verify(verifier:Verifier = null):MethodSelector
    {
        return mockito.verify(verifier);
    }

    public function given(methodCallToStub:*):Stubber
    {
        return mockito.given(methodCallToStub);
    }

    protected function get mockCreator():MockCreator
    {
        return mockito;
    }

    public function any():*
    {
        return mockito.any();
    }

    public function eq(expected:*):*
    {
        return mockito.eq(expected);
    }

    public function never():Verifier
    {
        return mockito.never();
    }

    public function times(expectedCallsCount:int):Verifier
    {
        return mockito.times(expectedCallsCount);
    }

    public function argThat(matcher:Matcher):* {
        return mockito.argThat(matcher);
    }
}
}