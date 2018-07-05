package net.wg.mock
{
    import net.wg.utils.ITweenManager;
    import net.wg.infrastructure.interfaces.ITween;
    import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
    import net.wg.infrastructure.managers.ITweenManagerHelper;
    
    public class MockTweenManager implements ITweenManager
    {
         
        public function MockTweenManager()
        {
            super();
        }
        
        public function createNewTween(props:ITweenPropertiesVO) : ITween
        {
            return null;
        }
        
        public function dispose() : void
        {
        }
        
        public function disposeAllS() : void
        {
        }
        
        public function disposeTweenS(tween:ITween) : void
        {
        }
        
        public function getTweenManagerHelper() : ITweenManagerHelper
        {
            return null;
        }
    }
}
