package net.wg.gui.components.crosshair
{
    import flash.display.MovieClip;
    import net.wg.infrastructure.interfaces.IDAAPIModule;
    import flash.utils.getQualifiedClassName;
    
    public class CrosshairPanelDAAPI extends MovieClip implements IDAAPIModule
    {
         
        private var _disposed:Boolean = false;
        
        private var _isDAAPIInited:Boolean = false;
        
        public function CrosshairPanelDAAPI()
        {
            super();
        }
        
        public final function dispose() : void
        {
            if(this._disposed)
            {
                throw Error("(" + getQualifiedClassName(this) + ") already disposed!");
            }
            this.onDispose();
            this._disposed = true;
        }
        
        public function get disposed() : Boolean
        {
            return this._disposed;
        }
        
        public function get isDAAPIInited() : Boolean
        {
            return this._isDAAPIInited;
        }
        
        protected function onPopulate() : void
        {
            this._isDAAPIInited = true;
        }
        
        protected function onDispose() : void
        {
        }
        
        public final function as_dispose() : void
        {
            this.dispose();
        }
        
        public function as_isDAAPIInited() : Boolean
        {
            return this._isDAAPIInited;
        }
        
        public final function as_populate() : void
        {
            this.onPopulate();
        }
    }
}
