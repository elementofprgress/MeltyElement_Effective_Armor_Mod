package net.wg.utils
{
    import net.wg.data.constants.KeyProps;
    import flash.text.TextField;
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import net.wg.infrastructure.interfaces.IUserProps;
    import flash.events.IEventDispatcher;
    import flash.display.InteractiveObject;
    import flash.display.DisplayObjectContainer;
    import flash.events.MouseEvent;
    
    public interface ICommons
    {
         
        function keyToString(param1:Number) : KeyProps;
        
        function addBlankLines(param1:String, param2:TextField, param3:Vector.<TextField>) : void;
        
        function setSaturation(param1:Sprite, param2:Number) : void;
        
        function setGlowFilter(param1:DisplayObject, param2:Number) : void;
        
        function setShadowFilter(param1:DisplayObject, param2:uint) : void;
        
        function setShadowFilterWithParams(param1:DisplayObject, param2:Number = 4.0, param3:Number = 45, param4:uint = 0, param5:Number = 1.0, param6:Number = 4.0, param7:Number = 4.0, param8:Number = 1.0, param9:int = 1, param10:Boolean = false, param11:Boolean = false, param12:Boolean = false) : void;
        
        function setColorTransformMultipliers(param1:DisplayObject, param2:Number = 1, param3:Number = 1, param4:Number = 1, param5:Number = 1) : void;
        
        function releaseReferences(param1:Object, param2:Boolean = true) : void;
        
        function cutBitmapFromBitmapData(param1:BitmapData, param2:Rectangle) : Bitmap;
        
        function getUserProps(param1:String, param2:String = null, param3:String = null, param4:int = 0, param5:Array = null) : IUserProps;
        
        function formatPlayerName(param1:TextField, param2:IUserProps) : Boolean;
        
        function truncateTextFieldText(param1:TextField, param2:String, param3:Boolean = true) : String;
        
        function getFullPlayerName(param1:IUserProps) : String;
        
        function addMultipleHandlers(param1:Vector.<IEventDispatcher>, param2:String, param3:Function) : void;
        
        function removeMultipleHandlers(param1:Vector.<IEventDispatcher>, param2:String, param3:Function) : void;
        
        function initTabIndex(param1:Vector.<InteractiveObject>) : void;
        
        function moveDsiplObjToEndOfText(param1:DisplayObject, param2:TextField, param3:int = 0, param4:int = 0) : void;
        
        function rgbToArgb(param1:uint, param2:Number) : uint;
        
        function updateTextFieldSize(param1:TextField, param2:Boolean = true, param3:Boolean = true) : void;
        
        function updateChildrenMouseEnabled(param1:DisplayObjectContainer, param2:Boolean) : void;
        
        function isLeftButton(param1:MouseEvent) : Boolean;
        
        function isRightButton(param1:MouseEvent) : Boolean;
    }
}
