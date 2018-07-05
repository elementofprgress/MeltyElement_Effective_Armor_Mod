package net.wg.mock.utils
{
    import net.wg.utils.IEventCollector;
    import flash.events.IEventDispatcher;
    import flash.display.DisplayObject;
    import net.wg.infrastructure.interfaces.IDAAPIModule;
    
    public class MockEventCollector implements IEventCollector
    {
         
        public function MockEventCollector()
        {
            super();
        }
        
        public function addEvent(obj:IEventDispatcher, event:String, func:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
        {
        }
        
        public function disableDisposingForObj(obj:DisplayObject) : void
        {
        }
        
        public function dispose() : void
        {
        }
        
        public function enableDisposingForObj(obj:DisplayObject) : void
        {
        }
        
        public function hasRegisteredEvent(obj:Object, event:String, func:Function, useCapture:Boolean) : Boolean
        {
            return false;
        }
        
        public function logState() : void
        {
        }
        
        public function objectIsRegistered(obj:Object) : Boolean
        {
            return false;
        }
        
        public function removeAllEvents() : void
        {
        }
        
        public function removeEvent(obj:Object, event:String, func:Function, useCapture:Boolean = false) : void
        {
        }
        
        public function removeModuleEvents(view:IDAAPIModule) : void
        {
        }
        
        public function removeObjectEvents(obj:Object, needModuleCleanup:Boolean = true) : void
        {
        }
        
        public function setEnabled(value:Boolean) : void
        {
        }
    }
}
