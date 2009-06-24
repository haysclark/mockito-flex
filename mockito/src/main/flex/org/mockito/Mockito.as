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