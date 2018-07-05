package net.wg.mock.utils
{
    import net.wg.utils.IImageManager;
    import net.wg.infrastructure.interfaces.IImageData;
    
    public class MockImageManager implements IImageManager
    {
         
        public function MockImageManager()
        {
            super();
        }
        
        public function dispose() : void
        {
        }
        
        public function getImageData(source:String) : IImageData
        {
            return null;
        }
        
        public function set maxCacheSize(value:int) : void
        {
        }
        
        public function set minCacheSize(value:int) : void
        {
        }
    }
}
