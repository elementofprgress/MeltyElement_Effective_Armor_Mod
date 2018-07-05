package net.wg.utils
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.infrastructure.interfaces.IImageData;
    
    public interface IImageManager extends IDisposable
    {
         
        function set maxCacheSize(param1:int) : void;
        
        function set minCacheSize(param1:int) : void;
        
        function getImageData(param1:String) : IImageData;
    }
}
