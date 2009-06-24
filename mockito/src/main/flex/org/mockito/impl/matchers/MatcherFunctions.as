package org.mockito.impl.matchers
{

    public class MatcherFunctions
    {

        public function MatcherFunctions()
        {
        }

        public static function anyFunction(expected:Object, actual:Object):Boolean
        {
            return true;
        }

        public static function eqFunction(expected:Object, actual:Object):Boolean
        {
            return expected == actual;
        }
    }
}