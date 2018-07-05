package net.wg.mock.utils
{
    import net.wg.utils.IAnimBuilder;
    import net.wg.utils.animation.ITweenConstruction;
    import flash.display.DisplayObject;
    import net.wg.infrastructure.interfaces.ITweenConstructionHandler;
    import net.wg.infrastructure.interfaces.ITween;
    
    public class MockAnimBuilder implements IAnimBuilder
    {
         
        public function MockAnimBuilder()
        {
            super();
        }
        
        public function addFadeIn(target:DisplayObject, handler:ITweenConstructionHandler, delay:int, delayType:String = null) : ITweenConstruction
        {
            return null;
        }
        
        public function addFadeOut(target:DisplayObject, handler:ITweenConstructionHandler, delay:int, delayType:String = null) : ITweenConstruction
        {
            return null;
        }
        
        public function addGlowIn(target:DisplayObject, handler:ITweenConstructionHandler, delay:int, delayType:String = null) : ITweenConstruction
        {
            return null;
        }
        
        public function addGlowOut(target:DisplayObject, handler:ITweenConstructionHandler, delay:int, delayType:String = null) : ITweenConstruction
        {
            return null;
        }
        
        public function addHalfTurn(target:DisplayObject, handler:ITweenConstructionHandler, delay:int, delayType:String = null) : ITweenConstruction
        {
            return null;
        }
        
        public function addMoveDown(target:DisplayObject, handler:ITweenConstructionHandler, delay:int, delayType:String = null) : ITweenConstruction
        {
            return null;
        }
        
        public function addMoveUp(target:DisplayObject, handler:ITweenConstructionHandler, delay:int, delayType:String = null) : ITweenConstruction
        {
            return null;
        }
        
        public function addShadowIn(target:DisplayObject, handler:ITweenConstructionHandler, delay:int, delayType:String = null) : ITweenConstruction
        {
            return null;
        }
        
        public function addShadowOut(target:DisplayObject, handler:ITweenConstructionHandler, delay:int, delayType:String = null) : ITweenConstruction
        {
            return null;
        }
        
        public function addTween(delayType:String, delay:int, tween:ITween, target:DisplayObject, handler:ITweenConstructionHandler) : ITweenConstruction
        {
            return null;
        }
    }
}
