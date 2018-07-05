package net.wg.mock.utils
{
    import net.wg.utils.IDateTime;
    
    public class MockDateTime implements IDateTime
    {
         
        public function MockDateTime()
        {
            super();
        }
        
        public function as3DayNumToPyDayNum(num:int) : int
        {
            return 0;
        }
        
        public function as3MonthNumToPyMonthNum(num:int) : int
        {
            return 0;
        }
        
        public function cloneDate(date:Date) : Date
        {
            return null;
        }
        
        public function convertToTwelveHourFormat(hour:int) : int
        {
            return 0;
        }
        
        public function fromPyTimestamp(timestamp:Number) : Date
        {
            return null;
        }
        
        public function getAS3FirstDayOfWeek() : int
        {
            return 0;
        }
        
        public function getAmPmPrefix(hour:int) : String
        {
            return "";
        }
        
        public function getDayName(number:int, isPyNum:Boolean = true, full:Boolean = true, isUpper:Boolean = false, isLower:Boolean = false) : String
        {
            return "";
        }
        
        public function getMonthDaysCount(date:Date) : uint
        {
            return 0;
        }
        
        public function getMonthName(number:int, isPyNum:Boolean = true, full:Boolean = true, isUpper:Boolean = false, isLower:Boolean = false) : String
        {
            return "";
        }
        
        public function hourIsAm(hour:int) : Boolean
        {
            return false;
        }
        
        public function isCurrentMonth(date:Date) : Boolean
        {
            return false;
        }
        
        public function isFuture(date:Date) : Boolean
        {
            return false;
        }
        
        public function isPast(date:Date) : Boolean
        {
            return false;
        }
        
        public function isSameDay(date1:Date, date2:Date) : Boolean
        {
            return false;
        }
        
        public function isSameMonth(date1:Date, date2:Date) : Boolean
        {
            return false;
        }
        
        public function isToday(date:Date) : Boolean
        {
            return false;
        }
        
        public function now() : Date
        {
            return null;
        }
        
        public function pyDayNumToAS3DayNum(num:int) : int
        {
            return 0;
        }
        
        public function pyMonthNumToAS3MonthNum(num:int) : int
        {
            return 0;
        }
        
        public function shiftDate(date:Date, time:int) : Date
        {
            return null;
        }
        
        public function timeDiff(date1:Date, date2:Date) : Number
        {
            return 0;
        }
        
        public function toPyTimestamp(date:Date) : Number
        {
            return 0;
        }
    }
}
