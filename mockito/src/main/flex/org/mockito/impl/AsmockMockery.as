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
    import asmock.framework.MockRepository;
    import asmock.framework.proxy.*;
    import asmock.reflection.*;
    
    import flash.utils.Dictionary;
    
    import org.mockito.api.Invocation;
    import org.mockito.api.MockCreator;
    import org.mockito.api.MockInterceptor;
    import org.mockito.api.MockeryProvider;
    
    public class AsmockMockery extends MockRepository implements MockCreator 
    {
        public var interceptor:MockInterceptor;
        
        private var _names:Dictionary = new Dictionary();

        public function AsmockMockery()
        {
        }

        public static function createFrom(invocation:IInvocation):Invocation
        {
            return new InvocationImpl(invocation.invocationTarget, invocation.method.name, invocation.arguments);
        }

        public function mock(clazz:Class, name:String=null, constructorArgs:Array=null):Object
        {
            if (name == null)
                name = Type.getType(clazz).name;
            var mock:Object = create(clazz, constructorArgs);
            registerAlias(mock, name);
            return mock;
        }

        override public function methodCall(invocation:IInvocation, target:Object, method:MethodInfo, arguments:Array):*
        {
            return interceptor.methodCalled(createFrom(invocation));
        }

        public function registerAlias(mock:Object, name:String):void
        {
            _names[mock] = name;
        }
    }
}