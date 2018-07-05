package net.wg.mock
{
    import net.wg.infrastructure.managers.ISoundManager;
    import net.wg.infrastructure.interfaces.entity.ISoundable;
    import flash.events.Event;
    
    public class MockSoundManager implements ISoundManager
    {
         
        public function MockSoundManager()
        {
            super();
        }
        
        public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
        {
        }
        
        public function addSoundsHdlrs(container:ISoundable) : void
        {
        }
        
        public function hasEventListener(type:String) : Boolean
        {
            return false;
        }
        
        public function playControlsSnd(state:String, type:String, id:String) : void
        {
        }
        
        public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
        {
        }
        
        public function removeSoundHdlrs(container:ISoundable) : void
        {
        }
        
        public function soundEventHandlerS(group:String, state:String, type:String, id:String) : void
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
