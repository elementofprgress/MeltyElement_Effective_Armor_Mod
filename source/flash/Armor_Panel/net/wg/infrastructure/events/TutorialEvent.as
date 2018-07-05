package net.wg.infrastructure.events
{
    import flash.events.Event;
    import flash.display.DisplayObject;
    
    public class TutorialEvent extends Event
    {
        
        public static const VIEW_READY_FOR_TUTORIAL:String = "viewReadyForTutorial";
         
        public var pathPointNames:Vector.<String>;
        
        public var pathPointObjects:Vector.<DisplayObject>;
        
        public var unstoppable:Boolean = false;
        
        public function TutorialEvent(type:String, unstoppable:Boolean = false)
        {
            this.pathPointNames = new Vector.<String>();
            this.pathPointObjects = new Vector.<DisplayObject>();
            super(type,true,false);
            this.unstoppable = unstoppable;
        }
        
        override public function clone() : Event
        {
            var event:TutorialEvent = new TutorialEvent(type,this.unstoppable);
            event.pathPointNames = this.pathPointNames.concat();
            event.pathPointObjects = this.pathPointObjects.concat();
            return event;
        }
        
        public function addPathPoint(component:DisplayObject, point:String) : void
        {
            this.pathPointNames.unshift(point);
            this.pathPointObjects.unshift(component);
        }
    }
}
