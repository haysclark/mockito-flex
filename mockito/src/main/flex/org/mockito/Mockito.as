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
    import asmock.reflection.*;

    import org.mockito.api.Matcher;
    import org.mockito.api.MethodSelector;
    import org.mockito.api.MockCreator;
    import org.mockito.api.MockInterceptor;
    import org.mockito.api.MockeryProvider;
    import org.mockito.api.Stubber;
    import org.mockito.api.Verifier;
    import org.mockito.impl.AsmockMockeryProvider;
    import org.mockito.impl.StubberImpl;
    import org.mockito.impl.Times;
    import org.mockito.impl.matchers.Matchers;

    /**
     * Main mocking entry point
     *
     * You should start mocking by calling the prepareClasses(...) and providing all the classes to mock in given test case.
     * Since the bytecode generation is an asynchronous process it is recommended to use one of the integration test cases as they address
     * this issue.
     *
     * After preparing classes you can create mock objects by invoking:
     *
     * <code>
     * var dependency:Dependency = Dependency(mock(Dependency));
     * </code>
     *
     * Then setup the System Under Test (SUT)
     *
     * <code>
     * var sut:Sut = new Sut();
     * sut.dependency = dependency;
     * </code>
     *
     * And execute tested code.
     *
     * <code>
     * sut.testedFunction(10);
     * </code>
     *
     * Given the testedFunction looks like this:
     *
     * <code>
     * function testedFunction(input:int):void
     * {
     *      dependencyResult = dependency.someOperation(input);
     * }
     * </code>
     *
     * notice that there is no 'unexpected call' exception.
     *
     * Instead you are free to choose what you want to verify:
     *
     * <code>
     * verify().that(dependency.someOperation(input));
     * </code>
     *
     * The full test would look like this:
     * <code>
     * // given
     * var sut:Sut = new Sut();
     * sut.dependency = dependency;
     * // when
     * sut.testedFunction(10);
     * // then
     * verify().that(dependency.someOperation(10));
     * </code>
     *
     * As you can see, verification happens where assertions go. Not before the tested code.
     *
     * Important note is that verify() is equivalent to verify(times(1)).
     *
     * If you need to stub dependency, you define it upfront.
     * <code>
     * given(dependency.someOperation(10)).willReturn(1);
     * </code>
     *
     * When used in test it would look like this:
     * <code>
     * // given
     * var sut:Sut = new Sut();
     * sut.dependency = dependency;
     * given(dependency.someOperation(10)).willReturn(1);
     * // when
     * sut.testedFunction(10);
     * // then
     * assertEquals(1, sut.dependencyResult);
     * </code>
     *
     * It may be useful to verify or define stubbing with various arguments at a time or have ability of matching the specific cases.
     * For that purpose Mockito provides Matchers.
     *
     * Below example verifies any arguments passed to the function:
     * <code>
     * verify().that(dependency.someOperation(any()));
     * </code>
     *
     * Similar you can do with stubbing:
     *
     * <code>
     * given(dependency.someOperation(any())).willReturn(1);
     * </code>
     *
     * As you can see you can either use explicit values or matchers when defining stubs or verifying. But you cannot mix it within single stub definition or verification.
     * So for instance:
     * <code>
     * verify().that(progress.update(10, any()))
     * </code>
     *
     * is invalid. Mockito will not be able to figure out which argument type to match against the any() matcher.
     *
     * You may want to verify multiple executions of a method at time. It's easy. Just tell how to verify:
     *
     * <code>
     * verify(times(3)).that(dependency.someOperation(any()));
     * </code>
     *
     * Sometimes you may want to make sure method has not been called. Do it by verifying:
     *
     * <code>
     * verify(never()).that(dependency.someOperation(any()));
     * </code>
     *
     * If you miss a verifier you can write it on your own by implementing Verifier interface.
     *
     * If you need to perform a matching that is not provided by the Mockito, you can write your custom Matcher.
     * You start off with implementing the Matcher interface:
     *
     * <code>
     * public class HashOnlyCapitalLettersMatcher implements Matcher
     * {
     *      public function matches(value:*):Boolean
     *      {
     *          var string:String = value as String;
     *          var hasOnlyCapitalLetters:Boolean = ...;
     *          return hasOnlyCapitalLetters;
     *      }
     * }
     * </code>
     *
     *
     * Then you need to record a matcher use by calling argThat() function that puts aside a matcher
     * for later use:
     *
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
     *
     */
    public class Mockito implements MethodSelector, MockCreator
    {
        private var mockCreator:MockCreator;

        private var mockInterceptor:MockInterceptor;

        public static var defaultProviderClass:Class = AsmockMockeryProvider;

        private static var instance:Mockito;

        public function Mockito(mockeryProviderClass:Class=null)
        {
            super();
            instance = this;
            var provider:MockeryProvider = mockeryProviderClass ? new mockeryProviderClass() : new defaultProviderClass;
            mockCreator = provider.getMockCreator();
            mockInterceptor = provider.getMockInterceptor();
        }

        /**
         * @inherited
         */
        public function prepareClasses(classes:Array, calledWhenClassesReady:Function):void
        {
            return mockCreator.prepareClasses(classes, calledWhenClassesReady);
        }

        /**
         * @inherited
         */
        public function mock(clazz:Class, name:String=null, args:Array=null):*
        {
            return mockCreator.mock(clazz, name, args);
        }

        /**
         * A starter function for verification of executions
         * If you dont specify the verifier, an equivalent of times(1) is used.
         * @param verifier object responsible for verification of the following execution
         */
        public function verify(verifier:Verifier=null):MethodSelector
        {
            if (verifier == null)
                verifier = Times.once;
            mockInterceptor.verifier = verifier;
            return this;
        }

        /**
         * A starter function for stubbing
         * @param methodCallToStub call a method to stub as an argument
         * @return an object providing stubbing options
         */
        public function given(methodCallToStub:*):Stubber
        {
            return new StubberImpl(mockInterceptor);
        }

        /**
         * This method it part of the fluent interface
         * It's a placeholder for the actual method call for verification
         */
        public function that(methodCallToVerify:*):void
        {

        }

        /**
         * Matches any argument including <code>null</code>
         */
        public function any():*
        {
            argThat(Matchers.any());
        }

        /**
         * Equality matcher
         * Example:
         * <code>
         * verify(never()).that(system.login(eq("root")));
         * </code>
         */
        public function eq(expected:Object):*
        {
            argThat(Matchers.eq(expected));
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
        public function argThat(matcher:Matcher):void
        {
            mockInterceptor.addMatcher(matcher);
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
            return new Times(expectedCallsCount);
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
            return Times.never;
        }
    }
}