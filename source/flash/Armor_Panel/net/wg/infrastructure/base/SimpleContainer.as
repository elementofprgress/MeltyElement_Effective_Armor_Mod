package net.wg.infrastructure.base
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.events.LifeCycleEvent;
    import flash.events.Event;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.utils.IUtils;
    
    public class SimpleContainer extends MovieClip
    {
         
        public var initialized:Boolean = false;
        
        private var _invalid:Boolean = false;
        
        private var _invalidHash:Object;
        
        private var _listenerFlag:Boolean = true;
        
        public function SimpleContainer()
        {
            super();
            this._invalidHash = {};
            this.invalidate();
        }
        
        public function dispose() : void
        {
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_DISPOSE));
            this.onDispose();
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_DISPOSE));
        }
        
        protected function onDispose() : void
        {
            this.removeEventListener(Event.ENTER_FRAME,this.handleEnterFrameValidation,false);
            this.removeEventListener(Event.ADDED_TO_STAGE,this.handleStageChange,false);
            this.removeEventListener(Event.RENDER,this.validateNow,false);
        }
        
        protected function invalidate(... invalidTypes) : void
        {
            var l:int = 0;
            var i:int = 0;
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
            this.validateNow();
        }
        
        protected function draw() : void
        {
        }
        
        protected function configUI() : void
        {
        }
    }
}
