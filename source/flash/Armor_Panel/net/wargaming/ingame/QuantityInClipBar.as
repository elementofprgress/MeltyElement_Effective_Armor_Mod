class net.wargaming.ingame.QuantityInClipBar extends gfx.core.UIComponent
{
    var initialized, capacityBar, __get__clipCapacity, quantityInClipBar, quantityInClipField, __get__quantityInClip, quantityField, __get__quantity, gotoAndStop, invalidate, __get__clipState, __get__mode, gotoAndPlay, __set__clipCapacity, __set__clipState, __set__mode, __set__quantity, __set__quantityInClip;
    function QuantityInClipBar()
    {
        super();
    } // End of the function
    static function create(context, clipCapacity, burst)
    {
        var _loc3 = "LightClipQuantityBar";
        var _loc2 = "percent";
        var _loc1 = clipCapacity;
        if (burst > 1)
        {
            _loc1 = Math.ceil(_loc1 / burst);
        } // end if
        if (_loc1 < 13)
        {
            _loc3 = "HeavyClipQuantityBar";
            _loc2 = burst > 1 ? ("queue") : ("ammo");
        }
        else if (_loc1 < 31)
        {
            _loc3 = "MediumClipQuantityBar";
            _loc2 = burst > 1 ? ("queue") : ("ammo");
        } // end else if
        net.wargaming.ingame.QuantityInClipBar.storedProps._clipCapacity = clipCapacity;
        net.wargaming.ingame.QuantityInClipBar.storedProps._mode = _loc2;
        net.wargaming.ingame.QuantityInClipBar.storedProps._burst = burst;
        storedPropsChanged = false;
        return (gfx.core.UIComponent.createInstance(context, _loc3, "quantityInClipBar", context.getNextHighestDepth(), net.wargaming.ingame.QuantityInClipBar.storedProps));
    } // End of the function
    static function store(quantity, quantityInClip, state)
    {
        net.wargaming.ingame.QuantityInClipBar.storedProps._quantity = quantity;
        net.wargaming.ingame.QuantityInClipBar.storedProps._quantityInClip = quantityInClip;
        net.wargaming.ingame.QuantityInClipBar.storedProps._clipState = state;
        storedPropsChanged = true;
    } // End of the function
    function get clipCapacity()
    {
        return (_clipCapacity);
    } // End of the function
    function set clipCapacity(value)
    {
        if (value == _clipCapacity || value < 0)
        {
            return;
        } // end if
        _clipCapacity = value;
        if (initialized && capacityBar != null)
        {
            totalFrames = this.calcTotalFrames();
            capacityBar.gotoAndStop(totalFrames);
        } // end if
        null;
        //return (this.clipCapacity());
        null;
    } // End of the function
    function get quantityInClip()
    {
        return (_quantityInClip);
    } // End of the function
    function set quantityInClip(value)
    {
        if (value == _quantityInClip || value < 0)
        {
            return;
        } // end if
        _quantityInClip = value;
        if (initialized)
        {
            if (quantityInClipBar != null)
            {
                var _loc2 = this.calcCurrentFrame();
                if (_loc2 != currentFrame)
                {
                    currentFrame = _loc2;
                    quantityInClipBar.gotoAndStop(currentFrame);
                } // end if
            } // end if
            if (quantityInClipField != null)
            {
                quantityInClipField.text = _quantityInClip.toString();
            } // end if
        } // end if
        null;
        //return (this.quantityInClip());
        null;
    } // End of the function
    function get quantity()
    {
        return (_quantity);
    } // End of the function
    function set quantity(value)
    {
        if (value == _quantity || value < -1)
        {
            return;
        } // end if
        _quantity = value;
        if (initialized && quantityField != null)
        {
            quantityField.text = "/" + _quantity.toString();
        } // end if
        null;
        //return (this.quantity());
        null;
    } // End of the function
    function get clipState()
    {
        return (_clipState);
    } // End of the function
    function set clipState(value)
    {
        if (value == _clipState)
        {
            return;
        } // end if
        _clipState = value;
        if (initialized)
        {
            this.gotoAndStop(_clipState);
            this.invalidate();
        } // end if
        null;
        //return (this.clipState());
        null;
    } // End of the function
    function get mode()
    {
        return (_mode);
    } // End of the function
    function set mode(value)
    {
        if (value == _mode || value != "ammo" && value != "percent" && value != "burst")
        {
            return;
        } // end if
        _mode = value;
        totalFrames = this.calcTotalFrames();
        currentFrame = this.calcCurrentFrame();
        this.invalidate();
        null;
        //return (this.mode());
        null;
    } // End of the function
    function change(quantity, quantityInClip, clipState, reloaded)
    {
        _quantity = quantity;
        _quantityInClip = quantityInClip;
        currentFrame = this.calcCurrentFrame();
        if (initialized)
        {
            if (reloaded && _quantityInClip == _clipCapacity)
            {
                this.gotoAndPlay("reloaded");
            }
            else if (_clipState != clipState)
            {
                this.gotoAndStop(clipState);
            } // end else if
            _clipState = clipState;
            this.invalidate();
        } // end if
    } // End of the function
    function configUI()
    {
        super.configUI();
        if (net.wargaming.ingame.QuantityInClipBar.storedPropsChanged)
        {
            _quantity = net.wargaming.ingame.QuantityInClipBar.storedProps._quantity;
            _quantityInClip = net.wargaming.ingame.QuantityInClipBar.storedProps._quantityInClip;
            _clipState = net.wargaming.ingame.QuantityInClipBar.storedProps._clipState;
            storedPropsChanged = false;
        } // end if
        this.gotoAndStop(_clipState);
        totalFrames = this.calcTotalFrames();
        currentFrame = this.calcCurrentFrame();
    } // End of the function
    function draw()
    {
        super.draw();
        if (capacityBar != null)
        {
            capacityBar.gotoAndStop(totalFrames);
        } // end if
        if (quantityInClipBar != null)
        {
            quantityInClipBar.gotoAndStop(currentFrame);
        } // end if
        if (quantityInClipField != null)
        {
            quantityInClipField.text = _quantityInClip.toString();
        } // end if
        if (quantityField != null)
        {
            quantityField.text = "/" + _quantity.toString();
        } // end if
    } // End of the function
    function calcTotalFrames()
    {
        var _loc2 = capacityBar._totalframes;
        if (_mode == "ammo")
        {
            _loc2 = Math.min(_clipCapacity + 1, _loc2);
        }
        else if (_mode == "queue")
        {
            _loc2 = Math.min(Math.ceil(_clipCapacity / _burst) + 1, _loc2);
        } // end else if
        return (_loc2);
    } // End of the function
    function calcCurrentFrame()
    {
        var _loc2 = currentFrame;
        var _loc3 = totalFrames > _clipCapacity / Math.max(_burst, 1);
        if (_mode == "ammo" && _loc3)
        {
            _loc2 = _quantityInClip > 0 ? (_quantityInClip + 1) : (0);
        }
        else if (_mode == "queue" && _loc3)
        {
            _loc2 = Math.ceil(_quantityInClip / _burst) + 1;
        }
        else if (_clipCapacity > 0)
        {
            _loc2 = Math.ceil(totalFrames * _quantityInClip / _clipCapacity);
        } // end else if
        return (Math.min(_loc2, totalFrames));
    } // End of the function
    var _clipCapacity = 1;
    var _burst = 1;
    var _quantityInClip = 0;
    var _quantity = 0;
    var _clipState = "critical";
    var _mode = "frame";
    var currentFrame = 0;
    var totalFrames = 0;
    static var storedPropsChanged = false;
    static var storedProps = {_clipCapacity: 1, _burst: 1, _quantity: 0, _quantityInClip: 0, _mode: "critical"};
} // End of Class
