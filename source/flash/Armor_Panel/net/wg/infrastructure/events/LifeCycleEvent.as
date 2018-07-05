package net.wg.infrastructure.events
{
    import flash.events.Event;
    
    public class LifeCycleEvent extends Event
    {
        
        public static const ON_BEFORE_POPULATE:String = "onBeforePopulate";
        
        public static const ON_AFTER_POPULATE:String = "onAfterPopulate";
        
        public static const ON_POPULATE:String = ON_AFTER_POPULATE;
        
        public static const ON_BEFORE_DISPOSE:String = "onBefireDispose";
        
        public static const ON_AFTER_DISPOSE:String = "onAfterDispose";
        
        public static const ON_DISPOSE:String = ON_BEFORE_DISPOSE;
         
        public function LifeCycleEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type,bubbles,cancelable);
        }
        
        override public function clone() : Event
        {
            return new LifeCycleEvent(type,bubbles,cancelable);
        }
    }
}
