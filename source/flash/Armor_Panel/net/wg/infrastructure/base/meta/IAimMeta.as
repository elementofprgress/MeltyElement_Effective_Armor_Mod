package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IAimMeta extends IEventDispatcher
    {
         
        function as_initSettings(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:Number, param12:Number) : void;
        
        function as_recreateDevice(param1:Number, param2:Number) : void;
        
        function as_setupReloadingCounter(param1:Boolean) : void;
        
        function as_setReloading(param1:Number, param2:Number, param3:Boolean, param4:Number, param5:Number = 0) : void;
        
        function as_setReloadingAsPercent(param1:Number, param2:Boolean) : void;
        
        function as_correctReloadingTime(param1:Number) : void;
        
        function as_setReloadingTimeWithCorrection(param1:Number, param2:Number, param3:Boolean) : void;
        
        function as_setHealth(param1:Number) : void;
        
        function as_setAmmoStock(param1:Number, param2:Number, param3:Boolean, param4:String, param5:Boolean = false) : void;
        
        function as_setClipParams(param1:Number, param2:Number) : void;
        
        function as_setTarget(param1:String, param2:String, param3:Number) : void;
        
        function as_clearTarget(param1:Number) : void;
        
        function as_updateTarget(param1:Number) : void;
        
        function as_updatePlayerInfo(param1:String) : void;
        
        function as_updateAmmoState(param1:Boolean) : void;
        
        function as_updateAmmoInfoPos() : void;
        
        function as_updateAdjust(param1:Number, param2:Number, param3:Number, param4:Number) : void;
        
        function as_updateDistance(param1:Number) : void;
        
        function as_updateReloadingBaseTime(param1:Number, param2:Boolean) : void;
        
        function as_clearPreviousCorrection() : void;
    }
}
