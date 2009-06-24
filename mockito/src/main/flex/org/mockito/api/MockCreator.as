package org.mockito.api
{
    import flash.events.IEventDispatcher;
    
    public interface MockCreator
    {
        function mock(clazz:Class, name:String=null, constructorArgs:Array=null):Object;
        
        function prepare(classes:Array):IEventDispatcher;
    }
}