package scaleform.clik.controls
{
    import scaleform.clik.core.UIComponent;
    import scaleform.clik.interfaces.IScrollBar;
    import flash.display.MovieClip;
    import flash.events.Event;
    import scaleform.clik.constants.ScrollBarDirection;
    import scaleform.clik.events.InputEvent;
    import scaleform.clik.ui.InputDetails;
    import scaleform.clik.constants.InputValue;
    import scaleform.clik.constants.NavigationCode;
    import flash.text.TextField;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    
    public class ScrollIndicator extends UIComponent implements IScrollBar
    {
         
        public var direction:String = "vertical";
        
        public var offsetTop:Number = 0;
        
        public var offsetBottom:Number = 0;
        
        protected var _isDragging:Boolean = false;
        
        protected var _maxPosition:Number = 10;
        
        protected var _minPosition:Number = 0;
        
        protected var _minThumbSize:Number = 10;
        
        protected var _pageScrollSize:Number = 1;
        
        protected var _pageSize:Number;
        
        protected var _position:Number = 5;
        
        protected var _scrollTarget:Object;
        
        public var thumb:MovieClip;
        
        public var track:MovieClip;
        
        public function ScrollIndicator()
        {
            super();
        }
        
        override protected function initialize() : void
        {
            super.initialize();
        }
        
        override public function get enabled() : Boolean
        {
            return super.enabled;
        }
        
        override public function set enabled(value:Boolean) : void
        {
            if(value == super.enabled)
            {
                return;
            }
            super.enabled = value;
            gotoAndPlay(!!this.enabled?"default":"disabled");
        }
        
        public function get position() : Number
        {
            return this._position;
        }
        
        public function set position(value:Number) : void
        {
            value = Math.max(this._minPosition,Math.min(this._maxPosition,value));
            if(value == this._position)
            {
                return;
            }
            this._position = value;
            dispatchEvent(new Event(Event.SCROLL));
            invalidateData();
        }
        
        public function get minThumbSize() : Number
        {
            return this._minThumbSize;
        }
        
        public function set minThumbSize(value:Number) : void
        {
            value = Math.max(1,value);
            this._minThumbSize = value;
            invalidateSize();
        }
        
        public function get isHorizontal() : Boolean
        {
            return this.direction == ScrollBarDirection.HORIZONTAL;
        }
        
        public function get scrollTarget() : Object
        {
            return this._scrollTarget;
        }
        
        public function set scrollTarget(value:Object) : void
        {
            if(value is String)
            {
                if(!componentInspectorSetting || value.toString() == "" || parent == null)
                {
                    return;
                }
                value = parent.getChildByName(value.toString());
                if(value == null)
                {
                    return;
                }
            }
            var oldTarget:Object = this._scrollTarget;
            this._scrollTarget = value;
            if(oldTarget != null)
            {
                oldTarget.removeEventListener(Event.SCROLL,this.handleTargetScroll,false);
                if(oldTarget.scrollBar != null)
                {
                    oldTarget.scrollBar = null;
                }
            }
            if(value is UIComponent && "scrollBar" in value)
            {
                value.scrollBar = this;
                return;
            }
            if(this._scrollTarget == null)
            {
                tabEnabled = true;
                return;
            }
            this._scrollTarget.addEventListener(Event.SCROLL,this.handleTargetScroll,false,0,true);
            if(this._scrollTarget is UIComponent)
            {
                focusTarget = this._scrollTarget as UIComponent;
            }
            tabEnabled = false;
            this.handleTargetScroll(null);
            invalidate();
        }
        
        public function get availableHeight() : Number
        {
            var thumbHeight:Number = !!isNaN(this.thumb.height)?Number(0):Number(this.thumb.height);
            return (!!this.isHorizontal?_width:_height) - thumbHeight + this.offsetBottom + this.offsetTop;
        }
        
        public function setScrollProperties(pageSize:Number, minPosition:Number, maxPosition:Number, pageScrollSize:Number = NaN) : void
        {
            this._pageSize = pageSize;
            if(!isNaN(pageScrollSize))
            {
                this._pageScrollSize = pageScrollSize;
            }
            this._minPosition = minPosition;
            this._maxPosition = maxPosition;
            invalidateSize();
        }
        
        override public function handleInput(event:InputEvent) : void
        {
            if(event.handled)
            {
                return;
            }
            var details:InputDetails = event.details;
            if(details.value == InputValue.KEY_UP)
            {
                return;
            }
            var isHorizontal:* = this.direction == ScrollBarDirection.HORIZONTAL;
            switch(details.navEquivalent)
            {
                case NavigationCode.UP:
                    if(isHorizontal)
                    {
                        return;
                    }
                    this.position = this.position - 1;
                    break;
                case NavigationCode.DOWN:
                    if(isHorizontal)
                    {
                        return;
                    }
                    this.position = this.position + 1;
                    break;
                case NavigationCode.LEFT:
                    if(!isHorizontal)
                    {
                        return;
                    }
                    this.position = this.position - 1;
                    break;
                case NavigationCode.RIGHT:
                    if(!isHorizontal)
                    {
                        return;
                    }
                    this.position = this.position + 1;
                    break;
                case NavigationCode.HOME:
                    this.position = 0;
                    break;
                case NavigationCode.END:
                    this.position = this._maxPosition;
                    break;
                default:
                    return;
            }
            event.handled = true;
        }
        
        override public function toString() : String
        {
            return "[CLIK ScrollIndicator " + name + "]";
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            focusable = false;
            mouseChildren = mouseEnabled = false;
            if(this.track == null)
            {
                this.track = new MovieClip();
            }
            this.thumb.enabled = this.enabled;
            initSize();
            this.direction = rotation != 0 && rotation != 180?ScrollBarDirection.HORIZONTAL:ScrollBarDirection.VERTICAL;
        }
        
        override protected function draw() : void
        {
            var target:TextField = null;
            if(isInvalid(InvalidationType.SIZE))
            {
                setActualSize(_width,_height);
                this.drawLayout();
                this.updateThumb();
            }
            else if(isInvalid(InvalidationType.DATA))
            {
                if(this._scrollTarget is TextField)
                {
                    target = this._scrollTarget as TextField;
                    this.setScrollProperties(target.bottomScrollV - target.scrollV,1,target.maxScrollV);
                }
                this.updateThumbPosition();
            }
        }
        
        protected function drawLayout() : void
        {
            this.track.height = !!this.isHorizontal?Number(_width):Number(_height);
            if(this.track is UIComponent)
            {
                this.track.validateNow();
            }
        }
        
        protected function updateThumb() : void
        {
            var per:Number = Math.max(1,this._maxPosition - this._minPosition + this._pageSize);
            var trackHeight:Number = (!!this.isHorizontal?_width:_height) + this.offsetTop + this.offsetBottom;
            this.thumb.height = Math.max(this._minThumbSize,Math.min(_height,this._pageSize / per * trackHeight));
            if(this.thumb is UIComponent)
            {
                (this.thumb as UIComponent).validateNow();
            }
            this.updateThumbPosition();
        }
        
        protected function updateThumbPosition() : void
        {
            var percent:Number = (this._position - this._minPosition) / (this._maxPosition - this._minPosition);
            if(isNaN(percent))
            {
                percent = 0;
            }
            var yPos:Number = percent * this.availableHeight;
            this.thumb.y = Math.max(-this.offsetTop,Math.min(this.availableHeight - this.offsetTop,yPos));
            this.thumb.visible = !(this._maxPosition == this._minPosition || Boolean(isNaN(this._pageSize)) || this._maxPosition == 0);
        }
        
        protected function handleTargetScroll(event:Event) : void
        {
            if(this._isDragging)
            {
                return;
            }
            var target:TextField = this._scrollTarget as TextField;
            if(target != null)
            {
                this.setScrollProperties(target.bottomScrollV - target.scrollV,1,target.maxScrollV);
                this.position = target.scrollV;
            }
        }
        
        override protected function onDispose() : void
        {
            if(this._scrollTarget)
            {
                this._scrollTarget.removeEventListener(Event.SCROLL,this.handleTargetScroll,false);
                this._scrollTarget = null;
            }
            if(Boolean(this.thumb) && this.thumb is IDisposable)
            {
                IDisposable(this.thumb).dispose();
            }
            this.thumb = null;
            if(Boolean(this.track) && this.track is IDisposable)
            {
                IDisposable(this.track).dispose();
            }
            this.track = null;
            super.onDispose();
        }
    }
}
