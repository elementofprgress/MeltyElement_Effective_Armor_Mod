package net.wg.mock
{
    import net.wg.infrastructure.managers.IEnvironmentManager;
    
    public class MockEnvironmentManager implements IEnvironmentManager
    {
         
        public function MockEnvironmentManager()
        {
            super();
        }
        
        public function addCallback(cmd:String, callback:Function) : void
        {
        }
        
        public function call(... args) : *
        {
            return null;
        }
        
        public function envoke(cmd:String) : *
        {
            return null;
        }
        
        public function logoff() : void
        {
        }
        
        public function quit() : void
        {
        }
        
        public function setLastResult(result:Object) : void
        {
        }
        
        public function useEventSystem() : void
        {
        }
        
        public function useExternallInterface() : void
        {
        }
    }
}
