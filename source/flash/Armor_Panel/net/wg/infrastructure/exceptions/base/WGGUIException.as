package net.wg.infrastructure.exceptions.base
{
    public class WGGUIException extends Error
    {
         
        public function WGGUIException(message:* = "", id:* = 0)
        {
            super(message,id);
        }
    }
}
