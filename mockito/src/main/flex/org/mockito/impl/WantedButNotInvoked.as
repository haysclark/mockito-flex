package org.mockito.impl
{
    import org.mockito.api.MockitoVerificationError;

    public class WantedButNotInvoked extends MockitoVerificationError
    {
        public function WantedButNotInvoked(message:String="", id:int=0)
        {
            super(message, id);
        }
        
    }
}