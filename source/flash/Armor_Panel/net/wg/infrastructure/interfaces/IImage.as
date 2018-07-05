package net.wg.infrastructure.interfaces
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.BitmapData;
    
    public interface IImage extends IDisplayObject, IDisposable
    {
         
        function set bitmapData(param1:BitmapData) : void;
        
        function set source(param1:String) : void;
    }
}
