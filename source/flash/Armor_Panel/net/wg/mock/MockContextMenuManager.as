package net.wg.mock
{
    import net.wg.infrastructure.managers.IContextMenuManager;
    import flash.display.DisplayObject;
    import flash.events.Event;
    
    public class MockContextMenuManager implements IContextMenuManager
    {
         
        public function MockContextMenuManager()
        {
            super();
        }
        
        public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
        {
        }
        
        public function as_hide() : void
        {
        }
        
        public function as_setOptions(data:Object) : void
        {
        }
        
        public function dispose() : void
        {
        }
        
        public function hasEventListener(type:String) : Boolean
        {
            return false;
        }
        
        public function hide() : void
        {
        }
        
        public function isShown() : Boolean
        {
            return false;
        }
        
        public function onHideS() : void
        {
        }
        
        public function onOptionSelectS(optionId:String) : void
        {
        }
        
        public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
        {
        }
        
        public function requestOptionsS(type:String, ctx:Object = null) : void
        {
        }
        
        public function show(type:String, owner:DisplayObject, ctx:Object = null) : void
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
