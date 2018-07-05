package net.wg.mock.utils
{
    import net.wg.utils.IIME;
    import flash.display.Sprite;
    
    public class MockIME implements IIME
    {
         
        public function MockIME()
        {
            super();
        }
        
        public function dispose() : void
        {
        }
        
        public function getContainer() : Sprite
        {
            return null;
        }
        
        public function init(lanBarIsEnable:Boolean) : void
        {
        }
        
        public function onLangBarResize(x:Number, y:Number) : void
        {
        }
        
        public function setVisible(state:Boolean) : void
        {
        }
    }
}
