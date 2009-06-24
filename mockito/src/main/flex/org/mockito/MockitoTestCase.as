/**
 * The MIT License
 *
 * Copyright (c) 2009 Mockito contributors
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
 * and associated documentation files (the "Software"), to deal in the Software without restriction, 
 * including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
 * and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, 
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE 
 * AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
 * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 
 */
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