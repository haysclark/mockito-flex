package org.mockito.impl
{
    import asmock.framework.proxy.IInvocation;
    import asmock.reflection.MethodInfo;
    import asmock.reflection.Type;

    public class MockAsmockInvocation implements IInvocation
    {
        private var _args:Array;
        private var _invocationTarget:Object;
        private var _method:MethodInfo;
        
        public function MockAsmockInvocation()
        {
        }

        public function get arguments():Array
        {
            return _args;
        }
        
        public function set arguments(args:Array):void
        {
            _args = args;
        }
        
        public function get targetType():Type
        {
            return null;
        }
        
        public function get proxy():Object
        {
            return null;
        }
        
        public function get method():MethodInfo
        {
            return _method;
        }
        
        public function set method(m:MethodInfo):void
        {
            _method = m;
        }
        
        public function get invocationTarget():Object
        {
            return _invocationTarget;
        }
        
        public function set invocationTarget(t:Object):void
        {
            _invocationTarget = t;
        }
        
        public function get methodInvocationTarget():MethodInfo
        {
            return null;
        }
        
        public function get returnValue():Object
        {
            return null;
        }
        
        public function set returnValue(value:Object):void
        {
        }
        
        public function proceed():void
        {
        }
        
    }
}