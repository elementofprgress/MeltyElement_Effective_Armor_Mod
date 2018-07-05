class reload.ReloadSec
{
    function ReloadSec(targetMC, framesCount, isInverted)
    {
        m_isInverted = isInverted;
        s_targetMC = targetMC;
        m_framesCount = framesCount;
        m_endFrame = m_isInverted ? (0) : (m_framesCount);
        m_name = "[FrameWalker <" + targetMC._name + ">]: ";
    } // End of the function
    function play(frameName)
    {
        s_targetMC.gotoAndPlay(frameName);
    } // End of the function
    function setPosAsPercent(percent)
    {
        s_targetMC.gotoAndStop(percent);
    } // End of the function
    function setPosAsTime(totalTime, startTime)
    {
        if (totalTime > 0)
        {
            var _loc2 = startTime != null ? (int(startTime / totalTime * m_framesCount)) : (0);
            s_targetMC.gotoAndStop(m_isInverted ? (m_framesCount - _loc2) : (_loc2));
        }
        else
        {
            s_targetMC.gotoAndStop(m_isInverted ? (0) : (m_framesCount));
        } // end else if
    } // End of the function
    function start(totalTime, startTime, postEffKeyFrame, scope, func)
    {
        if (s_intervalID != -1)
        {
            clearInterval(s_intervalID);
            s_intervalID = -1;
            s_targetMC.timesec.text = "0";
        } // end if
        if (totalTime > 0)
        {
            if (startTime != null && startTime >= totalTime)
            {
                this.walkEnd();
                return;
            } // end if
            s_startTime = getTimer();
            s_totalTime = (totalTime - (startTime != null ? (startTime) : (0))) * 1000;
            dursec = totalTime - (startTime != null ? (startTime) : (0));
            s_targetMC.timesec.text = Math.round(dursec * 100) / 100;
            s_intervalID = setInterval(this, "run", 100);
        }
        else
        {
            this.walkEnd();
        } // end else if
    } // End of the function
    function restartFromCurrentFrame(remainingTime)
    {
        if (s_intervalID != -1)
        {
            clearInterval(s_intervalID);
            s_intervalID = -1;
        } // end if
        if (remainingTime > 0)
        {
            s_startTime = getTimer();
            s_totalTime = remainingTime * 1000;
            dursec = remainingTime;
            s_targetMC.timesec.text = Math.round(remainingTime * 100) / 100;
            s_intervalID = setInterval(this, "run", 100);
        }
        else
        {
            this.walkEnd();
        } // end else if
    } // End of the function
    function stop()
    {
        if (s_intervalID != -1)
        {
            clearInterval(s_intervalID);
            s_intervalID = -1;
        } // end if
    } // End of the function
    function run()
    {
        var _loc2 = getTimer() - s_startTime;
        var _loc3 = _loc2 / s_totalTime;
        if (_loc3 >= 1)
        {
            clearInterval(s_intervalID);
            s_intervalID = -1;
            this.walkEnd();
        }
        else
        {
            s_targetMC.timesec.text = Math.round((dursec - _loc2 / 1000) * 100) / 100;
        } // end else if
    } // End of the function
    function calculateFrameNumber(position)
    {
    } // End of the function
    function walkEnd()
    {
        s_targetMC.timesec.text = "0";
    } // End of the function
    var m_funcObj = null;
    var m_postEffKeyFrame = null;
    var s_startTime = 0;
    var s_totalTime = 0;
    var m_startFrame = 0;
    var m_endFrame = 0;
    var m_isInverted = false;
    var s_intervalID = -1;
    var s_targetMC = null;
    var m_framesCount = 0;
    var m_name = null;
    var dursec = 0;
} // End of Class
