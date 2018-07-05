package net.wg.mock.utils
{
    import net.wg.utils.IPopUpManager;
    import flash.display.DisplayObject;
    import net.wg.utils.helpLayout.PopupLayoutVO;
    import flash.display.DisplayObjectContainer;
    
    public class MockPopUpManager implements IPopUpManager
    {
         
        public function MockPopUpManager()
        {
            super();
        }
        
        public function contains(popup:DisplayObject) : Boolean
        {
            return false;
        }
        
        public function create(linkage:String, properties:PopupLayoutVO = null) : DisplayObject
        {
            return null;
        }
        
        public function remove(popup:DisplayObject, releaseReferencies:Boolean = true) : void
        {
        }
        
        public function removeAll() : void
        {
        }
        
        public function show(mc:DisplayObject, x:Number = 0, y:Number = 0, scope:DisplayObjectContainer = null) : void
        {
        }
        
        public function get popupCanvas() : DisplayObjectContainer
        {
            return null;
        }
    }
}
