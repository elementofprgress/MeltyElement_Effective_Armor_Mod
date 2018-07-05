package net.wg.mock
{
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.data.managers.ITooltipProps;
    import net.wg.infrastructure.managers.ITooltipFormatter;
    import net.wg.data.managers.IToolTipParams;
    
    public class MockTooltipMgr implements ITooltipMgr
    {
         
        public function MockTooltipMgr()
        {
            super();
        }
        
        public function getDefaultTooltipProps() : ITooltipProps
        {
            return null;
        }
        
        public function getNewFormatter() : ITooltipFormatter
        {
            return null;
        }
        
        public function hide() : void
        {
        }
        
        public function show(tooltipId:String, properties:ITooltipProps = null) : void
        {
        }
        
        public function showComplex(tooltipId:String, properties:ITooltipProps = null) : void
        {
        }
        
        public function showComplexWithParams(tooltipId:String, params:IToolTipParams, properties:ITooltipProps = null) : void
        {
        }
        
        public function showLocal(linkage:String, tooltipData:Object, properties:ITooltipProps = null) : void
        {
        }
        
        public function showSpecial(type:String, properties:ITooltipProps, ... args) : void
        {
        }
    }
}
