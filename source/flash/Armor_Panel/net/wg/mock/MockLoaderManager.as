package net.wg.mock
{
    import net.wg.infrastructure.managers.ILoaderManager;
    import flash.display.DisplayObjectContainer;
    import net.wg.infrastructure.interfaces.IView;
    import flash.events.Event;
    
    public class MockLoaderManager implements ILoaderManager
    {
         
        public function MockLoaderManager()
        {
            super();
        }
        
        public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
        {
        }
        
        public function as_loadView(config:Object, alias:String, name:String, viewTutorialId:String = null) : void
        {
        }
        
        public function getStats() : String
        {
            return "";
        }
        
        public function hasEventListener(type:String) : Boolean
        {
            return false;
        }
        
        public function initLibraries(container:DisplayObjectContainer) : void
        {
        }
        
        public function loadLibraries(librariesList:Vector.<String>) : void
        {
        }
        
        public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
        {
        }
        
        public function stopLoadingByAliases(aliases:Array) : void
        {
        }
        
        public function viewInitializationErrorS(config:Object, alias:String, name:String) : void
        {
        }
        
        public function viewLoadErrorS(alias:String, name:String, text:String) : void
        {
        }
        
        public function viewLoadedS(name:String, view:IView) : void
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
