class net.wargaming.utils.DebugUtils
{
    function DebugUtils()
    {
    }
    static function LOG_DEBUG()
    {
        arguments.unshift("DEBUG");
        net.wargaming.utils.DebugUtils.__doLog.apply(null,arguments);
    }
    static function LOG_ERROR()
    {
        arguments.unshift("ERROR");
        net.wargaming.utils.DebugUtils.__doLog.apply(null,arguments);
    }
    static function LOG_WARNING()
    {
        arguments.unshift("WARNING");
        net.wargaming.utils.DebugUtils.__doLog.apply(null,arguments);
    }
    static function LOG_DEBUG_FORMAT()
    {
        arguments.unshift("DEBUG");
        net.wargaming.utils.DebugUtils.__doLogFormat.apply(null,arguments);
    }
    static function LOG_ERROR_FORMAT()
    {
        arguments.unshift("ERROR");
        net.wargaming.utils.DebugUtils.__doLogFormat.apply(null,arguments);
    }
    static function LOG_WARNING_FORMAT()
    {
        arguments.unshift("WARNING");
        net.wargaming.utils.DebugUtils.__doLogFormat.apply(null,arguments);
    }
    static function __doLog()
    {
        trace("[" + arguments[0] + "] " + arguments.slice(1).toString());
        var _loc2 = ["debug.LOG_GUI"];
        while(arguments.length)
        {
            _loc2.push(String(arguments.shift()));
        }
        flash.external.ExternalInterface.call.apply(null,_loc2);
    }
    static function __doLogFormat()
    {
        var _loc2 = ["debug.LOG_GUI_FORMAT"];
        while(arguments.length)
        {
            _loc2.push(String(arguments.shift()));
        }
        flash.external.ExternalInterface.call.apply(null,_loc2);
    }
}
