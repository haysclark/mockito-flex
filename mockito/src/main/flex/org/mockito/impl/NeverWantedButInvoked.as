package org.mockito.impl
{
    import org.mockito.api.MockitoVerificationError;

    public class NeverWantedButInvoked extends MockitoVerificationError
    {
        public function NeverWantedButInvoked(message:String="", id:int=0)
        {
            super(message, id);
        }
        
    }
}