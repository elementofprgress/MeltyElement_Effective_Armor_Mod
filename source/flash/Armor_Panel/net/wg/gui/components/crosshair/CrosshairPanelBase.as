package net.wg.gui.components.crosshair
{
    import net.wg.infrastructure.base.meta.impl.AimMeta;
    import net.wg.infrastructure.base.meta.IAimMeta;
    import flash.display.MovieClip;
    import net.wg.gui.utils.FrameWalker;
    import flash.events.Event;
    import flash.utils.getTimer;
    import flash.utils.setInterval;
    import flash.utils.clearInterval;
    import flash.display.StageScaleMode;
    import flash.display.StageAlign;
    
    public class CrosshairPanelBase extends AimMeta implements IAimMeta
    {
        
        public static var COUNTER_UPDATE_TICK:Number = 50;
         
        public var reloadingTimer:net.wg.gui.components.crosshair.ReloadingTimer;
        
        public var reloadingBarMC:MovieClip;
        
        public var universalBarMC:MovieClip;
        
        public var ammoCountMC:MovieClip;
        
        public var targetMC:MovieClip;
        
        public var cassette:MovieClip;
        
        public var center:MovieClip;
        
        public var grid1:MovieClip;
        
        protected var _universalBarWalker:FrameWalker;
        
        protected var _reloadingBarWalker:FrameWalker;
        
        protected var _fadingTargetWalker:FrameWalker;
        
        protected var _health:Number = 0;
        
        protected var _reloadingSettings:Array;
        
        protected var _clipCapacity:Number = 1;
        
        protected var clipQuanityBar:net.wg.gui.components.crosshair.ClipQuantityBar = null;
        
        private var _startTime:Number = 0;
        
        private var _mTotalTime:Number = 0;
        
        private var _reloadingTimerId:Number = 0;
        
        private var _mIsReloading:Boolean = false;
        
        private var _reloadingBaseTime:Number = -1;
        
        private var _reloadingStartTime:Number = 0;
        
        private var _elapsedReloadingTime:Number = 0;
        
        private var _correctedReloadingTime:Number = 0;
        
        public function CrosshairPanelBase()
        {
            this._reloadingSettings = [0,0,false];
            super();
            if(stage)
            {
                this.init();
            }
            else
            {
                addEventListener(Event.ADDED_TO_STAGE,this.onCrosshairPanelBaseAddedToStageHandler);
            }
        }
        
        override protected function onDispose() : void
        {
            removeEventListener(Event.ADDED_TO_STAGE,this.onCrosshairPanelBaseAddedToStageHandler);
            if(this._universalBarWalker)
            {
                this._universalBarWalker.dispose();
                this._universalBarWalker = null;
            }
            if(this._reloadingBarWalker)
            {
                this._reloadingBarWalker.dispose();
                this._reloadingBarWalker = null;
            }
            if(this._fadingTargetWalker)
            {
                this._fadingTargetWalker.dispose();
                this._fadingTargetWalker = null;
            }
            if(this._reloadingSettings)
            {
                this._reloadingSettings.splice(0);
                this._reloadingSettings = null;
            }
            if(this.reloadingTimer)
            {
                this.reloadingTimer.dispose();
                this.reloadingTimer = null;
            }
            this.center = null;
            this.grid1 = null;
            this.reloadingBarMC = null;
            this.universalBarMC = null;
            this.ammoCountMC = null;
            this.targetMC = null;
            if(this.clipQuanityBar)
            {
                if(Boolean(this.cassette) && Boolean(this.cassette.contains(this.clipQuanityBar)))
                {
                    this.cassette.removeChild(this.clipQuanityBar);
                }
                this.clipQuanityBar.dispose();
                this.clipQuanityBar = null;
            }
            this.cassette = null;
            super.onDispose();
        }
        
        public function as_clearPreviousCorrection() : void
        {
            this.clearCorrection();
        }
        
        public function as_clearTarget(startTime:Number) : void
        {
            this._fadingTargetWalker.stop();
            this._fadingTargetWalker.start(4,startTime);
        }
        
        public function as_correctReloadingTime(time:Number) : void
        {
            var isReloading:Boolean = this._reloadingSettings[2];
            if(isReloading)
            {
                this.clearTimer();
                this.updateCounter(!isReloading);
                this._reloadingBarWalker.stop();
                this._reloadingBarWalker.restartFromCurrentFrame(time);
            }
        }
        
        public function as_initSettings(centerAlphaValue:Number, centerType:Number, netAlphaValue:Number, netType:Number, reloaderAlphaValue:Number, reloaderType:Number, conditionAlphaValue:Number, conditionType:Number, cassetteAlphaValue:Number, cassetteType:Number, reloaderTimerAlphaValue:Number, reloaderTimerType:Number) : void
        {
            this.setCenterType(centerAlphaValue,centerType);
            this.setNetType(netAlphaValue,netType);
            this.setReloaderType(reloaderAlphaValue,reloaderType);
            this.setConditionType(conditionAlphaValue,conditionType);
            this.setCassetteType(cassetteAlphaValue,cassetteType);
            this.setReloaderTimerType(reloaderTimerAlphaValue);
        }
        
        public function as_recreateDevice(offsetX:Number, offsetY:Number) : void
        {
            x = offsetX;
            y = offsetY;
        }
        
        public function as_setAmmoStock(quantity:Number, quantityInClip:Number, isLow:Boolean, clipState:String, clipReloaded:Boolean = false) : void
        {
            var ammoCount:MovieClip = this.ammoCountMC;
            ammoCount.gotoAndStop(!!isLow?"ammo_low":"ammo_normal");
            ammoCount.count.text = quantity.toString();
            if(Boolean(this.clipQuanityBar) && Boolean(this.clipQuanityBar.initialized))
            {
                this.clipQuanityBar.change(quantity,quantityInClip,clipState,clipReloaded);
            }
            else
            {
                net.wg.gui.components.crosshair.ClipQuantityBar.store(quantity,quantityInClip,clipState);
            }
        }
        
        public function as_setClipParams(clipCapacity:Number, burst:Number) : void
        {
            var cassetteMC:MovieClip = null;
            if(this._clipCapacity == clipCapacity)
            {
                return;
            }
            this._clipCapacity = clipCapacity;
            if(this._clipCapacity > 1)
            {
                cassetteMC = this.cassette;
                if(Boolean(cassetteMC) && !this.clipQuanityBar)
                {
                    this.clipQuanityBar = net.wg.gui.components.crosshair.ClipQuantityBar.create(this._clipCapacity,burst);
                    cassetteMC.addChild(this.clipQuanityBar);
                }
            }
            else if(this.clipQuanityBar != null)
            {
                removeChild(this.clipQuanityBar);
                this.clipQuanityBar = null;
            }
        }
        
        public function as_setHealth(percent:Number) : void
        {
            this._health = percent;
            this._universalBarWalker.setPosAsPercent(percent * 100);
        }
        
        public function as_setReloading(duration:Number, startTime:Number, isReloading:Boolean, currentPosition:Number, baseTime:Number = 0) : void
        {
            this.clearTimer();
            var totalTime:Number = !isNaN(baseTime) && duration == 0?Number(baseTime):Number(duration);
            var timeElapsed:Number = startTime;
            this.setReloadingTime(totalTime,timeElapsed,isReloading);
            this._reloadingSettings = [duration,startTime,isReloading];
            this._reloadingBarWalker.stop();
            if(duration == 0)
            {
                this._reloadingBarWalker.setPosAsPercent(100);
                if(isReloading)
                {
                    this._reloadingBarWalker.play("reloaded");
                }
            }
            else if(duration == -1)
            {
                this._reloadingBarWalker.setPosAsPercent(0);
            }
            else
            {
                if(currentPosition > 0)
                {
                    this._reloadingBarWalker.setPosAsPercent(currentPosition);
                    this._reloadingBarWalker.restartFromCurrentFrame(duration);
                }
                else
                {
                    this._reloadingBarWalker.start(duration,startTime);
                    this._startTime = this._reloadingBarWalker.startTime;
                    this._mTotalTime = this._reloadingBarWalker.totalTime;
                }
                if(this._mTotalTime > 0)
                {
                    this.setTimer(this.updateCounter,COUNTER_UPDATE_TICK);
                }
            }
        }
        
        public function as_setReloadingAsPercent(percent:Number, isReloading:Boolean) : void
        {
            if(percent >= 100)
            {
                this._reloadingBarWalker.setPosAsPercent(100);
                if(isReloading)
                {
                    this._reloadingBarWalker.play("reloaded");
                }
            }
            else
            {
                this._reloadingBarWalker.setPosAsPercent(percent);
            }
        }
        
        public function as_setReloadingTimeWithCorrection(duration:Number, startTime:Number, remainingTime:Boolean) : void
        {
            this.clearTimer();
            this._reloadingBarWalker.stop();
            this.updateCounter(true);
        }
        
        public function as_setTarget(name:String, type:String, color:Number) : void
        {
            this._fadingTargetWalker.stop();
            this._fadingTargetWalker.setPosAsPercent(0);
        }
        
        public function as_setupReloadingCounter(visible:Boolean) : void
        {
            this.reloadingTimer.visible = visible;
        }
        
        public function as_updateAdjust(brightness:Number, contrast:Number, saturation:Number, hue:Number) : void
        {
        }
        
        public function as_updateAmmoInfoPos() : void
        {
        }
        
        public function as_updateAmmoState(hasAmmo:Boolean) : void
        {
        }
        
        public function as_updateDistance(dist:Number) : void
        {
        }
        
        public function as_updatePlayerInfo(info:String) : void
        {
        }
        
        public function as_updateReloadingBaseTime(baseTime:Number, isReloaded:Boolean) : void
        {
            this.setReloadingTime(baseTime,NaN,isReloaded);
            this.updateCounter(isReloaded);
        }
        
        public function as_updateTarget(dist:Number) : void
        {
            var target:MovieClip = null;
            if(this.targetMC)
            {
                target = this.targetMC.target;
                target.distance.text = dist + "m";
            }
        }
        
        public function setCenterType(alphaValue:Number, type:Number) : void
        {
            this.center.gotoAndStop("type" + type);
            this.center.alpha = alphaValue;
        }
        
        public function setConditionType(alphaValue:Number, type:Number) : void
        {
            this.universalBarMC.alpha = alphaValue;
            this._universalBarWalker.setTarget(this.universalBarMC);
            this.as_setHealth(this._health);
        }
        
        public function setNetType(alphaValue:Number, type:Number) : void
        {
            gotoAndStop("type" + type);
            this.grid1.alpha = alphaValue;
        }
        
        public function setReloaderType(alphaValue:Number, type:Number) : void
        {
            this.reloadingBarMC.alpha = alphaValue;
            this._reloadingBarWalker.setTarget(this.reloadingBarMC);
            this.as_setReloading(this._reloadingSettings[0],this._reloadingSettings[1],this._reloadingSettings[2],0);
        }
        
        public function setReloadingTime(total:Number, elapsed:Number, isReloading:Boolean) : void
        {
            if(total != 0)
            {
                this._reloadingBaseTime = total;
            }
            if(!isNaN(elapsed))
            {
                this._elapsedReloadingTime = elapsed;
                if(this._elapsedReloadingTime == this._reloadingBaseTime)
                {
                    this._elapsedReloadingTime = 0;
                }
            }
            else
            {
                this._elapsedReloadingTime = NaN;
            }
            if(!isReloading)
            {
                this.updateCounter(true);
            }
            else if(total == -1)
            {
                this.updateCounter(true);
            }
        }
        
        public function updateCounter(reloadingComplete:Boolean = false) : void
        {
            var elapsed:Number = NaN;
            var remainingTime:Number = NaN;
            var position:Number = NaN;
            var remainingPercent:Number = NaN;
            var remainingSeconds:Number = NaN;
            if(this.reloadingTimer)
            {
                elapsed = !isNaN(this._elapsedReloadingTime)?Number(this._elapsedReloadingTime):Number(0);
                remainingTime = this._reloadingBaseTime - elapsed;
                if(this._reloadingBaseTime == -1)
                {
                    this._mIsReloading = false;
                    this._correctedReloadingTime = 0;
                    this.reloadingTimer.updateTime(0,true);
                }
                else if(reloadingComplete)
                {
                    this._correctedReloadingTime = 0;
                    this._mIsReloading = false;
                    this.reloadingTimer.updateTime(remainingTime,false);
                }
                else
                {
                    if(!this._mIsReloading)
                    {
                        this._reloadingStartTime = getTimer();
                        this._mIsReloading = true;
                    }
                    if(this._correctedReloadingTime > 0)
                    {
                        position = (getTimer() - this._reloadingStartTime) / this._correctedReloadingTime;
                        remainingPercent = 1 - position;
                        remainingSeconds = this._correctedReloadingTime / 1000 * remainingPercent;
                    }
                    else
                    {
                        this._startTime = this._reloadingBarWalker.startTime;
                        this._mTotalTime = this._reloadingBarWalker.totalTime;
                        position = (getTimer() - this._startTime) / this._mTotalTime;
                        remainingPercent = 1 - position;
                        remainingSeconds = remainingTime * remainingPercent;
                    }
                    this.reloadingTimer.updateTime(remainingSeconds,true);
                }
            }
        }
        
        protected function initFrameWalkers() : void
        {
            this._universalBarWalker = new FrameWalker(this.universalBarMC,60,true);
            this._reloadingBarWalker = new FrameWalker(this.reloadingBarMC,60,false);
            this._fadingTargetWalker = new FrameWalker(this.targetMC,60,false);
        }
        
        protected function setDefaultTargetState() : void
        {
            var target:MovieClip = this.targetMC.target;
            target.distance.text = "";
        }
        
        private function setReloaderTimerType(alphaValue:Number) : void
        {
            this.reloadingTimer.alpha = alphaValue;
        }
        
        private function setCassetteType(alphaValue:Number, type:Number) : void
        {
            this.cassette.alpha = alphaValue;
        }
        
        private function clearCorrection() : void
        {
            this._correctedReloadingTime = 0;
        }
        
        private function setTimer(handler:Function, interval:int) : void
        {
            this.clearTimer();
            this._reloadingTimerId = setInterval(handler,interval,false);
        }
        
        private function clearTimer() : void
        {
            if(this._reloadingTimerId > -1)
            {
                clearInterval(this._reloadingTimerId);
                this._reloadingTimerId = -1;
            }
        }
        
        private function init() : void
        {
            removeEventListener(Event.ADDED_TO_STAGE,this.onCrosshairPanelBaseAddedToStageHandler);
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            this.initFrameWalkers();
        }
        
        private function onCrosshairPanelBaseAddedToStageHandler(event:Event) : void
        {
            this.init();
        }
    }
}
