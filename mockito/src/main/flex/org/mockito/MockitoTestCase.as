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
    import flexunit.framework.TestCase;
    import flexunit.framework.TestResult;

    import org.mockito.api.Matcher;
    import org.mockito.api.MethodSelector;
    import org.mockito.api.MockCreator;
    import org.mockito.api.Stubber;
    import org.mockito.api.Verifier;

    public class MockitoTestCase extends TestCase
    {
        private var _mockClasses:Array;

        protected var mockito:Mockito

        public function MockitoTestCase(mockClasses:Array)
        {
            _mockClasses = mockClasses;
        }

        /**
         * Due to the asynchronous nature of the class generation
         * a test needs to execute from a callback function
         */
        public override function runWithResult(result:TestResult):void
        {
            if (mockito == null && _mockClasses)
            {
                mockito = new Mockito();
                var superRunWithResult:Function = super.runWithResult;
                mockito.prepareClasses(_mockClasses, repositoryPreparedHandler);
                function repositoryPreparedHandler():void
                {
                    superRunWithResult(result);
                }
            }
            else
            {
                super.runWithResult(result);
            }
        }

        /**
         * Constructs mock object
         * @param clazz a class of the mock object
         * @param constructorArgs constructor arguments required to create mock instance
         * @param name a name used in various output
         * @return a mocked object
         */
        public function mock(classToMock:Class, name:String = null, constructorArgs:Array = null):Object
        {
            return mockito.mock(classToMock, name, constructorArgs);
        }

        /**
         * A starter function for verification of executions
         * If you dont specify the verifier, an equivalent of times(1) is used.
         * @param verifier object responsible for verification of the following execution
         */
        public function verify(verifier:Verifier = null):MethodSelector
        {
            return mockito.verify(verifier);
        }

        /**
         * A starter function for stubbing
         * @param methodCallToStub call a method to stub as an argument
         * @return an object providing stubbing options
         */
        public function given(methodCallToStub:*):Stubber
        {
            return mockito.given(methodCallToStub);
        }

        /**
         * @private
         */
        protected function get mockCreator():MockCreator
        {
            return mockito;
        }

        /**
         * Matches any argument including <code>null</code>
         */
        public function any():*
        {
            return mockito.any();
        }

        /**
         * Equality matcher
         * Example:
         * <code>
         * verify(never()).that(system.login(eq("root")));
         * </code>
         */
        public function eq(expected:*):*
        {
            return mockito.eq(expected);
        }

        /**
         * A fluent interface for making sure call hasn't happened
         * Example:
         * <code>
         * verify(never()).that(operator.execute());
         * </code>
         */
        public function never():Verifier
        {
            return mockito.never();
        }

        /**
         * A fluent interface for counting calls
         * Example:
         * <code>
         * verify(times(2)).that(operator.execute());
         * </code>
         */
        public function times(expectedCallsCount:int):Verifier
        {
            return mockito.times(expectedCallsCount);
        }

        /**
         * A fluent interface for custom matcher
         * Example:
         * <code>
         * verify().that(system.login(argThat(new HashOnlyCapitalLettersMatcher())));
         * </code>
         *
         * A good practice is to create a matcher recording function somewhere and name it
         * after the matcher. It's important to return a wildcard from the function to let it
         * work with any arugment of the function
         * <code>
         * function hasOnlyCapitalLetters():*
         * {
         *     argThat(new HashOnlyCapitalLettersMatcher());
         * }
         * </code>
         */
        public function argThat(matcher:Matcher):*
        {
            return mockito.argThat(matcher);
        }
    }
}