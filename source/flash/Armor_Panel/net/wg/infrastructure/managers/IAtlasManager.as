package net.wg.infrastructure.managers
{
    import flash.events.IEventDispatcher;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.Graphics;
    
    public interface IAtlasManager extends IEventDispatcher, IDisposable
    {
         
        function registerAtlas(param1:String) : void;
        
        function isAtlasInitialized(param1:String) : Boolean;
        
        function drawGraphics(param1:String, param2:String, param3:Graphics, param4:Boolean = false, param5:Boolean = false) : void;
    }
}
