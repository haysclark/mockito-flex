package org.mockito.api
{
    public class MockitoVerificationError extends Error
    {
        public function MockitoVerificationError(message:String="", id:int=0)
        {
            super(message, id);
        }
        
    }
}