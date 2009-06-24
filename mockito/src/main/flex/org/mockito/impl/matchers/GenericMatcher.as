package org.mockito.impl.matchers
{
    import org.mockito.api.Matcher;

    public class GenericMatcher implements Matcher
    {
        private var expected:Object;
        
        private var matching:Function;
        
        public function GenericMatcher(expected:Object, matching:Function)
        {
            this.expected = expected;
            this.matching = matching;
        }

        public function matches(value:*):Boolean
        {
            return matching(expected, value);
        }
        
    }
}