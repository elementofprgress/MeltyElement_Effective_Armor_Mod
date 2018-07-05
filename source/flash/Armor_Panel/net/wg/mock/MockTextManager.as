package net.wg.mock
{
    import net.wg.utils.ITextManager;
    import flash.text.TextField;
    
    public class MockTextManager implements ITextManager
    {
         
        public function MockTextManager()
        {
            super();
        }
        
        public function createTextField() : TextField
        {
            return null;
        }
        
        public function getTextStyleById(style:String, message:String) : String
        {
            return "";
        }
        
        public function setDefTextSelection(tf:TextField) : void
        {
        }
    }
}
