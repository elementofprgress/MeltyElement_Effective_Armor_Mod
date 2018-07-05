package net.wg.mock.utils
{
    import net.wg.utils.IScheduler;
    
    public class MockScheduler implements IScheduler
    {
         
        public function MockScheduler()
        {
            super();
        }
        
        public function cancelAll() : void
        {
        }
        
        public function cancelTask(task:Function) : void
        {
        }
        
        public function dispose() : void
        {
        }
        
        public function isEmpty() : Boolean
        {
            return false;
        }
        
        public function scheduleNonCancelableTask(task:Function, time:Number, ... args) : void
        {
        }
        
        public function scheduleOnNextFrame(task:Function, ... args) : void
        {
        }
        
        public function scheduleRepeatableTask(task:Function, time:Number, repeatCount:int = 1, ... args) : void
        {
        }
        
        public function scheduleTask(task:Function, time:Number, ... args) : void
        {
        }
    }
}
