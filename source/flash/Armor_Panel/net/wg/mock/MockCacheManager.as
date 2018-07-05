package net.wg.mock
{
    import net.wg.infrastructure.managers.ICacheManager;
    import flash.display.Loader;
    import flash.events.Event;
    
    public class MockCacheManager implements ICacheManager
    {
         
        public function MockCacheManager()
        {
            super();
        }
        
        public function add(url:String, loader:Loader, classDef:Class = null) : Boolean
        {
            return false;
        }
        
        public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
        {
        }
        
        public function getClassDef(url:String, raise:Boolean = false) : Class
        {
            return null;
        }
        
        public function getSettingsS() : Object
        {
            return null;
        }
        
        public function hasEventListener(type:String) : Boolean
        {
            return false;
        }
        
        public function isCached(url:String) : Boolean
        {
            return false;
        }
        
        public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
        {
        }
        
        public function willTrigger(type:String) : Boolean
        {
            return false;
        }
        
        public function get enabled() : Boolean
        {
            return false;
        }
        
        public function dispatchEvent(event:Event) : Boolean
        {
            return false;
        }
    }
}
