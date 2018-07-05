package net.wg.gui.utils
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.display.MovieClip;
    import flash.utils.clearInterval;
    import flash.utils.getTimer;
    import flash.utils.setInterval;
    
    public class FrameWalker implements IDisposable
    {
         
        private var _callback:Function;
        
        private var _postEffKeyFrame:String;
        
        private var _startTime:Number = 0;
        
        private var _totalTime:Number = 0;
        
        private var _startFrame:Number = 0;
        
        private var _endFrame:Number = 0;
        
        private var _isInverted:Boolean = false;
        
        private var _intervalID:int = -1;
        
        private var _targetMC:MovieClip;
        
        private var _framesCount:int = 0;
        
        public function FrameWalker(targetMC:MovieClip, framesCount:int, isInverted:Boolean)
        {
            super();
            this._isInverted = isInverted;
            this._targetMC = targetMC;
            this._framesCount = framesCount;
            this._endFrame = !!this._isInverted?Number(0):Number(this._framesCount);
        }
        
        public function setTarget(targetMC:MovieClip) : void
        {
            this._targetMC = targetMC;
        }
        
        public function play(frameName:String) : void
        {
            this._targetMC.gotoAndPlay(frameName);
        }
        
        public function setPosAsPercent(percent:Number) : void
        {
            percent = Math.min(Math.max(percent,0),100);
            var curFrame:int = this._framesCount * percent / 100;
            this._targetMC.gotoAndStop(curFrame);
        }
        
        public function setPosAsTime(totalTime:Number, startTime:Number) : void
        {
            var initFrame:int = 0;
            if(totalTime > 0)
            {
                initFrame = !isNaN(startTime)?int(int(startTime / totalTime * this._framesCount)):0;
                this._targetMC.gotoAndStop(!!this._isInverted?this._framesCount - initFrame:initFrame);
            }
            else
            {
                this._targetMC.gotoAndStop(!!this._isInverted?0:this._framesCount);
            }
        }
        
        public function start(totalTime:Number, startTime:Number, postEffKeyFrame:String = null, completeCallback:Function = null) : void
        {
            var initFrame:int = 0;
            this._callback = completeCallback;
            if(this._intervalID != -1)
            {
                clearInterval(this._intervalID);
                this._intervalID = -1;
            }
            if(totalTime > 0)
            {
                if(!isNaN(startTime) && startTime >= totalTime)
                {
                    this.walkEnd();
                    return;
                }
                this._postEffKeyFrame = postEffKeyFrame;
                this._startTime = getTimer();
                this._totalTime = (totalTime - (!isNaN(startTime)?startTime:0)) * 1000;
                initFrame = !isNaN(startTime)?int(int(startTime / totalTime * this._framesCount)):0;
                this._startFrame = !!this._isInverted?Number(this._framesCount - initFrame):Number(initFrame);
                this._targetMC.gotoAndStop(this._startFrame);
                this._intervalID = setInterval(this.run,totalTime * 1000 / this._framesCount);
            }
            else
            {
                this.walkEnd();
            }
        }
        
        public function restartFromCurrentFrame(remainingTime:Number) : void
        {
            if(this._intervalID != -1)
            {
                clearInterval(this._intervalID);
                this._intervalID = -1;
            }
            if(remainingTime > 0)
            {
                this._startTime = getTimer();
                this._startFrame = this._targetMC.currentFrame;
                if(Boolean(this._isInverted) && this._startFrame == 0 || !this._isInverted && this._startFrame >= this._endFrame)
                {
                    return;
                }
                this._totalTime = remainingTime * 1000;
                this._intervalID = setInterval(this.run,this._totalTime / this._framesCount);
            }
            else
            {
                this.walkEnd();
            }
        }
        
        public function stop() : void
        {
            if(this._intervalID != -1)
            {
                clearInterval(this._intervalID);
                this._intervalID = -1;
            }
        }
        
        private function run() : void
        {
            var position:Number = (getTimer() - this._startTime) / this._totalTime;
            if(position >= 1)
            {
                clearInterval(this._intervalID);
                this._intervalID = -1;
                this.walkEnd();
            }
            else
            {
                this._targetMC.gotoAndStop(this.calculateFrameNumber(position));
            }
        }
        
        private function calculateFrameNumber(position:Number) : int
        {
            var frame:int = position * (this._endFrame - this._startFrame) + this._startFrame;
            return frame;
        }
        
        private function walkEnd() : void
        {
            this._targetMC.gotoAndStop(this._endFrame);
            if(this._postEffKeyFrame)
            {
                this._targetMC.gotoAndPlay(this._postEffKeyFrame);
            }
            if(Boolean(this._callback))
            {
                this._callback.call();
            }
        }
        
        public function dispose() : void
        {
            this.stop();
            this._callback = null;
            this._targetMC = null;
        }
        
        public function get startTime() : Number
        {
            return this._startTime;
        }
        
        public function get totalTime() : Number
        {
            return this._totalTime;
        }
    }
}
