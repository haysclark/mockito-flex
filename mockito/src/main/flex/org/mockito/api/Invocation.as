package org.mockito.api
{
    public interface Invocation
    {
        function get verified():Boolean;
        function set verified(b:Boolean):void;
        
        function get args():Array;
        
        function get target():Object;
        
        function get methodName():String;
        
        function describe():String;
        
        function matches(other:Invocation):Boolean;
        
        function addAnswer(answer:Answer):void;
        
        function answer():*;
        
        function useMatchers(matchers:Array):void;
        
        function isStubbed():Boolean;
    }
}