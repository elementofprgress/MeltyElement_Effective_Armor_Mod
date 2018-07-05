package net.wg.data.constants
{
    public class KeyProps
    {
        
        public static const KEY_NONE:Number = 666;
         
        private var _keyCommand:String;
        
        private var _keyName:String;
        
        public function KeyProps(_command:String = "", _name:String = "")
        {
            super();
            this.keyCommand = _command;
            this.keyName = _name;
        }
        
        public function set keyCommand(val:String) : void
        {
            this._keyCommand = val;
        }
        
        public function get keyCommand() : String
        {
            return this._keyCommand;
        }
        
        public function set keyName(val:String) : void
        {
            this._keyName = val;
        }
        
        public function get keyName() : String
        {
            return this._keyName;
        }
    }
}
