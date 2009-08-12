/**
 * The MIT License
 *
 * Copyright (c) 2009 Mockito contributors
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
 * and associated documentation files (the "Software"), to deal in the Software without restriction, 
 * including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
 * and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, 
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE 
 * AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
 * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 
 */
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
            var counter:int = invocations.countMatchingInvocations(wanted);

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