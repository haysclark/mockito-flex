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
package org.mockito
{
import flexunit.framework.Assert;

[RunWith("org.mockito.integrations.flexunit4.MockitoClassRunner")]
public class MockAssignment
{
    [Mock(type="org.mockito.TestClass")]
    public var mockie:TestClass;
 
    [Mock(type="org.mockito.MockieWithArgs", argsList="constructorArgs")]
    public var mockieWithArgs:MockieWithArgs;

    public var constructorArgs:Array = ["MyNameIs"];

    public function MockAssignment()
    {
    }

    [Test]
    public function shouldAssignMockViaMetadata():void
    {
        Assert.assertNotNull("Did not assign mock", mockie);
    }

    [Test]
    public function shouldPassArgumentsToConstructor():void
    {
        Assert.assertEquals("MyNameIs", mockieWithArgs.name);
    }

// Later
//    public function shouldGuessMockTypeFromVariable():void
//    {
//        Assert.assertNotNull(guess);
//    }

}
}