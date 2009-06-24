package org.mockito.impl
{
    import org.mockito.api.MockitoVerificationError;

    public class ActualNumberOfInvocationsIsDifferent extends MockitoVerificationError
    {
        public function ActualNumberOfInvocationsIsDifferent(message:String="", id:int=0)
        {
            super(message, id);
        }
    }
}