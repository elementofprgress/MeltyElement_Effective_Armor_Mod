class net.wargaming.FrameWalker
{
    function FrameWalker(targetMC, framesCount, isInverted, counterView)
    {
        m_isInverted = isInverted;
        m_targetMC = targetMC;
        m_framesCount = framesCount;
        m_endFrame = m_isInverted ? (0) : (m_framesCount);
        m_counter = counterView;
        m_name = "[FrameWalker <" + targetMC._name + ">]: ";
    } // End of the function
    function play(frameName)
    {
        m_targetMC.gotoAndPlay(frameName);
    } // End of the function
    function setPosAsPercent(percent)
    {
        percent = Math.min(Math.max(percent, 0), 100);
        var _loc4 = int(m_framesCount * percent / 100);
        m_targetMC.gotoAndStop(_loc4);
        var _loc3;
        if (percent > 0)
        {
            if (m_correctedReloadingTime > 0)
            {
                _loc3 = m_correctedReloadingTime;
            }
            else
            {
                _loc3 = m_reloadingBaseTime;
            } // end else if
        }
        else
        {
            _loc3 = -1;
        } // end else if
        this.setReloadingTime(_loc3, m_reloadingBaseTime * percent / 100);
    } // End of the function
    function setPosAsTime(totalTime, startTime)
    {
        if (totalTime > 0)
        {
            var _loc2 = startTime != null ? (int(startTime / totalTime * m_framesCount)) : (0);
            m_targetMC.gotoAndStop(m_isInverted ? (m_framesCount - _loc2) : (_loc2));
        }
        else
        {
            m_targetMC.gotoAndStop(m_isInverted ? (0) : (m_framesCount));
        } // end else if
    } // End of the function
    function start(totalTime, startTime, postEffKeyFrame, scope, func)
    {
        if (scope != null && func != null)
        {
            m_funcObj = new Object();
            m_funcObj.scope = scope;
            m_funcObj.func = func;
        } // end if
        if (m_intervalID != -1)
        {
            trace ("Warning! FrameWalker still works");
            clearInterval(m_intervalID);
            m_intervalID = -1;
            clearInterval(m_updateTFIntervalID);
            m_updateTFIntervalID = -1;
        } // end if
        if (totalTime > 0)
        {
            if (startTime != null && startTime >= totalTime)
            {
                this.walkEnd();
                return;
            } // end if
            m_postEffKeyFrame = postEffKeyFrame;
            m_startTime = getTimer();
            m_totalTime = (totalTime - (startTime != null ? (startTime) : (0))) * 1000;
            var _loc4 = startTime != null ? (int(startTime / totalTime * m_framesCount)) : (0);
            m_startFrame = m_isInverted ? (m_framesCount - _loc4) : (_loc4);
            m_targetMC.gotoAndStop(m_startFrame);
            m_intervalID = setInterval(this, "run", totalTime * 1000 / m_framesCount);
            m_updateTFIntervalID = setInterval(this, "updateCounter", net.wargaming.FrameWalker.COUNTER_UPDATE_TICK);
        }
        else
        {
            this.walkEnd();
        } // end else if
    } // End of the function
    function restartFromCurrentFrame(remainingTime)
    {
        if (m_intervalID != -1)
        {
            trace ("Warning! FrameWalker still works");
            clearInterval(m_intervalID);
            m_intervalID = -1;
            clearInterval(m_updateTFIntervalID);
            m_updateTFIntervalID = -1;
        } // end if
        if (remainingTime > 0)
        {
            m_startTime = getTimer();
            m_startFrame = m_targetMC._currentframe;
            if (m_isInverted && m_startFrame == 0 || !m_isInverted && m_startFrame >= m_endFrame)
            {
                return;
            } // end if
            m_correctedReloadingTime = getTimer() - m_startReloadingTime + remainingTime * 1000;
            m_totalTime = remainingTime * 1000;
            m_intervalID = setInterval(this, "run", m_totalTime / m_framesCount);
            m_updateTFIntervalID = setInterval(this, "updateCounter", net.wargaming.FrameWalker.COUNTER_UPDATE_TICK);
        }
        else
        {
            this.walkEnd();
        } // end else if
    } // End of the function
    function stop(isReloading)
    {
        if (m_intervalID != -1)
        {
            clearInterval(m_intervalID);
            m_intervalID = -1;
            clearInterval(m_updateTFIntervalID);
            m_updateTFIntervalID = -1;
        } // end if
        this.updateCounter(!isReloading);
    } // End of the function
    function run()
    {
        var _loc2 = (getTimer() - m_startTime) / m_totalTime;
        if (_loc2 >= 1)
        {
            clearInterval(m_intervalID);
            m_intervalID = -1;
            clearInterval(m_updateTFIntervalID);
            m_updateTFIntervalID = -1;
            this.walkEnd();
        }
        else
        {
            m_targetMC.gotoAndStop(this.calculateFrameNumber(_loc2));
        } // end else if
    } // End of the function
    function calculateFrameNumber(position)
    {
        var _loc2 = int(position * (m_endFrame - m_startFrame) + m_startFrame);
        return (_loc2);
    } // End of the function
    function walkEnd()
    {
        m_targetMC.gotoAndStop(m_endFrame);
        if (m_postEffKeyFrame)
        {
            trace (m_name + "_update : starting post animation name \'" + m_postEffKeyFrame + "\'.");
            m_targetMC.gotoAndPlay(m_postEffKeyFrame);
        } // end if
        if (m_funcObj)
        {
            trace (m_name + "run : animation over at frame - " + m_endFrame);
            m_funcObj.scope[m_funcObj.func]();
            delete this.m_funcObj;
            m_funcObj = null;
        } // end if
        this.updateCounter(true);
    } // End of the function
    function setReloadingTime(total, elapsed)
    {
        if (total != 0)
        {
            m_reloadingBaseTime = total;
        } // end if
        if (elapsed != null)
        {
            m_elapsedReloadingTime = elapsed;
            if (m_elapsedReloadingTime == m_reloadingBaseTime)
            {
                m_elapsedReloadingTime = 0;
            } // end if
        }
        else
        {
            m_elapsedReloadingTime = null;
        } // end else if
        if (total == -1)
        {
            if (m_updateTFIntervalID != -1)
            {
                clearInterval(m_updateTFIntervalID);
                m_updateTFIntervalID = -1;
            } // end if
            this.updateCounter();
        } // end if
    } // End of the function
    function updateCounter(reloadingComplete)
    {
        if (m_counter)
        {
            var _loc6 = m_elapsedReloadingTime != null ? (m_elapsedReloadingTime) : (0);
            var _loc5 = m_reloadingBaseTime - _loc6;
            if (m_reloadingBaseTime == -1)
            {
                m_isReloading = false;
                m_correctedReloadingTime = 0;
                m_counter.updateTime(0, true);
            }
            else if (reloadingComplete)
            {
                m_correctedReloadingTime = 0;
                m_isReloading = false;
                m_counter.updateTime(_loc5, false);
            }
            else
            {
                if (!m_isReloading)
                {
                    m_startReloadingTime = getTimer();
                    m_isReloading = true;
                } // end if
                var _loc3;
                var _loc2;
                var _loc4;
                if (m_correctedReloadingTime > 0)
                {
                    _loc3 = (getTimer() - m_startReloadingTime) / m_correctedReloadingTime;
                    _loc2 = 1 - _loc3;
                    _loc4 = m_correctedReloadingTime / 1000 * _loc2;
                }
                else
                {
                    _loc3 = (getTimer() - m_startTime) / m_totalTime;
                    _loc2 = 1 - _loc3;
                    _loc4 = _loc5 * _loc2;
                } // end else if
                m_counter.updateTime(_loc4, true);
            } // end else if
        } // end else if
    } // End of the function
    function clearCorrection()
    {
        m_correctedReloadingTime = 0;
    } // End of the function
    static var COUNTER_UPDATE_TICK = 50;
    var m_funcObj = null;
    var m_postEffKeyFrame = null;
    var m_startTime = 0;
    var m_totalTime = 0;
    var m_startFrame = 0;
    var m_endFrame = 0;
    var m_isInverted = false;
    var m_intervalID = -1;
    var m_targetMC = null;
    var m_framesCount = 0;
    var m_name = null;
    var m_counter = null;
    var m_updateTFIntervalID = 0;
    var m_isReloading = false;
    var m_reloadingBaseTime = -1;
    var m_startReloadingTime = 0;
    var m_elapsedReloadingTime = 0;
    var m_correctedReloadingTime = 0;
} // End of Class
