package org.mockito.impl.matchers
{
    import org.mockito.api.Matcher;
    
    public class Matchers
    {
        public function Matchers()
        {
        }

        public static function eq(expected:Object):Matcher
        {
            return new GenericMatcher(expected, MatcherFunctions.eqFunction);
        }

        public static function any():Matcher
        {
            return new GenericMatcher(null, MatcherFunctions.anyFunction);
        }

    }
}