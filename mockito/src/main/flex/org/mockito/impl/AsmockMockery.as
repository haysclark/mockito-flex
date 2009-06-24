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