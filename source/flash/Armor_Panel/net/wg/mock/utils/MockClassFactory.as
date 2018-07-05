package net.wg.mock.utils
{
    import net.wg.utils.IClassFactory;
    import flash.utils.getDefinitionByName;
    import net.wg.data.constants.Errors;
    import net.wg.utils.IAssertable;
    import flash.display.DisplayObject;
    import net.wg.infrastructure.exceptions.InvalidComponentCastException;
    import net.wg.infrastructure.exceptions.ArgumentException;
    
    public class MockClassFactory implements IClassFactory
    {
         
        public function MockClassFactory()
        {
            super();
        }
        
        public function dispose() : void
        {
        }
        
        public function getClass(classpath:String) : Class
        {
            var outcomeClass:Class = null;
            try
            {
                outcomeClass = getDefinitionByName(classpath) as Class;
            }
            catch(e:ReferenceError)
            {
                DebugUtils.LOG_ERROR(Errors.BAD_LINKAGE + classpath);
            }
            return outcomeClass;
        }
        
        public function getClassName(value:*) : String
        {
            return "";
        }
        
        public function getComponent(linkage:String, instanceClass:Class, params:Object = null) : *
        {
            var object:Object = this.getObject(linkage,params);
            var LNKG:* = "object with \"" + linkage + "\" linkage ";
            var MSG:* = LNKG + "is not a component from library!";
            var CANT_CAST:String = LNKG + "can`t cast to " + instanceClass;
            var asserter:IAssertable = App.utils.asserter;
            asserter.assert(object is DisplayObject,MSG,InvalidComponentCastException);
            asserter.assert(object is instanceClass,CANT_CAST,InvalidComponentCastException);
            return object;
        }
        
        public function getObject(linkage:String, params:Object = null) : Object
        {
            var key:* = null;
            var MSG:* = null;
            var outcome:Object = null;
            var outcomeClass:Class = this.getClass(linkage);
            if(outcomeClass != null)
            {
                outcome = new outcomeClass();
                if(params != null)
                {
                    for(key in params)
                    {
                        if(outcome.hasOwnProperty(key))
                        {
                            outcome[key] = params[key];
                            continue;
                        }
                        MSG = "object with linkage \'" + linkage + "\' doesn`t contain property " + "with name \'" + key + "\'. Initialization error.";
                        throw new ArgumentException(MSG);
                    }
                }
            }
            return outcome;
        }
        
        public function get createComponentCallback() : Function
        {
            return null;
        }
        
        public function set createComponentCallback(value:Function) : void
        {
        }
    }
}
