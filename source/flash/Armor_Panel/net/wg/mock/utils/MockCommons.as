package net.wg.mock.utils
{
    import net.wg.utils.ICommons;
    import flash.text.TextField;
    import flash.events.IEventDispatcher;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import net.wg.infrastructure.interfaces.IUserProps;
    import flash.display.InteractiveObject;
    import net.wg.data.constants.KeyProps;
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.display.DisplayObjectContainer;
    import flash.events.MouseEvent;
    
    public class MockCommons implements ICommons
    {
         
        public function MockCommons()
        {
            super();
        }
        
        public function addBlankLines(label:String, labelTF:TextField, targetTFs:Vector.<TextField>) : void
        {
        }
        
        public function addMultipleHandlers(dispatchers:Vector.<IEventDispatcher>, eventType:String, listener:Function) : void
        {
        }
        
        public function cutBitmapFromBitmapData(bmdSrc:BitmapData, rect:Rectangle) : Bitmap
        {
            return null;
        }
        
        public function formatPlayerName(textField:TextField, userProps:IUserProps) : Boolean
        {
            return false;
        }
        
        public function getFullPlayerName(userProps:IUserProps) : String
        {
            return "";
        }
        
        public function getUserProps(nick:String, clan:String = null, region:String = null, igrType:int = 0, tags:Array = null) : IUserProps
        {
            return null;
        }
        
        public function initTabIndex(value:Vector.<InteractiveObject>) : void
        {
        }
        
        public function keyToString(key:Number) : KeyProps
        {
            return null;
        }
        
        public function moveDsiplObjToEndOfText(clip:DisplayObject, textTarget:TextField, x_Offset:int = 0, y_Offset:int = 0) : void
        {
        }
        
        public function releaseReferences(element:Object, rootInvoke:Boolean = true) : void
        {
        }
        
        public function removeMultipleHandlers(dispatchers:Vector.<IEventDispatcher>, eventType:String, listener:Function) : void
        {
        }
        
        public function rgbToArgb(rgb:uint, newAlpha:Number) : uint
        {
            return 0;
        }
        
        public function setColorTransformMultipliers(target:DisplayObject, aM:Number = 1, rM:Number = 1, gM:Number = 1, bM:Number = 1) : void
        {
        }
        
        public function setGlowFilter(object:DisplayObject, glowColor:Number) : void
        {
        }
        
        public function setSaturation(object:Sprite, amount:Number) : void
        {
        }
        
        public function setShadowFilter(object:DisplayObject, shadowColor:uint) : void
        {
        }
        
        public function setShadowFilterWithParams(object:DisplayObject, distance:Number = 4.0, angle:Number = 45, color:uint = 0, alpha:Number = 1.0, blurX:Number = 4.0, blurY:Number = 4.0, strength:Number = 1.0, quality:int = 1, inner:Boolean = false, knockout:Boolean = false, hideObject:Boolean = false) : void
        {
        }
        
        public function truncateTextFieldText(textField:TextField, text:String, truncateByWidth:Boolean = true) : String
        {
            return "";
        }
        
        public function updateChildrenMouseEnabled(displayObjectContainer:DisplayObjectContainer, value:Boolean) : void
        {
        }
        
        public function updateTextFieldSize(textField:TextField, upWdth:Boolean = true, upHght:Boolean = true) : void
        {
        }
        
        public function isLeftButton(event:MouseEvent) : Boolean
        {
            return false;
        }
        
        public function isRightButton(event:MouseEvent) : Boolean
        {
            return false;
        }
    }
}
