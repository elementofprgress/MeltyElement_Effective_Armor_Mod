package net.wg.mock
{
    import net.wg.infrastructure.managers.IPopoverManager;
    import net.wg.infrastructure.interfaces.IPopOverCaller;
    import net.wg.infrastructure.interfaces.IClosePopoverCallback;
    
    public class MockPopoverManager implements IPopoverManager
    {
         
        public function MockPopoverManager()
        {
            super();
        }
        
        public function dispose() : void
        {
        }
        
        public function hide() : void
        {
        }
        
        public function show(popoverCaller:IPopOverCaller, popoverAlias:String, data:Object = null, client:IClosePopoverCallback = null) : void
        {
        }
        
        public function get popoverCaller() : IPopOverCaller
        {
            return null;
        }
    }
}
