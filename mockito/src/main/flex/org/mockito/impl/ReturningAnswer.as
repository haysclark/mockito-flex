package org.mockito.impl
{
    import org.mockito.api.Answer;

    public class ReturningAnswer implements Answer
    {
        private var value:*;
        
        public function ReturningAnswer(value:*)
        {
            this.value = value;
        }

        public function give():*
        {
            return this.value;
        }
    }
}