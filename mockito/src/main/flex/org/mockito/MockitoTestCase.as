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
    
    /**
     * Integration test case for the flexunit.
     */
    public class MockitoTestCase extends TestCase
    {
        private var _mockClasses:Array;

        protected var mockito:Mockito
        
        /**
         * Pass classes to mock to the constructor
         * @param mockClasses array of classes to mock
         */
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
        public function mock(classToMock:Class, name:String = null, constructorArgs:Array = null):*
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
         * A fluent interface for making sure call hasn't happened
         * Example:
         * <listing>
         * verify(never()).that(operator.execute());
         * </listing>
         */
        public function never():Verifier
        {
            return mockito.never();
        }

        /**
         * A fluent interface for counting calls
         * Example:
         * <listing>
         * verify(times(2)).that(operator.execute());
         * </listing>
         */
        public function times(expectedCallsCount:int):Verifier
        {
            return mockito.times(expectedCallsCount);
        }
        
        /**
         * This method it part of the fluent interface
         * It's a placeholder for the actual method call for verification
         */
        public function isItNaN():*
        {
            return mockito.isItNaN();
        }

        /**
         * Matches any non-null that is of specified type. Type equality is evaluated with equals operator
         */
        public function anyOf(clazz:Class):*
        {
            return mockito.anyOf(clazz);
        }

        /**
         * Verifies if the argument has a property or a property chain of an expected value
         * @param propertyChain a property name or an array of property names of the objects chain in an argument
         * @param expectedPropertyValue expected value, equality is evaluated with '=='
         */
        public function havingPropertyOf(propertyChain:Object, expectedPropertyValue:Object):*
        {
            return mockito.havingPropertyOf(propertyChain, expectedPropertyValue);
        }

        /**
         * matches any non-null argument 
         */
        public function notNull():*
        {
            return mockito.notNull();
        }
    
        /**
         * Matches any argument including <code>null</code>
         */
        public function any():*
        {
            return mockito.any();
        }
    
        /**
         * Equality matcher<br />
         * Example:<br /><br />
         * <listing>
         * verify(never()).that(system.login(eq("root")));
         * </listing>
         */
        public function eq(expected:Object):*
        {
            return mockito.eq(expected);;
        }
        /**
         * A fluent interface for custom matcher
         * Example:
         * <listing>
         * verify().that(system.login(argThat(new HashOnlyCapitalLettersMatcher())));
         * </listing>
         *
         * A good practice is to create a matcher recording function somewhere and name it
         * after the matcher. It's important to return a wildcard from the function to let it
         * work with any arugment of the function
         * <listing>
         * function hasOnlyCapitalLetters():*
         * {
         *     argThat(new HashOnlyCapitalLettersMatcher());
         * }
         * </listing>
         */
        public function argThat(matcher:Matcher):*
        {
            return mockito.argThat(matcher);
        }
    }
}