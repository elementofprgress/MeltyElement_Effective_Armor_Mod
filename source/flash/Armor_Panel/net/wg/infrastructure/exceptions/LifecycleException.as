package net.wg.infrastructure.exceptions
{
    import net.wg.infrastructure.exceptions.base.WGGUIException;
    
    public class LifecycleException extends WGGUIException
    {
         
        public function LifecycleException(message:* = "", id:* = 0)
        {
            super(message,id);
        }
    }
}
