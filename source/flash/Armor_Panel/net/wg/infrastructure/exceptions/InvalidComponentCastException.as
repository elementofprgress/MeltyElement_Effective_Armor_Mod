package net.wg.infrastructure.exceptions
{
    public class InvalidComponentCastException extends TypeCastException
    {
         
        public function InvalidComponentCastException(message:* = "", id:* = 0)
        {
            super(message,id);
        }
    }
}
