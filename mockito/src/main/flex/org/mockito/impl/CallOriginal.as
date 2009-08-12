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
import flash.errors.IllegalOperationError;

import org.mockito.api.Answer;
import org.mockito.api.StubbingContext;
import org.mockito.api.StubbingContextAware;

public class CallOriginal implements Answer, StubbingContextAware
{
    private var _stubbingContext:StubbingContext;

    public function CallOriginal()
    {
    }

    public function give():*
    {
        if (!_stubbingContext)
            throw new IllegalOperationError("A stubbing context has not been set or an answer has been given already");
        return _stubbingContext.invocation.originalFunctionSeam.;
    }

    public function useContext(stubbingContext:StubbingContext):void
    {
        _stubbingContext = stubbingContext;
    }
}
}