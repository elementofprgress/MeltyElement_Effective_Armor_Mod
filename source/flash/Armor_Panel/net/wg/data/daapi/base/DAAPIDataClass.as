package net.wg.data.daapi.base
{
    import flash.events.EventDispatcher;
    import net.wg.infrastructure.interfaces.IDAAPIDataClass;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.DAAPIBindException;
    import avmplus.getQualifiedClassName;
    
    public class DAAPIDataClass extends EventDispatcher implements IDAAPIDataClass
    {
        
        private static const HASH_CANT_NULL_ASSERT_MESSAGE:String = "Hash" + Errors.CANT_NULL;
        
        private static const FIELD_NAME_CANT_FIND_ASSERT_MESSAGE:String = "can\'t find property for DAAPI data binding: ";
        
        private static const OBJECT_TYPE_NAME:String = "object";
         
        private var _hash:Object = null;
        
        public function DAAPIDataClass(hash:Object)
        {
            super();
            this.fromHash(hash);
        }
        
        public static function compare(obj1:Object, obj2:Object) : Boolean
        {
            var arr1:Array = null;
            var len1:uint = 0;
            var i:int = 0;
            var key:* = null;
            var destType:* = typeof obj1;
            if(destType == OBJECT_TYPE_NAME)
            {
                if(obj1 is Array)
                {
                    arr1 = obj1 as Array;
                    if(obj2 is Array)
                    {
                        len1 = arr1.length;
                        if(len1 == obj2.length)
                        {
                            for(i = 0; i < len1; i++)
                            {
                                if(!compare(arr1[i],obj2[i]))
                                {
                                    return false;
                                }
                            }
                        }
                        else
                        {
                            return false;
                        }
                    }
                    else
                    {
                        return false;
                    }
                }
                else
                {
                    for(key in obj1)
                    {
                        if(obj2.hasOwnProperty(key.toString()))
                        {
                            if(!compare(obj1[key],obj2[key]))
                            {
                                return false;
                            }
                            continue;
                        }
                        return false;
                    }
                }
            }
            else if(obj1 !== obj2)
            {
                return false;
            }
            return true;
        }
        
        public final function dispose() : void
        {
            var key:* = null;
            var value:* = undefined;
            var fieldName:String = null;
            this.onDispose();
            for(key in this._hash)
            {
                value = this._hash[key];
                fieldName = key;
                delete this[key];
            }
            this._hash = null;
        }
        
        public function fromHash(hash:Object) : void
        {
            var key:* = null;
            var value:* = undefined;
            var fieldName:String = null;
            var destType:* = null;
            var srcType:* = null;
            if(hash == null)
            {
                this.assertNotNull(false,HASH_CANT_NULL_ASSERT_MESSAGE);
            }
            this._hash = hash;
            for(key in hash)
            {
                value = hash[key];
                fieldName = key;
                if(this.onDataWrite(fieldName,value))
                {
                    if(!hasOwnProperty(fieldName))
                    {
                        this.assert(false,FIELD_NAME_CANT_FIND_ASSERT_MESSAGE + fieldName,DAAPIBindException);
                    }
                    if(value != undefined)
                    {
                        destType = typeof this[key];
                        srcType = typeof value;
                        if(destType != OBJECT_TYPE_NAME)
                        {
                            if(destType != srcType)
                            {
                                this.assert(false,"invalid type on property \'" + getQualifiedClassName(this) + "." + key + "\': can`t cast value \'" + value + "\' with type \'" + srcType + "\'to \'" + destType + "\'",DAAPIBindException);
                            }
                        }
                        else if(srcType != OBJECT_TYPE_NAME)
                        {
                            this.assert(false,"incorrect cast value \'" + value + "\' to field with type Object." + " Please, change type of \'" + getQualifiedClassName(this) + "." + key + "\' field  to \'" + srcType + "\' type or initialize it as Values.EMPTY_STR",DAAPIBindException);
                        }
                    }
                    this[key] = value;
                }
            }
        }
        
        public function isEquals(target:DAAPIDataClass) : Boolean
        {
            return compare(this._hash,target.getHash());
        }
        
        public function toHash() : Object
        {
            var fieldName:* = null;
            var value:Object = null;
            var key:String = null;
            var hash:Object = {};
            for(fieldName in this._hash)
            {
                value = this._hash[fieldName];
                key = fieldName.substr(0);
                if(this.onDataRead(fieldName,hash))
                {
                    hash[key] = value;
                }
            }
            return hash;
        }
        
        protected function onDispose() : void
        {
        }
        
        protected function onDataWrite(fieldName:String, value:Object) : Boolean
        {
            return true;
        }
        
        protected function onDataRead(fieldName:String, hash:Object) : Boolean
        {
            return true;
        }
        
        function getHash() : Object
        {
            return this._hash;
        }
        
        private function assert(flag:Boolean, msg:String, ex:Class = null) : void
        {
            App.utils.asserter.assert(flag,msg,ex);
        }
        
        private function assertNotNull(object:Object, msg:String, ex:Class = null) : void
        {
            App.utils.asserter.assert(object,msg,ex);
        }
    }
}
