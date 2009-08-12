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

public class Between implements Verifier
{
    private var minimumCallsCount:int;
    private var maximumCallsCount:int;

    public function Between(minimumCallsCount:int, maximumCallsCount:int)
    {
        this.minimumCallsCount = minimumCallsCount;
        this.maximumCallsCount = maximumCallsCount;
    }

    public function verify(wanted:Invocation, invocations:Invocations):void
    {
        var count:int = invocations.countMatchingInvocations(wanted);
        if (count < minimumCallsCount || count > maximumCallsCount)
            throw new ActualNumberOfInvocationsIsDifferent("Wanted not at least (" + minimumCallsCount + ") and not more than (" + maximumCallsCount + ") but got (" + count + "): " + wanted.describe());

    }
}
}