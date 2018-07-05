package net.wg.mock
{
    import net.wg.infrastructure.managers.IGlobalVarsManager;
    import flash.events.Event;
    
    public class MockGlobalVarsManager implements IGlobalVarsManager
    {
         
        public function MockGlobalVarsManager()
        {
            super();
        }
        
        public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
        {
        }
        
        public function getLocaleOverrideS() : String
        {
            return "";
        }
        
        public function hasEventListener(type:String) : Boolean
        {
            return false;
        }
        
        public function isChinaS() : Boolean
        {
            return false;
        }
        
        public function isDevelopmentS() : Boolean
        {
            return false;
        }
        
        public function isFortificationAvailableS() : Boolean
        {
            return false;
        }
        
        public function isFreeXpToTankmanS() : Boolean
        {
            return false;
        }
        
        public function isInRoamingS() : Boolean
        {
            return false;
        }
        
        public function isKoreaS() : Boolean
        {
            return false;
        }
        
        public function isPotapovQuestEnabledS() : Boolean
        {
            return false;
        }
        
        public function isRentalsEnabledS() : Boolean
        {
            return false;
        }
        
        public function isRoamingEnabledS() : Boolean
        {
            return false;
        }
        
        public function isShowLangaugeBarS() : Boolean
        {
            return false;
        }
        
        public function isShowServerStatsS() : Boolean
        {
            return false;
        }
        
        public function isShowTickerS() : Boolean
        {
            return false;
        }
        
        public function isTutorialRunningS(tutorialID:String) : Boolean
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
        
        public function isLoginLoadedAtFirstTimeS() : Boolean
        {
            return false;
        }
    }
}
