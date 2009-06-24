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
    import asmock.reflection.*;
    
    import flash.events.IEventDispatcher;
    
    import org.mockito.api.Matcher;
    import org.mockito.api.MethodSelector;
    import org.mockito.api.MockCreator;
    import org.mockito.api.MockInterceptor;
    import org.mockito.api.MockeryProvider;
    import org.mockito.api.Stubber;
    import org.mockito.api.Verifier;
    import org.mockito.impl.AsmockMockeryProvider;
    import org.mockito.impl.StubberImpl;
    import org.mockito.impl.Times;
    import org.mockito.impl.matchers.Matchers;
    
    public class Mockito implements MethodSelector, MockCreator
    {
        private var mockCreator:MockCreator;
        
        private var mockInterceptor:MockInterceptor;
        
        public static var defaultProviderClass:Class = AsmockMockeryProvider;
        
        public static var instance:Mockito;
        
        public function Mockito(mockeryProviderClass:Class=null)
        {
            super();
            instance = this;
            var provider:MockeryProvider = mockeryProviderClass ? new mockeryProviderClass() : new defaultProviderClass;
            mockCreator = provider.getMockCreator();
            mockInterceptor = provider.getMockInterceptor(); 
        }
        
        public function prepare(classes:Array):IEventDispatcher
        {
            return mockCreator.prepare(classes);
        }
        
        public function mock(clazz:Class, name:String=null, args:Array=null):Object
        {
            return mockCreator.mock(clazz, name, args);
        }

        public function verify(verifier:Verifier):MethodSelector
        {
            if (verifier == null)
                verifier = Times.once;
            mockInterceptor.verifier = verifier;
            return this;
        }
        
        public function given(methodCallToStub:*):Stubber
        {
            return new StubberImpl(mockInterceptor);
        }

        public function that(methodCallToVerify:*):void
        {
            
        }
        
        public function any():*
        {
            argThat(Matchers.any());
        }
        
        public function eq(expected:Object):*
        {
            argThat(Matchers.eq(expected));
        }
        
        public function argThat(matcher:Matcher):void
        {
            mockInterceptor.addMatcher(matcher);
        }
        
        public function times(expectedCallsCount:int):Verifier
        {
            return new Times(expectedCallsCount);
        }
        
        public function never():Verifier
        {
            return Times.never;
        }
    }
}