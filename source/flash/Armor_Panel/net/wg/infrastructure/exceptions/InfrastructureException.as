package net.wg.infrastructure.exceptions
{
    import net.wg.infrastructure.exceptions.base.WGGUIException;
    
    public class InfrastructureException extends WGGUIException
    {
         
        public function InfrastructureException(message:String = "", id:* = 0)
        {
            super(message,id);
        }
    }
}
