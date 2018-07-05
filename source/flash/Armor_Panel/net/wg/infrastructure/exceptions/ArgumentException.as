package net.wg.infrastructure.exceptions
{
    import net.wg.infrastructure.exceptions.base.WGGUIException;
    
    public class ArgumentException extends WGGUIException
    {
         
        public function ArgumentException(message:* = "", id:* = 0)
        {
            super(message,id);
        }
    }
}
