package org.mockito.impl
{
import org.mockito.api.Answer;
import org.mockito.api.MockInterceptor;
    import org.mockito.api.Stubber;

    public class StubberImpl implements Stubber
    {
        private var interceptor:MockInterceptor;
        
        public function StubberImpl(interceptor:MockInterceptor)
        {
            this.interceptor = interceptor;
        }

        public function willReturn(value:*):void
        {
            this.will(new ReturningAnswer(value));
        }

        public function willThrow(errorToThrow:Error):void {
            this.will(new ThrowingAnswer(errorToThrow));
        }

        public function will(answer:Answer):void {
            this.interceptor.stubLatestInvocation(answer);
        }
    }
}