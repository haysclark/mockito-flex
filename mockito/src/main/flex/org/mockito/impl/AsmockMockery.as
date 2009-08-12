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
    
    import flash.events.Event;
    import flash.events.IEventDispatcher;
    import flash.utils.Dictionary;
    
    import org.mockito.api.Invocation;
    import org.mockito.api.MockCreator;
    import org.mockito.api.MockInterceptor;
    
    /**
     * Asmock bridge. Utilizes asmock facilities to create mock objects. 
     */
    public class AsmockMockery extends MockRepository implements MockCreator 
    {
        
        public var interceptor:MockInterceptor;
        
        protected var _names:Dictionary = new Dictionary();

        public function AsmockMockery(interceptor:MockInterceptor)
        {
            this.interceptor = interceptor;
        }

        /**
         * A factory method that creates Invocation out of asmock invocation
         * @param invocation asmock invocation object
         * @return mockito invocation
         * 
         */
        public static function createFrom(invocation:IInvocation):Invocation
        {
            var niceMethodName:String = extractFunctionName(invocation.method.fullName);
            return new InvocationImpl(invocation.invocationTarget, invocation.method.fullName, invocation.arguments, new AsmockOriginalCallSeam(invocation));
        }

        private static function extractFunctionName(fullName:String):String
        {
            try
            {
                var index:int = fullName.indexOf('/');
                if (index >= 0)
                {
                    fullName = fullName.substr(index + 1);
                    if (isGetOrSet(fullName))
                        fullName = reformatGetterOrSetter(fullName);
                }
            } catch (e:Error)
            {
            }
            return fullName;
        }

        private static function reformatGetterOrSetter(fullName:String):String
        {
            var index:int = fullName.lastIndexOf("/");
            var getSet:String = fullName.substring(index + 1);
            return getSet + " " + fullName.substring(0, index - 1);
        }

        private static function isGetOrSet(fullName:String):Boolean
        {
            return fullName.lastIndexOf("/get") != -1 || fullName.lastIndexOf("/set") != -1;
        }

        public function prepareClasses(classes:Array, calledWhenClassesReady:Function):void
        {
            var dispatcher:IEventDispatcher = super.prepare(classes);
            var repositoryPreparedHandler:Function = function (e:Event):void
            {
                calledWhenClassesReady();
            };
            dispatcher.addEventListener(Event.COMPLETE, repositoryPreparedHandler);
        }

        public function mock(clazz:Class, name:String=null, constructorArgs:Array=null):*
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

        /**
         * 
         * @param mock
         * @param name
         */
        public function registerAlias(mock:Object, name:String):void
        {
            _names[mock] = name;
        }
    }
}