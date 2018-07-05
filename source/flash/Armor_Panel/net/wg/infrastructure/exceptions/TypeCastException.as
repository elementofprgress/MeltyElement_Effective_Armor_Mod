package net.wg.infrastructure.exceptions
{
    import net.wg.infrastructure.exceptions.base.WGGUIException;
    
    public class TypeCastException extends WGGUIException
    {
         
        public function TypeCastException(message:* = "", id:* = 0)
        {
            super(message,id);
        }
    }
}
