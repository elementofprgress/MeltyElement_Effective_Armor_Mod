package net.wg.mock.utils
{
    import net.wg.utils.IFocusHandler;
    import flash.display.InteractiveObject;
    import net.wg.infrastructure.interfaces.IView;
    import scaleform.clik.ui.InputDetails;
    import net.wg.infrastructure.interfaces.IManagedContent;
    import flash.display.Stage;
    
    public class MockFocusHandler implements IFocusHandler
    {
         
        public function MockFocusHandler()
        {
            super();
        }
        
        public function dispose() : void
        {
        }
        
        public function getFocus(focusGroupIdx:uint) : InteractiveObject
        {
            return null;
        }
        
        public function getModalFocus() : IView
        {
            return null;
        }
        
        public function hasModalFocus(view:IView) : Boolean
        {
            return false;
        }
        
        public function input(details:InputDetails) : void
        {
        }
        
        public function setFocus(focus:InteractiveObject, focusGroupIdx:uint = 0, mouseChange:Boolean = false) : void
        {
        }
        
        public function setModalFocus(view:IManagedContent) : void
        {
        }
        
        public function set stage(value:Stage) : void
        {
        }
    }
}
