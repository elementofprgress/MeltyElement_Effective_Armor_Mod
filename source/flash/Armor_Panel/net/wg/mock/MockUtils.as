package net.wg.mock
{
    import net.wg.utils.IUtils;
    import net.wg.utils.IAssertable;
    import net.wg.utils.IScheduler;
    import net.wg.utils.ILocale;
    import net.wg.infrastructure.interfaces.entity.ISerializable;
    import net.wg.utils.helpLayout.IHelpLayout;
    import net.wg.utils.IClassFactory;
    import net.wg.utils.IPopUpManager;
    import net.wg.utils.ICommons;
    import net.wg.utils.INations;
    import net.wg.utils.IFocusHandler;
    import net.wg.utils.IEventCollector;
    import net.wg.utils.IIME;
    import net.wg.utils.IVOManager;
    import net.wg.utils.IIcons;
    import net.wg.utils.IStyleSheetManager;
    import net.wg.utils.ITweenAnimator;
    import net.wg.utils.IAnimBuilder;
    import net.wg.utils.IDateTime;
    import net.wg.utils.IImageManager;
    import net.wg.utils.IDataUtils;
    import net.wg.infrastructure.interfaces.IStrCaseProperties;
    import net.wg.infrastructure.interfaces.IImageUrlProperties;
    import net.wg.infrastructure.interfaces.pool.IPoolManager;
    import flash.events.Event;
    import net.wg.mock.utils.MockAssertable;
    import net.wg.mock.utils.MockScheduler;
    import net.wg.mock.utils.MockLocale;
    import net.wg.mock.utils.MockJSON;
    import net.wg.mock.utils.MockHelpLayout;
    import net.wg.mock.utils.MockClassFactory;
    import net.wg.mock.utils.MockPopUpManager;
    import net.wg.mock.utils.MockCommons;
    import net.wg.mock.utils.MockNations;
    import net.wg.mock.utils.MockFocusHandler;
    import net.wg.mock.utils.MockEventCollector;
    import net.wg.mock.utils.MockIME;
    import net.wg.mock.utils.MockVOManager;
    import net.wg.mock.utils.MockIcons;
    import net.wg.mock.utils.MockStyleSheetManager;
    import net.wg.mock.utils.MockTweenAnimator;
    import net.wg.mock.utils.MockAnimBuilder;
    import net.wg.mock.utils.MockDateTime;
    import net.wg.mock.utils.MockImageManager;
    
    public class MockUtils implements IUtils
    {
         
        private var _asserter:IAssertable;
        
        private var _scheduler:IScheduler;
        
        private var _locale:ILocale;
        
        private var _JSON:ISerializable;
        
        private var _helpLayout:IHelpLayout;
        
        private var _classFactory:IClassFactory;
        
        private var _popupMgr:IPopUpManager;
        
        private var _commons:ICommons;
        
        private var _nations:INations;
        
        private var _focusHandler:IFocusHandler;
        
        private var _events:IEventCollector;
        
        private var _IME:IIME;
        
        private var _voMgr:IVOManager;
        
        private var _icons:IIcons;
        
        private var _styleSheetManager:IStyleSheetManager;
        
        private var _tweenAnimator:ITweenAnimator;
        
        private var _animBuilder:IAnimBuilder;
        
        private var _dateTime:IDateTime;
        
        private var _imageManager:IImageManager;
        
        private var _dataUtils:IDataUtils;
        
        public function MockUtils()
        {
            super();
            this._asserter = new MockAssertable();
            this._scheduler = new MockScheduler();
            this._locale = new MockLocale();
            this._JSON = new MockJSON();
            this._helpLayout = new MockHelpLayout();
            this._classFactory = new MockClassFactory();
            this._popupMgr = new MockPopUpManager();
            this._commons = new MockCommons();
            this._nations = new MockNations();
            this._focusHandler = new MockFocusHandler();
            this._events = new MockEventCollector();
            this._IME = new MockIME();
            this._voMgr = new MockVOManager();
            this._icons = new MockIcons();
            this._styleSheetManager = new MockStyleSheetManager();
            this._tweenAnimator = new MockTweenAnimator();
            this._animBuilder = new MockAnimBuilder();
            this._dateTime = new MockDateTime();
            this._imageManager = new MockImageManager();
            this._dataUtils = new MockDataUtils();
        }
        
        public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
        {
        }
        
        public function as_setImageCacheSettings(maxSize:int, minSize:int) : void
        {
        }
        
        public function changeStringCasingS(string:String, isUpper:Boolean, properties:IStrCaseProperties) : String
        {
            return "";
        }
        
        public function dispose() : void
        {
        }
        
        public function getAbsoluteUrlS(relativeUrl:String) : String
        {
            return "";
        }
        
        public function getFirstDayOfWeekS() : int
        {
            return 0;
        }
        
        public function getGUINationsS() : Array
        {
            return null;
        }
        
        public function getHtmlIconTextS(properties:IImageUrlProperties) : String
        {
            return "";
        }
        
        public function getImageUrlProperties(sourceImage:String, width:int, height:int, vSpace:int = -4, hSpace:int = 0) : IImageUrlProperties
        {
            return null;
        }
        
        public function getMonthsNamesS(full:Boolean = true, isUpper:Boolean = false, isLower:Boolean = false) : Array
        {
            return null;
        }
        
        public function getNationIndicesS() : Object
        {
            return null;
        }
        
        public function getNationNamesS() : Array
        {
            return null;
        }
        
        public function getStrCaseProperties() : IStrCaseProperties
        {
            return null;
        }
        
        public function getWeekDayNamesS(full:Boolean = true, isUpper:Boolean = false, isLower:Boolean = false) : Array
        {
            return null;
        }
        
        public function hasEventListener(type:String) : Boolean
        {
            return false;
        }
        
        public function intToStringWithPrefixPaternS(value:int, count:int, fill:String) : String
        {
            return "";
        }
        
        public function isTwelveHoursFormatS() : Boolean
        {
            return false;
        }
        
        public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
        {
        }
        
        public function setNations(nations:INations) : void
        {
        }
        
        public function toUpperOrLowerCase(string:String, isUpper:Boolean, strCaseProps:IStrCaseProperties = null) : String
        {
            return "";
        }
        
        public function willTrigger(type:String) : Boolean
        {
            return false;
        }
        
        public function get imageManager() : IImageManager
        {
            return this._imageManager;
        }
        
        public function get asserter() : IAssertable
        {
            return this._asserter;
        }
        
        public function get scheduler() : IScheduler
        {
            return this._scheduler;
        }
        
        public function get locale() : ILocale
        {
            return this._locale;
        }
        
        public function get JSON() : ISerializable
        {
            return this._JSON;
        }
        
        public function get helpLayout() : IHelpLayout
        {
            return this._helpLayout;
        }
        
        public function get classFactory() : IClassFactory
        {
            return this._classFactory;
        }
        
        public function get popupMgr() : IPopUpManager
        {
            return this._popupMgr;
        }
        
        public function get commons() : ICommons
        {
            return this._commons;
        }
        
        public function get nations() : INations
        {
            return this._nations;
        }
        
        public function get focusHandler() : IFocusHandler
        {
            return this._focusHandler;
        }
        
        public function get events() : IEventCollector
        {
            return this._events;
        }
        
        public function get IME() : IIME
        {
            return this._IME;
        }
        
        public function get voMgr() : IVOManager
        {
            return this._voMgr;
        }
        
        public function get icons() : IIcons
        {
            return this._icons;
        }
        
        public function get styleSheetManager() : IStyleSheetManager
        {
            return this._styleSheetManager;
        }
        
        public function get tweenAnimator() : ITweenAnimator
        {
            return this._tweenAnimator;
        }
        
        public function get animBuilder() : IAnimBuilder
        {
            return this._animBuilder;
        }
        
        public function get dateTime() : IDateTime
        {
            return this._dateTime;
        }
        
        public function get poolManager() : IPoolManager
        {
            return null;
        }
        
        public function get data() : IDataUtils
        {
            return this._dataUtils;
        }
        
        public function dispatchEvent(event:Event) : Boolean
        {
            return false;
        }
    }
}
