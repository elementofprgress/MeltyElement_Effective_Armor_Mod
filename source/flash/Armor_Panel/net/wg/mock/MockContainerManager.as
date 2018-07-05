package net.wg.mock
{
    import net.wg.infrastructure.managers.IContainerManager;
    import net.wg.infrastructure.interfaces.IManagedContainer;
    import net.wg.infrastructure.managers.ILoaderManager;
    import net.wg.infrastructure.interfaces.IView;
    import flash.events.Event;
    
    public class MockContainerManager implements IContainerManager
    {
         
        public function MockContainerManager()
        {
            super();
        }
        
        public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
        {
        }
        
        public function getContainersFocusOrder() : Vector.<String>
        {
            return null;
        }
        
        public function hasEventListener(type:String) : Boolean
        {
            return false;
        }
        
        public function hide(containerNames:Array) : void
        {
        }
        
        public function isModalViewsExisting() : Boolean
        {
            return false;
        }
        
        public function isShown(containerName:String) : void
        {
        }
        
        public function registerContainer(container:IManagedContainer) : void
        {
        }
        
        public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
        {
        }
        
        public function show(containerNames:Array) : void
        {
        }
        
        public function updateFocus(target:Object = null) : void
        {
        }
        
        public function updateStage(w:Number, h:Number) : void
        {
        }
        
        public function willTrigger(type:String) : Boolean
        {
            return false;
        }
        
        public function set loader(value:ILoaderManager) : void
        {
        }
        
        public function get lastFocusedView() : IView
        {
            return null;
        }
        
        public function set lastFocusedView(value:IView) : void
        {
        }
        
        public function dispatchEvent(event:Event) : Boolean
        {
            return false;
        }
    }
}
