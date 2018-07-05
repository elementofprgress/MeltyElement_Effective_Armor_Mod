package net.wg.mock.utils
{
    import net.wg.infrastructure.interfaces.entity.ISerializable;
    
    public class MockJSON implements ISerializable
    {
         
        public function MockJSON()
        {
            super();
        }
        
        public function decode(serializedString:String) : Object
        {
            return null;
        }
        
        public function encode(object:*) : String
        {
            return "";
        }
    }
}
