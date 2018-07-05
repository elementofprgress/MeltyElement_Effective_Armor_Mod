package net.wg.mock
{
    import net.wg.infrastructure.managers.IColorSchemeManager;
    import net.wg.infrastructure.interfaces.IColorScheme;
    import flash.geom.ColorTransform;
    import flash.events.Event;
    
    public class MockColorSchemeManager implements IColorSchemeManager
    {
         
        public function MockColorSchemeManager()
        {
            super();
        }
        
        public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
        {
        }
        
        public function as_update() : void
        {
        }
        
        public function getAliasColor(schemeName:String) : String
        {
            return "";
        }
        
        public function getColorSchemeS(schemeName:String) : Object
        {
            return null;
        }
        
        public function getRGB(schemeName:String) : Number
        {
            return 0;
        }
        
        public function getScheme(schemeName:String) : IColorScheme
        {
            return null;
        }
        
        public function getTransform(schemeName:String) : ColorTransform
        {
            return null;
        }
        
        public function hasEventListener(type:String) : Boolean
        {
            return false;
        }
        
        public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
        {
        }
        
        public function willTrigger(type:String) : Boolean
        {
            return false;
        }
        
        public function dispatchEvent(event:Event) : Boolean
        {
            return false;
        }
    }
}
