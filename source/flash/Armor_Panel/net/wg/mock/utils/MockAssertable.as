package net.wg.mock.utils
{
    import net.wg.utils.IAssertable;
    import flash.display.MovieClip;
    
    public class MockAssertable implements IAssertable
    {
         
        public function MockAssertable()
        {
            super();
        }
        
        public function assert(flag:Boolean, msg:String, ex:Class = null) : void
        {
        }
        
        public function assertFrameExists(frameName:String, mc:MovieClip, ex:Class = null) : void
        {
        }
        
        public function assertNotNull(object:Object, msg:String, ex:Class = null) : void
        {
        }
        
        public function assertNull(object:Object, msg:String, ex:Class = null) : void
        {
        }
        
        public function enableErrorLogging(isEnabled:Boolean) : void
        {
        }
    }
}
