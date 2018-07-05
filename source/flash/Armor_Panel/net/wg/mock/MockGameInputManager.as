package net.wg.mock
{
    import net.wg.utils.IGameInputManager;
    import flash.events.IEventDispatcher;
    import flash.events.Event;
    
    public class MockGameInputManager implements IGameInputManager
    {
         
        public function MockGameInputManager()
        {
            super();
        }
        
        public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
        {
        }
        
        public function as_addKeyHandler(keyCode:Number, eventType:String, ignoreText:Boolean, cancelEventType:String = null) : void
        {
        }
        
        public function as_clearKeyHandler(keyCode:Number, eventType:String) : void
        {
        }
        
        public function clearKeyHandler(keyCode:Number, type:String) : void
        {
        }
        
        public function clearKeyHandlers() : void
        {
        }
        
        public function dispose() : void
        {
        }
        
        public function handleGlobalKeyEventS(keyCode:Number, eventType:String) : void
        {
        }
        
        public function hasEventListener(type:String) : Boolean
        {
            return false;
        }
        
        public function initStage(stage:IEventDispatcher) : void
        {
        }
        
        public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
        {
        }
        
        public function setIgnoredKeyCode(keyCode:Number) : void
        {
        }
        
        public function setKeyHandler(keyCode:Number, event:String, handler:Function, ignoreText:Boolean, cancelEventType:String = null) : void
        {
        }
        
        public function willTrigger(type:String) : Boolean
        {
            return false;
        }
        
        public function dispatchEvent(event:Event) : Boolean
        {
            return false;
        }
    }
}
