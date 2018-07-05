package net.wg.mock
{
    import net.wg.infrastructure.managers.IVoiceChatManager;
    import flash.events.Event;
    
    public class MockVoiceChatManager implements IVoiceChatManager
    {
         
        public function MockVoiceChatManager()
        {
            super();
        }
        
        public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
        {
        }
        
        public function as_onPlayerSpeak(accountDBID:Number, isSpeak:Boolean, isHimself:Boolean) : void
        {
        }
        
        public function hasEventListener(type:String) : Boolean
        {
            return false;
        }
        
        public function isPlayerSpeakingS(accountDBID:Number) : Boolean
        {
            return false;
        }
        
        public function isVOIPEnabledS() : Boolean
        {
            return false;
        }
        
        public function isVivoxS() : Boolean
        {
            return false;
        }
        
        public function isYYS() : Boolean
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
        
        public function dispatchEvent(event:Event) : Boolean
        {
            return false;
        }
        
        public function getYY() : Boolean
        {
            return false;
        }
    }
}
