package org.mockito.impl
{
    import asmock.framework.proxy.*;
    
    import org.mockito.api.Answer;
    import org.mockito.api.Invocation;
    import org.mockito.api.Matcher;

    public class InvocationImpl implements Invocation
    {
        private var _verified:Boolean;

        private var _target:Object;
        private var _methodName:String;
        private var _arguments:Array;
        private var _answer:Answer;

        public function InvocationImpl(target:Object, methodName:String, arguments:Array)
        {
            this._target = target;
            this._methodName = methodName;
            this._arguments = arguments;
//            for each (var arg:Object in arguments)
//            {
//                 _arguments.push(Matchers.eq(arg));
//            }
        }

        public function get args():Array
        {
            return _arguments;
        }

        public function get target():Object
        {
            return _target;
        }

        public function get methodName():String
        {
            return _methodName;
        }

        public function set verified(value:Boolean):void
        {
            _verified = value;
        }

        public function get verified():Boolean
        {
            return _verified;
        }

        public function describe():String
        {
            return methodName;
        }

        public function matches(other:Invocation):Boolean
        {
            if (target == other.target && methodName == other.methodName)
            {
                return argumentsMatch(args, other.args);
            }
            return false;
        }

        public function argumentsMatch(expected:Array, actual:Array):Boolean
        {
            if (areEmptyArguments(expected, actual))
            {
                return true;
            }
            else if (haveTheSameLenght(expected, actual))
            {
                for (var i:int; i < expected.length; i++)
                {
                    if (!match(expected[i], actual[i]))
                        return false;
                }
                return true;
            }
            return false;
        }

        private function areEmptyArguments(expected:Array, actual:Array):Boolean
        {
            return (!expected || expected.length == 0) && (!actual || actual.length == 0);
        }

        private function haveTheSameLenght(expected:Array, actual:Array):Boolean
        {
            return expected && actual && expected.length == actual.length;
        }

        public function match(expected:*, actual:*):Boolean
        {
            if (expected is Matcher)
            {
                return Matcher(expected).matches(actual);
            }
            else if (actual is Matcher)
            {
                return Matcher(actual).matches(expected);
            }
            return expected == actual;
        }

        public function addAnswer(answer:Answer):void
        {
            this._answer = answer;
        }

        public function answer():*
        {
            if (_answer)
                return _answer.give();
            return null;
        }

        public function useMatchers(matchers:Array):void
        {
            if (matchers.length > 0 && !haveTheSameLenght(_arguments, matchers))
            {
                throw new MatcherRequiredForEveryArgument();
            }
            if (matchers.length > 0)
            {
                _arguments = matchers;
            }
        }
        
        public function isStubbed():Boolean
        {
            return _answer != null;
        }
    }
}