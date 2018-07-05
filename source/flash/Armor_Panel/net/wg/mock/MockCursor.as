package net.wg.mock
{
    import net.wg.infrastructure.interfaces.ICursor;
    import flash.display.DisplayObject;
    import flash.geom.Point;
    import flash.display.Sprite;
    import flash.geom.Rectangle;
    import net.wg.infrastructure.interfaces.IManagedContainer;
    import net.wg.infrastructure.interfaces.entity.IDragDropHitArea;
    import flash.display.InteractiveObject;
    import flash.display.Scene;
    import flash.display.Graphics;
    import flash.media.SoundTransform;
    import flash.display.Stage;
    import flash.display.DisplayObjectContainer;
    import flash.display.LoaderInfo;
    import flash.accessibility.AccessibilityProperties;
    import flash.display.Loader;
    import net.wg.infrastructure.interfaces.IView;
    import net.wg.infrastructure.interfaces.IManagedContent;
    import scaleform.clik.core.UIComponent;
    import flash.geom.Transform;
    import flash.events.Event;
    import scaleform.clik.events.InputEvent;
    
    public class MockCursor implements ICursor
    {
         
        public function MockCursor()
        {
            super();
        }
        
        public function addChild(child:DisplayObject) : DisplayObject
        {
            return null;
        }
        
        public function addChildAt(child:DisplayObject, index:int) : DisplayObject
        {
            return null;
        }
        
        public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
        {
        }
        
        public function areInaccessibleObjectsUnderPoint(point:Point) : Boolean
        {
            return false;
        }
        
        public function as_dispose() : void
        {
        }
        
        public function as_isDAAPIInited() : Boolean
        {
            return false;
        }
        
        public function as_populate() : void
        {
        }
        
        public function as_setCursor(cursor:String) : void
        {
        }
        
        public function attachToCursor(sprite:Sprite, deltaX:Number, deltaY:Number) : void
        {
        }
        
        public function contains(child:DisplayObject) : Boolean
        {
            return false;
        }
        
        public function detachFromCursor() : void
        {
        }
        
        public function dispose() : void
        {
        }
        
        public function getAttachedSprite() : Sprite
        {
            return null;
        }
        
        public function getBounds(targetCoordinateSpace:DisplayObject) : Rectangle
        {
            return null;
        }
        
        public function getChildAt(index:int) : DisplayObject
        {
            return null;
        }
        
        public function getChildByName(name:String) : DisplayObject
        {
            return null;
        }
        
        public function getChildIndex(child:DisplayObject) : int
        {
            return 0;
        }
        
        public function getObjectsUnderPoint(point:Point) : Array
        {
            return null;
        }
        
        public function getRect(targetCoordinateSpace:DisplayObject) : Rectangle
        {
            return null;
        }
        
        public function getSubContainer() : IManagedContainer
        {
            return null;
        }
        
        public function globalToLocal(point:Point) : Point
        {
            return null;
        }
        
        public function gotoAndPlay(frame:Object, scene:String = null) : void
        {
        }
        
        public function gotoAndStop(frame:Object, scene:String = null) : void
        {
        }
        
        public function hasEventListener(type:String) : Boolean
        {
            return false;
        }
        
        public function hitTestObject(obj:DisplayObject) : Boolean
        {
            return false;
        }
        
        public function hitTestPoint(x:Number, y:Number, shapeFlag:Boolean = false) : Boolean
        {
            return false;
        }
        
        public function invalidate(... invalidTypes) : void
        {
        }
        
        public function leaveModalFocus() : void
        {
        }
        
        public function localToGlobal(point:Point) : Point
        {
            return null;
        }
        
        public function lock() : void
        {
        }
        
        public function nextFrame() : void
        {
        }
        
        public function nextScene() : void
        {
        }
        
        public function play() : void
        {
        }
        
        public function playHideTween(target:DisplayObject, onTweenEnd:Function = null) : Boolean
        {
            return false;
        }
        
        public function playShowTween(target:DisplayObject, onTweenEnd:Function = null) : Boolean
        {
            return false;
        }
        
        public function prevFrame() : void
        {
        }
        
        public function prevScene() : void
        {
        }
        
        public function registerDragging(container:IDragDropHitArea, draggingCursor:String = null) : void
        {
        }
        
        public function removeChild(child:DisplayObject) : DisplayObject
        {
            return null;
        }
        
        public function removeChildAt(index:int) : DisplayObject
        {
            return null;
        }
        
        public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
        {
        }
        
        public function setActualScale(scaleX:Number, scaleY:Number) : void
        {
        }
        
        public function setActualSize(newWidth:Number, newHeight:Number) : void
        {
        }
        
        public function setChildIndex(child:DisplayObject, index:int) : void
        {
        }
        
        public function setModalFocus() : void
        {
        }
        
        public function setViewSize(width:Number, height:Number) : void
        {
        }
        
        public function startDrag(lockCenter:Boolean = false, bounds:Rectangle = null) : void
        {
        }
        
        public function stop() : void
        {
        }
        
        public function stopDrag() : void
        {
        }
        
        public function swapChildren(child1:DisplayObject, child2:DisplayObject) : void
        {
        }
        
        public function swapChildrenAt(index1:int, index2:int) : void
        {
        }
        
        public function unRegisterDragging(container:IDragDropHitArea) : void
        {
        }
        
        public function unUseResizeCursor(window:InteractiveObject) : void
        {
        }
        
        public function unlock() : void
        {
        }
        
        public function updateStage(w:Number, h:Number) : void
        {
        }
        
        public function useResizeCursor(window:InteractiveObject) : void
        {
        }
        
        public function willTrigger(type:String) : Boolean
        {
            return false;
        }
        
        public function get currentFrame() : int
        {
            return 0;
        }
        
        public function get framesLoaded() : int
        {
            return 0;
        }
        
        public function get totalFrames() : int
        {
            return 0;
        }
        
        public function get trackAsMenu() : Boolean
        {
            return false;
        }
        
        public function set trackAsMenu(value:Boolean) : void
        {
        }
        
        public function get scenes() : Array
        {
            return null;
        }
        
        public function get currentScene() : Scene
        {
            return null;
        }
        
        public function get currentFrameLabel() : String
        {
            return "";
        }
        
        public function get currentLabels() : Array
        {
            return null;
        }
        
        public function get graphics() : Graphics
        {
            return null;
        }
        
        public function get buttonMode() : Boolean
        {
            return false;
        }
        
        public function set buttonMode(value:Boolean) : void
        {
        }
        
        public function get dropTarget() : DisplayObject
        {
            return null;
        }
        
        public function get hitArea() : Sprite
        {
            return null;
        }
        
        public function set hitArea(hitArea:Sprite) : void
        {
        }
        
        public function get useHandCursor() : Boolean
        {
            return false;
        }
        
        public function set useHandCursor(value:Boolean) : void
        {
        }
        
        public function get soundTransform() : SoundTransform
        {
            return null;
        }
        
        public function set soundTransform(sndTransform:SoundTransform) : void
        {
        }
        
        public function get numChildren() : int
        {
            return 0;
        }
        
        public function get tabChildren() : Boolean
        {
            return false;
        }
        
        public function set tabChildren(enable:Boolean) : void
        {
        }
        
        public function get tabIndex() : int
        {
            return 0;
        }
        
        public function set tabIndex(index:int) : void
        {
        }
        
        public function get focusRect() : Object
        {
            return null;
        }
        
        public function set focusRect(focusRect:Object) : void
        {
        }
        
        public function get root() : DisplayObject
        {
            return null;
        }
        
        public function get stage() : Stage
        {
            return null;
        }
        
        public function get parent() : DisplayObjectContainer
        {
            return null;
        }
        
        public function get mask() : DisplayObject
        {
            return null;
        }
        
        public function set mask(value:DisplayObject) : void
        {
        }
        
        public function get mouseX() : Number
        {
            return 0;
        }
        
        public function get mouseY() : Number
        {
            return 0;
        }
        
        public function get rotation() : Number
        {
            return 0;
        }
        
        public function set rotation(value:Number) : void
        {
        }
        
        public function get cacheAsBitmap() : Boolean
        {
            return false;
        }
        
        public function set cacheAsBitmap(value:Boolean) : void
        {
        }
        
        public function get opaqueBackground() : Object
        {
            return null;
        }
        
        public function set opaqueBackground(value:Object) : void
        {
        }
        
        public function get scrollRect() : Rectangle
        {
            return null;
        }
        
        public function set scrollRect(value:Rectangle) : void
        {
        }
        
        public function get filters() : Array
        {
            return null;
        }
        
        public function set filters(value:Array) : void
        {
        }
        
        public function get blendMode() : String
        {
            return "";
        }
        
        public function set blendMode(value:String) : void
        {
        }
        
        public function get loaderInfo() : LoaderInfo
        {
            return null;
        }
        
        public function get accessibilityProperties() : AccessibilityProperties
        {
            return null;
        }
        
        public function set accessibilityProperties(value:AccessibilityProperties) : void
        {
        }
        
        public function get as_alias() : String
        {
            return "";
        }
        
        public function set as_alias(alias:String) : void
        {
        }
        
        public function get as_name() : String
        {
            return "";
        }
        
        public function set as_name(name:String) : void
        {
        }
        
        public function get as_config() : Object
        {
            return null;
        }
        
        public function set as_config(config:Object) : void
        {
        }
        
        public function get loader() : Loader
        {
            return null;
        }
        
        public function set loader(value:Loader) : void
        {
        }
        
        public function get disposed() : Boolean
        {
            return false;
        }
        
        public function get isDAAPIInited() : Boolean
        {
            return false;
        }
        
        public function get isModal() : Boolean
        {
            return false;
        }
        
        public function get modalAlpha() : Number
        {
            return 0;
        }
        
        public function get sourceView() : IView
        {
            return null;
        }
        
        public function get containerContent() : IManagedContent
        {
            return null;
        }
        
        public function get x() : Number
        {
            return 0;
        }
        
        public function set x(value:Number) : void
        {
        }
        
        public function get y() : Number
        {
            return 0;
        }
        
        public function set y(value:Number) : void
        {
        }
        
        public function get width() : Number
        {
            return 0;
        }
        
        public function set width(value:Number) : void
        {
        }
        
        public function get height() : Number
        {
            return 0;
        }
        
        public function set height(value:Number) : void
        {
        }
        
        public function get enabled() : Boolean
        {
            return false;
        }
        
        public function set enabled(value:Boolean) : void
        {
        }
        
        public function get tabEnabled() : Boolean
        {
            return false;
        }
        
        public function set tabEnabled(value:Boolean) : void
        {
        }
        
        public function get scale9Grid() : Rectangle
        {
            return null;
        }
        
        public function set scale9Grid(value:Rectangle) : void
        {
        }
        
        public function get alpha() : Number
        {
            return 0;
        }
        
        public function set alpha(value:Number) : void
        {
        }
        
        public function get doubleClickEnabled() : Boolean
        {
            return false;
        }
        
        public function set doubleClickEnabled(value:Boolean) : void
        {
        }
        
        public function get focusTarget() : UIComponent
        {
            return null;
        }
        
        public function set focusTarget(value:UIComponent) : void
        {
        }
        
        public function get scaleX() : Number
        {
            return 0;
        }
        
        public function set scaleX(value:Number) : void
        {
        }
        
        public function get scaleY() : Number
        {
            return 0;
        }
        
        public function set scaleY(value:Number) : void
        {
        }
        
        public function get enableInitCallback() : Boolean
        {
            return false;
        }
        
        public function set enableInitCallback(value:Boolean) : void
        {
        }
        
        public function get name() : String
        {
            return "";
        }
        
        public function set name(value:String) : void
        {
        }
        
        public function get mouseEnabled() : Boolean
        {
            return false;
        }
        
        public function set mouseEnabled(enabled:Boolean) : void
        {
        }
        
        public function get mouseChildren() : Boolean
        {
            return false;
        }
        
        public function set mouseChildren(enabled:Boolean) : void
        {
        }
        
        public function get actualWidth() : Number
        {
            return 0;
        }
        
        public function get actualHeight() : Number
        {
            return 0;
        }
        
        public function get actualScaleX() : Number
        {
            return 0;
        }
        
        public function get actualScaleY() : Number
        {
            return 0;
        }
        
        public function get transform() : Transform
        {
            return null;
        }
        
        public function set transform(value:Transform) : void
        {
        }
        
        public function get UIID() : uint
        {
            return 0;
        }
        
        public function set UIID(uiid:uint) : void
        {
        }
        
        public function get visible() : Boolean
        {
            return false;
        }
        
        public function set visible(value:Boolean) : void
        {
        }
        
        public function get viewTutorialId() : String
        {
            return "";
        }
        
        public function set viewTutorialId(value:String) : void
        {
        }
        
        public function dispatchEvent(event:Event) : Boolean
        {
            return false;
        }
        
        public function validateNow(event:Event = null) : void
        {
        }
        
        public function handleInput(event:InputEvent) : void
        {
        }
    }
}
