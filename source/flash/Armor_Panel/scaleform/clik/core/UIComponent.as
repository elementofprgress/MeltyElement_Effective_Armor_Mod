package scaleform.clik.core
{
    import flash.display.MovieClip;
    import scaleform.clik.interfaces.IUIComponent;
    import flash.display.DisplayObject;
    import net.wg.infrastructure.events.TutorialEvent;
    import scaleform.clik.layout.LayoutData;
    import scaleform.clik.utils.Constraints;
    import flash.events.Event;
    import scaleform.gfx.Extensions;
    import scaleform.clik.events.ComponentEvent;
    import scaleform.gfx.FocusManager;
    import scaleform.clik.events.InputEvent;
    import flash.external.ExternalInterface;
    import flash.utils.getQualifiedClassName;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.utils.IUtils;
    import scaleform.gfx.MouseEventEx;
    import net.wg.infrastructure.events.LifeCycleEvent;
    import net.wg.infrastructure.exceptions.AssertionException;
    import net.wg.infrastructure.exceptions.LifecycleException;
    import net.wg.data.constants.Values;
    import net.wg.infrastructure.exceptions.InfrastructureException;
    
    public class UIComponent extends MovieClip implements IUIComponent
    {
        
        protected static var tutorialFunctionPointer:Function = checkTutorialFucntionType;
         
        public var initialized:Boolean = false;
        
        protected var _invalidHash:Object;
        
        protected var _invalid:Boolean = false;
        
        protected var _width:Number = 0;
        
        protected var _height:Number = 0;
        
        protected var _originalWidth:Number = 0;
        
        protected var _originalHeight:Number = 0;
        
        protected var _focusTarget:scaleform.clik.core.UIComponent;
        
        protected var _focusable:Boolean = true;
        
        protected var _focused:Number = 0;
        
        protected var _displayFocus:Boolean = false;
        
        protected var _mouseWheelEnabled:Boolean = true;
        
        protected var _inspector:Boolean = false;
        
        protected var _labelHash:Object;
        
        protected var _layoutData:LayoutData;
        
        protected var _enableInitCallback:Boolean = false;
        
        private var _uiid:uint = 4.294967295E9;
        
        public var constraints:Constraints;
        
        private var lifeCycleExceptionMessage:String;
        
        private var _listenerFlag:Boolean = true;
        
        protected var _deferredDispose:Boolean = false;
        
        protected var _baseDisposed:Boolean = false;
        
        public function UIComponent()
        {
            this.preInitialize();
            super();
            this._invalidHash = {};
            this.initialize();
            this.addEventListener(Event.ADDED_TO_STAGE,this.addedToStage,false,0,true);
            this.lifeCycleExceptionMessage = "invoking component \'" + this + "\' after dispose!\nMay be you can find a custom override method Draw and place after each gotoAnd... " + "method next code block:if (_baseDisposed){return;}";
        }
        
        public static function generateLabelHash(target:MovieClip) : Object
        {
            var hash:Object = {};
            if(!target)
            {
                return hash;
            }
            var labels:Array = target.currentLabels;
            var l:uint = labels.length;
            for(var i:uint = 0; i < l; i++)
            {
                hash[labels[i].name] = true;
            }
            return hash;
        }
        
        private static function checkTutorialFucntionType(component:DisplayObject) : void
        {
            if(App.tutorialMgr.isSystemEnabled)
            {
                tutorialFunctionPointer = onReadyForTutorial;
                onReadyForTutorial(component);
            }
            else if(App.tutorialMgr.isSystemEnabled != null)
            {
                tutorialFunctionPointer = onReadyForTutorialFake;
            }
        }
        
        private static function onReadyForTutorial(component:DisplayObject) : void
        {
            var event:TutorialEvent = new TutorialEvent(TutorialEvent.VIEW_READY_FOR_TUTORIAL);
            event.addPathPoint(component,component.name);
            component.dispatchEvent(event);
        }
        
        private static function onReadyForTutorialFake(component:DisplayObject) : void
        {
        }
        
        protected function preInitialize() : void
        {
        }
        
        protected function initialize() : void
        {
            this._labelHash = scaleform.clik.core.UIComponent.generateLabelHash(this);
            this._originalWidth = super.width / super.scaleX;
            this._originalHeight = super.height / super.scaleY;
            if(this._width == 0)
            {
                this._width = super.width;
            }
            if(this._height == 0)
            {
                this._height = super.height;
            }
            this.invalidate();
        }
        
        protected function addedToStage(event:Event) : void
        {
            this.removeEventListener(Event.ADDED_TO_STAGE,this.addedToStage,false);
            if(!CLIK.initialized)
            {
                CLIK.initialize(stage,this);
            }
            if(Boolean(this._enableInitCallback) && Extensions.CLIK_addedToStageCallback != null)
            {
                CLIK.queueInitCallback(this);
            }
        }
        
        public function get componentInspectorSetting() : Boolean
        {
            return this._inspector;
        }
        
        public function set componentInspectorSetting(value:Boolean) : void
        {
            this._inspector = value;
            if(value)
            {
                this.beforeInspectorParams();
            }
            else
            {
                this.afterInspectorParams();
            }
        }
        
        override public function get width() : Number
        {
            return this._width;
        }
        
        override public function set width(value:Number) : void
        {
            this.setSize(value,this._height);
        }
        
        override public function get height() : Number
        {
            return this._height;
        }
        
        override public function set height(value:Number) : void
        {
            this.setSize(this._width,value);
        }
        
        override public function get scaleX() : Number
        {
            return this._width / this._originalWidth;
        }
        
        override public function set scaleX(value:Number) : void
        {
            super.scaleX = value;
            if(rotation == 0)
            {
                this.width = super.width;
            }
        }
        
        override public function get scaleY() : Number
        {
            return this._height / this._originalHeight;
        }
        
        override public function set scaleY(value:Number) : void
        {
            super.scaleY = value;
            if(rotation == 0)
            {
                this.height = super.height;
            }
        }
        
        override public function get enabled() : Boolean
        {
            return super.enabled;
        }
        
        override public function set enabled(value:Boolean) : void
        {
            if(value == super.enabled)
            {
                return;
            }
            super.enabled = value;
            tabEnabled = !this.enabled?false:Boolean(this._focusable);
            mouseEnabled = value;
        }
        
        override public function get visible() : Boolean
        {
            return super.visible;
        }
        
        override public function set visible(value:Boolean) : void
        {
            super.visible = value;
            dispatchEvent(new ComponentEvent(!!value?ComponentEvent.SHOW:ComponentEvent.HIDE));
        }
        
        public function get hasFocus() : Boolean
        {
            return this._focused > 0;
        }
        
        public function get focusable() : Boolean
        {
            return this._focusable;
        }
        
        public function set focusable(value:Boolean) : void
        {
            var changed:* = this._focusable != value;
            this._focusable = value;
            if(!this._focusable && Boolean(this.enabled))
            {
                tabEnabled = tabChildren = false;
            }
            else if(Boolean(this._focusable) && Boolean(this.enabled))
            {
                tabEnabled = true;
            }
            if(changed)
            {
                this.changeFocus();
            }
        }
        
        public function get focused() : Number
        {
            return this._focused;
        }
        
        public function set focused(value:Number) : void
        {
            var numFocusGroups:uint = 0;
            var numControllers:uint = 0;
            var i:Number = NaN;
            var isFocused:* = false;
            var controllerMask1:Number = NaN;
            var j:Number = NaN;
            var controllerValue1:* = false;
            this.throwLifeCycleException();
            if(value == this._focused || !this._focusable)
            {
                return;
            }
            this._focused = value;
            if(Extensions.isScaleform)
            {
                numFocusGroups = FocusManager.numFocusGroups;
                numControllers = Extensions.numControllers;
                for(i = 0; i < numFocusGroups; i++)
                {
                    isFocused = (this._focused >> i & 1) != 0;
                    if(isFocused)
                    {
                        controllerMask1 = FocusManager.getControllerMaskByFocusGroup(i);
                        for(j = 0; j < numControllers; j++)
                        {
                            controllerValue1 = (controllerMask1 >> j & 1) != 0;
                            if(Boolean(controllerValue1) && FocusManager.getFocus(j) != this)
                            {
                                FocusManager.setFocus(this,j);
                            }
                        }
                    }
                }
            }
            else if(stage != null && this._focused > 0)
            {
                stage.focus = this;
            }
            this.changeFocus();
        }
        
        public function get displayFocus() : Boolean
        {
            return this._displayFocus;
        }
        
        public function set displayFocus(value:Boolean) : void
        {
            if(value == this._displayFocus)
            {
                return;
            }
            this._displayFocus = value;
            this.changeFocus();
        }
        
        public function get focusTarget() : scaleform.clik.core.UIComponent
        {
            return this._focusTarget;
        }
        
        public function set focusTarget(value:scaleform.clik.core.UIComponent) : void
        {
            this._focusTarget = value;
        }
        
        public function get layoutData() : LayoutData
        {
            return this._layoutData;
        }
        
        public function set layoutData(value:LayoutData) : void
        {
            this._layoutData = value;
        }
        
        public function get enableInitCallback() : Boolean
        {
            return this._enableInitCallback;
        }
        
        public function set enableInitCallback(value:Boolean) : void
        {
            if(value == this._enableInitCallback)
            {
                return;
            }
            this._enableInitCallback = value;
            if(Boolean(this._enableInitCallback) && stage != null && Extensions.CLIK_addedToStageCallback != null)
            {
                if(!CLIK.initialized)
                {
                    CLIK.initialize(stage,this);
                }
                CLIK.queueInitCallback(this);
            }
        }
        
        public final function get actualWidth() : Number
        {
            return super.width;
        }
        
        public final function get actualHeight() : Number
        {
            return super.height;
        }
        
        public final function get actualScaleX() : Number
        {
            return super.scaleX;
        }
        
        public final function get actualScaleY() : Number
        {
            return super.scaleY;
        }
        
        public function setSize(width:Number, height:Number) : void
        {
            this._width = width;
            this._height = height;
            this.invalidateSize();
        }
        
        public function setActualSize(newWidth:Number, newHeight:Number) : void
        {
            if(super.width != newWidth || this._width != newWidth)
            {
                super.width = this._width = newWidth;
            }
            if(super.height != newHeight || this._height != newHeight)
            {
                super.height = this._height = newHeight;
            }
        }
        
        public final function setActualScale(scaleX:Number, scaleY:Number) : void
        {
            super.scaleX = scaleX;
            super.scaleY = scaleY;
            this._width = this._originalWidth * scaleX;
            this._height = this._originalHeight * scaleY;
            this.invalidateSize();
        }
        
        public function handleInput(event:InputEvent) : void
        {
        }
        
        public function isReadyForTutorialByDefault() : Boolean
        {
            return App.instance != null;
        }
        
        public function dispatchEventToGame(event:Event) : void
        {
            ExternalInterface.call("__handleEvent",name,event);
        }
        
        override public function toString() : String
        {
            return "[CLIK " + getQualifiedClassName(this) + " " + name + "]";
        }
        
        protected function configUI() : void
        {
            if(this.isReadyForTutorialByDefault())
            {
                tutorialFunctionPointer(this);
            }
            this.addEventListener(MouseEvent.DOUBLE_CLICK,this.onPreventDoubleRightClickHandler,false,int.MAX_VALUE);
        }
        
        protected function draw() : void
        {
        }
        
        protected function changeFocus() : void
        {
        }
        
        protected function beforeInspectorParams() : void
        {
        }
        
        protected function afterInspectorParams() : void
        {
        }
        
        protected function initSize() : void
        {
            var w:Number = this._width == 0?Number(this.actualWidth):Number(this._width);
            var h:Number = this._height == 0?Number(this.actualHeight):Number(this._height);
            super.scaleX = super.scaleY = 1;
            this.setSize(w,h);
        }
        
        public function invalidate(... invalidTypes) : void
        {
            var l:uint = 0;
            var i:uint = 0;
            this.throwLifeCycleException();
            if(!this._baseDisposed)
            {
                if(invalidTypes.length == 0)
                {
                    this._invalidHash[InvalidationType.ALL] = true;
                }
                else
                {
                    l = invalidTypes.length;
                    for(i = 0; i < l; i++)
                    {
                        this._invalidHash[invalidTypes[i]] = true;
                    }
                }
                if(!this._invalid)
                {
                    this._invalid = true;
                    if(stage == null)
                    {
                        this.addEventListener(Event.ADDED_TO_STAGE,this.handleStageChange,false,0,true);
                    }
                    else
                    {
                        this.addEventListener(Event.ENTER_FRAME,this.handleEnterFrameValidation,false,0,true);
                        this.addEventListener(Event.RENDER,this.validateNow,false,0,true);
                        stage.invalidate();
                    }
                }
                else if(stage != null)
                {
                    stage.invalidate();
                }
            }
        }
        
        protected final function cancelValidation(invalidType:String) : void
        {
            if(this._invalidHash != null)
            {
                delete this._invalidHash[invalidType];
            }
        }
        
        public function validateNow(event:Event = null) : void
        {
            if(!this.initialized)
            {
                this.initialized = true;
                this.configUI();
            }
            this.removeEventListener(Event.ENTER_FRAME,this.handleEnterFrameValidation,false);
            this.removeEventListener(Event.RENDER,this.validateNow,false);
            if(!this._invalid)
            {
                return;
            }
            this.draw();
            this._invalidHash = {};
            this._invalid = false;
        }
        
        override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
        {
            this.throwLifeCycleException();
            var utils:IUtils = !!App.instance?App.utils:null;
            if(Boolean(utils) && Boolean(utils.events) && Boolean(this._listenerFlag))
            {
                this._listenerFlag = false;
                utils.events.addEvent(this,type,listener,useCapture,priority,useWeakReference);
                this._listenerFlag = true;
            }
            else
            {
                this.addSuperEventListener(type,listener,useCapture,priority,useWeakReference);
            }
        }
        
        override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
        {
            var utils:IUtils = !!App.instance?App.utils:null;
            if(Boolean(utils) && Boolean(utils.events) && Boolean(this._listenerFlag))
            {
                this._listenerFlag = false;
                utils.events.removeEvent(this,type,listener,useCapture);
                this._listenerFlag = true;
            }
            else
            {
                this.removeSuperEventListener(type,listener,useCapture);
            }
        }
        
        public function removeSuperEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
        {
            super.removeEventListener(type,listener,useCapture);
        }
        
        public function addSuperEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
        {
            super.addEventListener(type,listener,useCapture,priority,useWeakReference);
        }
        
        protected function isInvalid(... invalidTypes) : Boolean
        {
            this.throwLifeCycleException();
            if(!this._invalid)
            {
                return false;
            }
            var l:uint = invalidTypes.length;
            if(l == 0)
            {
                return this._invalid;
            }
            if(this._invalidHash[InvalidationType.ALL])
            {
                return true;
            }
            for(var i:uint = 0; i < l; i++)
            {
                if(this._invalidHash[invalidTypes[i]])
                {
                    return true;
                }
            }
            return false;
        }
        
        public function invalidateSize() : void
        {
            this.invalidate(InvalidationType.SIZE);
        }
        
        public function invalidateData() : void
        {
            this.invalidate(InvalidationType.DATA);
        }
        
        public function invalidateState() : void
        {
            this.invalidate(InvalidationType.STATE);
        }
        
        protected function handleStageChange(event:Event) : void
        {
            if(event.type == Event.ADDED_TO_STAGE)
            {
                this.removeEventListener(Event.ADDED_TO_STAGE,this.handleStageChange,false);
                this.addEventListener(Event.RENDER,this.validateNow,false,0,true);
                if(stage != null)
                {
                    stage.invalidate();
                }
            }
        }
        
        protected function handleEnterFrameValidation(event:Event) : void
        {
            this.throwLifeCycleException();
            this.validateNow();
        }
        
        private function onPreventDoubleRightClickHandler(event:MouseEvent) : void
        {
            if(event is MouseEventEx && MouseEventEx(event).buttonIdx == MouseEventEx.RIGHT_BUTTON)
            {
                event.stopImmediatePropagation();
            }
        }
        
        protected function getInvalid() : String
        {
            var n:* = null;
            var inv:Array = [];
            var check:Array = [InvalidationType.ALL,InvalidationType.DATA,InvalidationType.RENDERERS,InvalidationType.SIZE,InvalidationType.STATE];
            for(var i:uint = 0; i < check.length; i++)
            {
                inv.push("* " + check[i] + ": " + (this._invalidHash[check[i]] == true));
            }
            for(n in this._invalidHash)
            {
                if(!check.indexOf(n))
                {
                    inv.push("* " + n + ": true");
                }
            }
            return "Invalid " + this + ": \n" + inv.join("\n");
        }
        
        public function dispatchEventAndSound(event:Event) : Boolean
        {
            var ok:Boolean = super.dispatchEvent(event);
            return ok;
        }
        
        public final function dispose() : void
        {
            if(App.utils.focusHandler.getFocus(0) == this)
            {
                this.forcedResetFocus();
            }
            if(this._deferredDispose)
            {
                this.onBeforeDispose();
                App.utils.scheduler.scheduleNonCancelableTask(this.doDispose,100);
            }
            else
            {
                this.onBeforeDispose();
                this.doDispose();
            }
        }
        
        protected function onBeforeDispose() : void
        {
            var key:* = null;
            this.removeEventListener(Event.ADDED_TO_STAGE,this.addedToStage,false);
            this.removeEventListener(Event.ENTER_FRAME,this.handleEnterFrameValidation,false);
            this.removeEventListener(Event.ADDED_TO_STAGE,this.handleStageChange,false);
            this.removeEventListener(Event.RENDER,this.validateNow,false);
            this.removeEventListener(MouseEvent.DOUBLE_CLICK,this.onPreventDoubleRightClickHandler);
            this._focusTarget = null;
            this._invalid = false;
            for(key in this._invalidHash)
            {
                delete this._invalidHash[key];
            }
            for(key in this._labelHash)
            {
                delete this._labelHash[key];
            }
        }
        
        protected function onDispose() : void
        {
            if(this.constraints)
            {
                this.constraints.removeAllElements();
                this.constraints.dispose();
                this.constraints = null;
            }
            this._invalidHash = null;
            this._labelHash = null;
            this._layoutData = null;
        }
        
        private function doDispose() : void
        {
            App.utils.asserter.assert(!this._baseDisposed,name + "(" + getQualifiedClassName(this) + ") already disposed!");
            this._baseDisposed = true;
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_DISPOSE));
            this.onDispose();
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_DISPOSE));
            while(numChildren > 0)
            {
                removeChildAt(0);
            }
        }
        
        private function forcedResetFocus() : void
        {
            var oldFlag:Boolean = CLIK.disableNullFocusMoves;
            CLIK.disableNullFocusMoves = false;
            App.utils.focusHandler.setFocus(null);
            CLIK.disableNullFocusMoves = oldFlag;
        }
        
        private function simpleAssert(flag:Boolean, msg:String, exc:Class = null) : void
        {
            if(!flag)
            {
                if(exc == null)
                {
                    exc = AssertionException;
                }
                throw new exc(msg);
            }
        }
        
        private function throwLifeCycleException() : void
        {
            if(App.instance)
            {
                App.utils.asserter.assert(!this._baseDisposed,this.lifeCycleExceptionMessage,LifecycleException);
            }
        }
        
        public function get UIID() : uint
        {
            return this._uiid;
        }
        
        public function set UIID(uiid:uint) : void
        {
            var MSG_UNIQUE:String = null;
            if(this._uiid != Values.EMPTY_UIID)
            {
                MSG_UNIQUE = "UIID is unique value and can not be modified.";
                this.simpleAssert(this._uiid == uiid,MSG_UNIQUE,InfrastructureException);
            }
            this._uiid = uiid;
        }
    }
}
