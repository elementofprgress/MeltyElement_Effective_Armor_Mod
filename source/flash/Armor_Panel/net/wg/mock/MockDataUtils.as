package net.wg.mock
{
    import net.wg.utils.IDataUtils;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.infrastructure.interfaces.IDAAPIDataClass;
    import org.idmedia.as3commons.util.Map;
    
    public class MockDataUtils implements IDataUtils
    {
         
        public function MockDataUtils()
        {
            super();
        }
        
        public function cleanVectorOfDisposables(vctr:Vector.<IDisposable>) : void
        {
        }
        
        public function cleanupDynamicObject(object:Object) : Object
        {
            return null;
        }
        
        public function cleanupDynamicObjectsCouple(hash:Object, synchedObject:Object) : Object
        {
            return null;
        }
        
        public function cloneObject(origin:Object) : *
        {
            return null;
        }
        
        public function convertVOArrayToVector(fieldName:String, value:Object, voType:Class) : Vector.<IDAAPIDataClass>
        {
            return null;
        }
        
        public function convertNumberArrayToVector(fieldName:String, value:Object) : Vector.<Number>
        {
            return null;
        }
        
        public function createMap(pureHash:Array) : Map
        {
            return null;
        }
        
        public function createMappedArray(pureHash:Array) : Array
        {
            return null;
        }
        
        public function vectorToArray(vector:Object) : Array
        {
            return null;
        }
    }
}
