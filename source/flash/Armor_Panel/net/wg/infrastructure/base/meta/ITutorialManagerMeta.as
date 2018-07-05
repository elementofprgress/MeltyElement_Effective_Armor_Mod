package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface ITutorialManagerMeta extends IEventDispatcher
    {
         
        function onComponentFoundS(param1:String) : Array;
        
        function onComponentDisposedS(param1:String) : void;
        
        function onTriggerActivatedS(param1:String, param2:String) : void;
        
        function requestCriteriaValueS(param1:String) : void;
        
        function as_setSystemEnabled(param1:Boolean) : void;
        
        function as_setDescriptions(param1:Object) : void;
        
        function as_setCriteria(param1:String, param2:String, param3:Boolean = true) : void;
        
        function as_setTriggers(param1:String, param2:Array) : void;
        
        function as_showHint(param1:String, param2:String, param3:Object, param4:Boolean = false) : void;
        
        function as_hideHint(param1:String, param2:String) : void;
    }
}
