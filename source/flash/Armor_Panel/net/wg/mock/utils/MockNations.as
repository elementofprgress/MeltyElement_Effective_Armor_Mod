package net.wg.mock.utils
{
    import net.wg.utils.INations;
    
    public class MockNations implements INations
    {
         
        public function MockNations()
        {
            super();
        }
        
        public function getNationID(nationName:String) : uint
        {
            return 0;
        }
        
        public function getNationIcon(nationID:int) : String
        {
            return "";
        }
        
        public function getNationName(nationID:uint) : String
        {
            return "";
        }
        
        public function getNations() : Array
        {
            return null;
        }
        
        public function getNationsData() : Array
        {
            return null;
        }
    }
}
