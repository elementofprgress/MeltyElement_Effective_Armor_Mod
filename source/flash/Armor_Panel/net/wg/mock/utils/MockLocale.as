package net.wg.mock.utils
{
    import net.wg.utils.ILocale;
    import net.wg.infrastructure.interfaces.IFormattedInt;
    
    public class MockLocale implements ILocale
    {
         
        public function MockLocale()
        {
            super();
        }
        
        public function cutCharsBeforeNumber(value:String) : String
        {
            return "";
        }
        
        public function float(value:Object) : String
        {
            return "";
        }
        
        public function gold(value:Object) : String
        {
            return "";
        }
        
        public function htmlTextWithIcon(value:String, iconType_:String) : String
        {
            return "";
        }
        
        public function integer(value:Object) : String
        {
            return "";
        }
        
        public function longDate(value:Object) : String
        {
            return "";
        }
        
        public function longTime(value:Object) : String
        {
            return "";
        }
        
        public function makeString(id:String, param:Object = null) : String
        {
            return "";
        }
        
        public function niceNumber(value:Object) : String
        {
            return "";
        }
        
        public function numberWithoutZeros(value:Object) : String
        {
            return "";
        }
        
        public function parseFormattedInteger(value:String) : IFormattedInt
        {
            return null;
        }
        
        public function shortDate(value:Object) : String
        {
            return "";
        }
        
        public function shortTime(value:Object) : String
        {
            return "";
        }
    }
}
