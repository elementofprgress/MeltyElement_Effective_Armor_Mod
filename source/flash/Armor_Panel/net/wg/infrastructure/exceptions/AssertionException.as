package net.wg.infrastructure.exceptions
{
    import net.wg.infrastructure.exceptions.base.WGGUIException;
    
    public class AssertionException extends WGGUIException
    {
         
        public function AssertionException(message:* = "", id:* = 0)
        {
            super(message,id);
        }
    }
}
