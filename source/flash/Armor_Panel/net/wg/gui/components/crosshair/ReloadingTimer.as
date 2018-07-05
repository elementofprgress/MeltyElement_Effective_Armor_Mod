package net.wg.gui.components.crosshair
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    
    public class ReloadingTimer extends MovieClip implements IDisposable
    {
        
        private static const FRACTIONAL_SIGNS:int = 2;
         
        public var timerTextField:TextField;
        
        private var _time:Number = 0;
        
        public function ReloadingTimer()
        {
            super();
        }
        
        public function dispose() : void
        {
            this.timerTextField = null;
        }
        
        public function updateTime(time:Number, isInProgress:Boolean) : void
        {
            var timerValue:String = null;
            if(!isNaN(time))
            {
                this._time = time;
                this.gotoAndStop(!!isInProgress?"progress":"complete");
                timerValue = this.formatTimerValue(this._time);
                this.timerTextField.text = timerValue;
            }
        }
        
        private function formatTimerValue(time:Number) : String
        {
            var stringArr:Array = null;
            var roundingBase:Number = Math.pow(10,FRACTIONAL_SIGNS);
            var roundedTime:Number = Math.round(time * roundingBase) / roundingBase;
            var rawString:String = String(roundedTime);
            var delimiter:String = this.getDelimiter(rawString);
            var leftPart:String = "";
            var rightPart:* = "";
            if(delimiter)
            {
                stringArr = rawString.split(delimiter);
                leftPart = stringArr.shift();
                rightPart = stringArr.join();
            }
            else
            {
                delimiter = ".";
                leftPart = rawString;
            }
            if(rightPart.length > FRACTIONAL_SIGNS)
            {
                rightPart = rightPart.slice(0,FRACTIONAL_SIGNS);
            }
            if(rightPart.length < FRACTIONAL_SIGNS)
            {
                while(rightPart.length < FRACTIONAL_SIGNS)
                {
                    rightPart = rightPart + "0";
                }
            }
            return leftPart + delimiter + rightPart;
        }
        
        private function getDelimiter(value:String) : String
        {
            var currentChar:String = null;
            var numbers:String = "0123456789";
            var charsTotal:Number = value.length;
            var delimiters:Array = [];
            var delim:String = "";
            var parsedNumberStr:String = "";
            var delimFound:Boolean = false;
            for(var i:int = 0; i < charsTotal; i++)
            {
                currentChar = value.charAt(i);
                if(numbers.indexOf(currentChar) == -1)
                {
                    delimFound = true;
                    delim = delim + currentChar;
                }
                else
                {
                    parsedNumberStr = parsedNumberStr + currentChar;
                    if(delimFound)
                    {
                        delimiters.push(delim);
                        delim = "";
                        delimFound = false;
                    }
                }
            }
            if(delimiters.length > 0)
            {
                delim = delimiters[0];
            }
            return delim;
        }
    }
}
