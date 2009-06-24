package org.mockito.impl
{
    import org.mockito.api.MockCreator;
    import org.mockito.api.MockInterceptor;
    import org.mockito.api.MockeryProvider;

    public class AsmockMockeryProvider implements MockeryProvider
    {
        private var mockInterceptor:MockInterceptor = new MockInterceptorImpl();
        
        private var mockCreator:AsmockMockery = new AsmockMockery();
        
        public function AsmockMockeryProvider()
        {
            mockCreator.interceptor = mockInterceptor;
        }

        public function getMockCreator():MockCreator
        {
            return mockCreator;
        }
        
        public function getMockInterceptor():MockInterceptor
        {
            return mockInterceptor;
        }
        
    }
}