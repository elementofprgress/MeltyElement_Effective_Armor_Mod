package net.wg.infrastructure.managers
{
    import net.wg.infrastructure.base.meta.ILoaderManagerMeta;
    import flash.display.DisplayObjectContainer;
    
    public interface ILoaderManager extends ILoaderManagerMeta, IStats
    {
         
        function initLibraries(param1:DisplayObjectContainer) : void;
        
        function loadLibraries(param1:Vector.<String>) : void;
        
        function stopLoadingByAliases(param1:Array) : void;
    }
}
