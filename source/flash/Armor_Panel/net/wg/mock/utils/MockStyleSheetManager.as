package net.wg.mock.utils
{
    import net.wg.utils.IStyleSheetManager;
    import flash.text.TextField;
    
    public class MockStyleSheetManager implements IStyleSheetManager
    {
         
        public function MockStyleSheetManager()
        {
            super();
        }
        
        public function setForceFocusedStyle(str:String) : String
        {
            return "";
        }
        
        public function setLinkStyle(textField:TextField) : void
        {
        }
    }
}
