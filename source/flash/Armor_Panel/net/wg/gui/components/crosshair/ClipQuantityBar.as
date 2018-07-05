package net.wg.gui.components.crosshair
{
    import net.wg.infrastructure.base.SimpleContainer;
    import flash.utils.getDefinitionByName;
    import flash.display.MovieClip;
    
    public class ClipQuantityBar extends SimpleContainer
    {
        
        private static var _storedPropsChanged:Boolean = false;
        
        private static var _storedProps:Object = {
            "clipCapacity":1,
            "burst":1,
            "quantity":0,
            "quantityInClip":0,
            "mode":MODE_CRITICAL
        };
        
        private static const HEAVY_LIMIT:int = 13;
        
        private static const MEDIUM_LIMIT:int = 31;
        
        public static const TYPE_LIGHT:String = "LightClipQuantityBar";
        
        public static const TYPE_MEDIUM:String = "MediumClipQuantityBar";
        
        public static const TYPE_HEAVY:String = "HeavyClipQuantityBar";
        
        public static const STATE_NORMAL:String = "normal";
        
        public static const STATE_RELOADED:String = "reloaded";
        
        public static const MODE_FRAME:String = "frame";
        
        public static const MODE_PERCENT:String = "percent";
        
        public static const MODE_QUEUE:String = "queue";
        
        public static const MODE_AMMO:String = "ammo";
        
        public static const MODE_BURST:String = "burst";
        
        public static const MODE_CRITICAL:String = "critical";
         
        public var capacityBar:MovieClip;
        
        public var quantityInClipBar:MovieClip;
        
        private var _quantityBarCurrentFrame:Number = 0;
        
        private var _quantityBarTotalFrames:Number = 0;
        
        private var _clipCapacity:Number = 1;
        
        private var _burst:Number = 1;
        
        private var _quantityInClip:Number = 0;
        
        private var _quantity:Number = 0;
        
        private var _clipState:String = "normal";
        
        private var _mode:String = "frame";
        
        public function ClipQuantityBar()
        {
            super();
        }
        
        public static function create(clipCapacity:Number, burst:Number) : ClipQuantityBar
        {
            var viewType:String = null;
            var result:ClipQuantityBar = null;
            var viewClass:Class = null;
            var key:String = null;
            viewType = TYPE_LIGHT;
            var mode:String = MODE_PERCENT;
            var metric:Number = clipCapacity;
            if(burst > 1)
            {
                metric = (metric / burst ^ 0) + 1;
            }
            if(metric < HEAVY_LIMIT)
            {
                viewType = TYPE_HEAVY;
                mode = burst > 1?MODE_QUEUE:MODE_AMMO;
            }
            else if(metric < MEDIUM_LIMIT)
            {
                viewType = TYPE_MEDIUM;
                mode = burst > 1?MODE_QUEUE:MODE_AMMO;
            }
            _storedProps.clipCapacity = clipCapacity;
            _storedProps.mode = mode;
            _storedProps.burst = burst;
            _storedPropsChanged = false;
            try
            {
                viewClass = getDefinitionByName(viewType) as Class;
                result = new viewClass();
                for(key in _storedProps)
                {
                    if(result.hasOwnProperty(key))
                    {
                        result[key] = _storedProps[key];
                    }
                }
            }
            catch(error:Error)
            {
                DebugUtils.LOG_ERROR("ClipQuantityBar: can\'t find renderer class: " + viewType);
            }
            return result;
        }
        
        public static function store(quantity:Number, quantityInClip:Number, state:String) : void
        {
            _storedProps.quantity = quantity;
            _storedProps.quantityInClip = quantityInClip;
            _storedProps.clipState = state;
            _storedPropsChanged = true;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            if(_storedPropsChanged)
            {
                this._quantity = _storedProps.quantity;
                this._quantityInClip = _storedProps.quantityInClip;
                this._clipState = _storedProps.clipState;
                _storedPropsChanged = false;
            }
            gotoAndStop(this._clipState);
            this._quantityBarTotalFrames = this.calcTotalFrames();
            this._quantityBarCurrentFrame = this.calcCurrentFrame();
        }
        
        override protected function onDispose() : void
        {
            this.capacityBar = null;
            this.quantityInClipBar = null;
            _storedProps = null;
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
            this.capacityBar.gotoAndStop(this._quantityBarTotalFrames);
            this.quantityInClipBar.gotoAndStop(this._quantityBarCurrentFrame);
        }
        
        public function change(quantity:Number, quantityInClip:Number, clipState:String, reloaded:Boolean) : void
        {
            this._quantity = quantity;
            this._quantityInClip = quantityInClip;
            this._quantityBarCurrentFrame = this.calcCurrentFrame();
            if(initialized)
            {
                if(Boolean(reloaded) && this._quantityInClip == this._clipCapacity)
                {
                    gotoAndPlay(STATE_RELOADED);
                }
                else if(this._clipState != clipState)
                {
                    gotoAndStop(clipState);
                }
                this._clipState = clipState;
                invalidate();
            }
        }
        
        private function calcTotalFrames() : Number
        {
            var result:Number = this.capacityBar.totalFrames;
            if(this._mode == MODE_AMMO)
            {
                result = Math.min(this._clipCapacity + 1,result);
            }
            else if(this._mode == MODE_QUEUE)
            {
                result = Math.min((this._clipCapacity / this._burst ^ 0) + 1,result);
            }
            return result;
        }
        
        private function calcCurrentFrame() : Number
        {
            var result:Number = this._quantityBarCurrentFrame;
            var limit:* = this._quantityBarTotalFrames > this._clipCapacity / Math.max(this._burst,1);
            if(this._mode == MODE_AMMO && Boolean(limit))
            {
                result = this._quantityInClip > 0?Number(this._quantityInClip + 1):Number(0);
            }
            else if(this._mode == MODE_QUEUE && Boolean(limit))
            {
                result = (this._quantityInClip / this._burst ^ 0) + 1;
            }
            else if(this._clipCapacity > 0)
            {
                result = this._quantityBarTotalFrames * this._quantityInClip / this._clipCapacity ^ 0;
            }
            return Math.min(result,this._quantityBarTotalFrames);
        }
        
        public function get clipCapacity() : Number
        {
            return this._clipCapacity;
        }
        
        public function set clipCapacity(value:Number) : void
        {
            if(value == this._clipCapacity || value < 0)
            {
                return;
            }
            this._clipCapacity = value;
            if(Boolean(initialized) || true)
            {
                this._quantityBarTotalFrames = this.calcTotalFrames();
                this.capacityBar.gotoAndStop(this._quantityBarTotalFrames);
            }
        }
        
        public function get burst() : Number
        {
            return this._burst;
        }
        
        public function set burst(val:Number) : void
        {
            this._burst = val;
        }
        
        public function get quantityInClip() : Number
        {
            return this._quantityInClip;
        }
        
        public function set quantityInClip(value:Number) : void
        {
            if(value == this._quantityInClip || value < 0)
            {
                return;
            }
            this._quantityInClip = value;
            var current:Number = this.calcCurrentFrame();
            if(current != this._quantityBarCurrentFrame)
            {
                this._quantityBarCurrentFrame = current;
                this.quantityInClipBar.gotoAndStop(this._quantityBarCurrentFrame);
            }
        }
        
        public function get quantity() : Number
        {
            return this._quantity;
        }
        
        public function set quantity(value:Number) : void
        {
            if(value == this._quantity || value < -1)
            {
                return;
            }
            this._quantity = value;
        }
        
        public function get clipState() : String
        {
            return this._clipState;
        }
        
        public function set clipState(value:String) : void
        {
            if(value == this._clipState)
            {
                return;
            }
            this._clipState = value;
            gotoAndStop(this._clipState);
        }
        
        public function get mode() : String
        {
            return this._mode;
        }
        
        public function set mode(value:String) : void
        {
            if(value == this._mode || value != MODE_AMMO && value != MODE_PERCENT && value != MODE_BURST && value != MODE_QUEUE)
            {
                return;
            }
            this._mode = value;
            this._quantityBarTotalFrames = this.calcTotalFrames();
            this._quantityBarCurrentFrame = this.calcCurrentFrame();
            invalidate();
        }
    }
}
