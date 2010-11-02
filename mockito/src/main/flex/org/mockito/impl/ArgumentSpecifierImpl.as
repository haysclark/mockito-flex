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
import org.mockito.api.StubbingContext;
import org.mockito.api.stubbing.ArgumentAction;
import org.mockito.api.stubbing.ArgumentActionDefinition;
import org.mockito.api.stubbing.ArgumentMethodSelector;
import org.mockito.api.stubbing.ArgumentPropertySelector;
import org.mockito.api.stubbing.ArgumentRelatedAnswer;
import org.mockito.api.stubbing.ArgumentSpecifier;

public class ArgumentSpecifierImpl implements ArgumentSpecifier, ArgumentActionDefinition
{
    private var answer:ArgumentRelatedAnswer;
    private var index:int;
    private var action:ArgumentAction;

    public function ArgumentSpecifierImpl(answer:ArgumentRelatedAnswer, index:int)
    {
        super();
        this.index = index;
        this.answer = answer;
    }

    public function asFunctionAndCall(...args):ArgumentRelatedAnswer
    {
        method(null).andCallWithArgs.apply(null, args);
        return answer;
    }

    public function method(name:String):ArgumentMethodSelector
    {
        var propertyRelatedAction:MethodRelatedAction = new MethodRelatedAction(name, answer);
        action = propertyRelatedAction;
        return propertyRelatedAction;
    }

    public function property(name:String):ArgumentPropertySelector
    {
        var propertyRelatedAction:PropertyRelatedAction = new PropertyRelatedAction(name, answer);
        action = propertyRelatedAction;
        return propertyRelatedAction;
    }

    public function take(stubbingContext:StubbingContext):void
    {
        if (!action)
            throw new ArgumentActionNotSpecified("Did you forget to specify action for the argument?");
        try
        {
            action.take(stubbingContext.args[index]);
        }
        catch (e:Error)
        {
            throw new ArgumentActionFailed("While evaluating argument " + index + " failed to " + action.describe() + " : ", e);
        }
    }
}
}