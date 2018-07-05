package net.wg.gui.components.crosshair
{
    import flash.events.Event;
    import flash.external.ExternalInterface;
    
    public class CrosshairPanelArcade extends CrosshairPanelBase
    {
        
        private static const CASSETE_POSITION_ARCADE:Number = -1;
        
        private static const CASSETE_POSITION_SNIPER:Number = 13;
        
        private static const CASSETE_POSITION_PANZER:Number = -11;
         
        public function CrosshairPanelArcade()
        {
            super();
            addEventListener(Event.ENTER_FRAME,this.callExternalInterface);
        }
        
        override public function setNetType(alphaValue:Number, type:Number) : void
        {
            super.setNetType(alphaValue,type);
            var casseteYPosition:Number = 0;
            switch(this.currentFrame)
            {
                case 1:
                    casseteYPosition = CASSETE_POSITION_ARCADE;
                    break;
                case 2:
                    casseteYPosition = CASSETE_POSITION_SNIPER;
                    break;
                case 3:
                    casseteYPosition = CASSETE_POSITION_PANZER;
            }
            cassette.y = casseteYPosition;
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            _fadingTargetWalker.setPosAsPercent(100);
            setDefaultTargetState();
            as_setAmmoStock(0,0,true,"critical");
        }
        
        override protected function onDispose() : void
        {
            removeEventListener(Event.ENTER_FRAME,this.callExternalInterface);
            super.onDispose();
        }
        
        private function callExternalInterface(event:Event) : void
        {
            removeEventListener(Event.ENTER_FRAME,this.callExternalInterface);
            ExternalInterface.call("registerArcadeAimPanel");
        }
    }
}
