package org.mockito.impl
{
    import org.mockito.api.Invocation;
    import org.mockito.api.Invocations;
    import org.mockito.api.Verifier;

    public class Times implements Verifier
    {
        public static const once:Times = new Times(1);

        public static const twice:Times = new Times(2);

        public static const never:Times = new Times(0);

        private var _wantedTimes:int;

        public function Times(times:int)
        {
            _wantedTimes = times;
        }

        public function verify(wanted:Invocation, invocations:Invocations):void
        {
            var counter:int = 0;

            for each (var iv:Invocation in invocations.getInvocations())
            {
                if (wanted.matches(iv))
                {
                    counter ++;
                }
            }

            if (_wantedTimes == 0 && counter > 0)
            {
                throw new NeverWantedButInvoked("Never wanted but invoked (" + counter + "): " + wanted.describe());
            }
            else if (_wantedTimes == 1 && counter == 0)
            {
                throw new WantedButNotInvoked("Wanted but not invoked at all: " + wanted.describe());
            }
            else if (_wantedTimes != counter)
            {
                throw new ActualNumberOfInvocationsIsDifferent("Wanted (" + _wantedTimes + ") but invoked (" +  counter + "): " + wanted.describe());
            }
        }
    }
}