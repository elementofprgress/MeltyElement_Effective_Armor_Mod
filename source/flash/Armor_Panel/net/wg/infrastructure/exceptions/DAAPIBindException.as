package net.wg.infrastructure.exceptions
{
    import net.wg.infrastructure.exceptions.base.WGGUIException;
    
    public class DAAPIBindException extends WGGUIException
    {
         
        public function DAAPIBindException(message:* = "", id:* = 0)
        {
            super(message,id);
        }
    }
}
