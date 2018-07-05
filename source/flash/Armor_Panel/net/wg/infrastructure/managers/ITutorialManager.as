package net.wg.infrastructure.managers
{
    import net.wg.infrastructure.base.meta.ITutorialManagerMeta;
    import net.wg.infrastructure.events.TutorialEvent;
    import flash.display.DisplayObject;
    import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
    import net.wg.infrastructure.interfaces.IView;
    
    public interface ITutorialManager extends ITutorialManagerMeta
    {
         
        function onComponentCheckComplete(param1:String, param2:TutorialEvent) : void;
        
        function onComponentCreatedByLinkage(param1:DisplayObject, param2:String) : void;
        
        function addListenersToCustomTutorialComponent(param1:ITutorialCustomComponent) : void;
        
        function removeListenersFromCustomTutorialComponent(param1:ITutorialCustomComponent) : void;
        
        function dispatchEventForCustomComponent(param1:ITutorialCustomComponent) : void;
        
        function setupHintBuilder(param1:IView, param2:String, param3:Object, param4:DisplayObject = null) : void;
        
        function get isSystemEnabled() : Object;
    }
}
