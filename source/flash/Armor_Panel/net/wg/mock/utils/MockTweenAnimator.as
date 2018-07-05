package net.wg.mock.utils
{
    import net.wg.utils.ITweenAnimator;
    import flash.display.DisplayObject;
    import net.wg.infrastructure.interfaces.ITweenAnimatorHandler;
    import net.wg.infrastructure.interfaces.ITween;
    import net.wg.infrastructure.interfaces.ITweenPropertiesVO;
    
    public class MockTweenAnimator implements ITweenAnimator
    {
         
        public function MockTweenAnimator()
        {
            super();
        }
        
        public function addFadeInAnim(target:DisplayObject, handler:ITweenAnimatorHandler) : void
        {
        }
        
        public function addFadeInAnimEx(target:DisplayObject) : ITween
        {
            return null;
        }
        
        public function addFadeOutAnim(target:DisplayObject, handler:ITweenAnimatorHandler) : void
        {
        }
        
        public function addFadeOutAnimEx(target:DisplayObject) : ITween
        {
            return null;
        }
        
        public function addHalfTurnAnim(_target:DisplayObject) : void
        {
        }
        
        public function addHalfTurnAnimEx(_target:DisplayObject) : ITween
        {
            return null;
        }
        
        public function addMoveDownAnim(target:DisplayObject, baseY:Number, handler:ITweenAnimatorHandler) : void
        {
        }
        
        public function addMoveDownAnimEx(target:DisplayObject, baseY:Number) : ITween
        {
            return null;
        }
        
        public function addMoveUpAnim(target:DisplayObject, baseY:Number, handler:ITweenAnimatorHandler) : void
        {
        }
        
        public function addMoveUpAnimEx(target:DisplayObject, baseY:Number) : ITween
        {
            return null;
        }
        
        public function blinkInfinity(element:DisplayObject) : void
        {
        }
        
        public function createPropsForAlpha(curElement:DisplayObject, duration:uint, resultAlpha:Number, globalDelay:uint = 0) : ITweenPropertiesVO
        {
            return null;
        }
        
        public function createPropsForFrameBasedAnim(curElement:DisplayObject, duration:int, globalDelay:int) : ITweenPropertiesVO
        {
            return null;
        }
        
        public function dispose() : void
        {
        }
        
        public function onComplete(tween:ITween) : void
        {
        }
        
        public function onStart(tween:ITween) : void
        {
        }
        
        public function removeAnims(target:DisplayObject) : void
        {
        }
    }
}
