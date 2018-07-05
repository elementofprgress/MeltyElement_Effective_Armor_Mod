class net.GPCracker.DemoBattleFlash.BaseClass extends MovieClip
{
	//	There are two methods of object creation. One is often used in Adobe Flash (or Macromedia Flash). You create
	//		object in Flash, then you set his base class. Second approach is creation of object via class constructor,
	//		by ActionScript, in other words. Anyway, you extension class may have children or other properties undeclared
	//		in parent class. If you want to access them from your class, you should declare them in this class. However,
	//		you declare and define them in second approach anyway, you should declare them and left them undefined 
	//		if you are using first approach. In different editors first approach may be done different ways
	//		(e.g. Flash Develop and Adobe/Macromedia Flash), but class stays the same.
	//	You can also extend other class, e.g. TextField, but object, used as class instance, must be an instance of parent
	//		class. In other words, you extend object class.
	//	Note that you can use ANY object for DAAPI bridge, and there can be more than one DAAPI bridge in one flash.
	//	The main AS2 critical disappointing difference with AS3 is absence of document class. It forces us to use an any
	//		other object for DAAPI bridge. However, there is a way to set flash document class via changing main MovieClip
	//		prototype and manual constructor call, but I am not sure that this trick will work with DAAPI correctly.
	//		Anyway, you can try to use AS3 instead of AS2 on your own risk, I don't see any obvious reasons it won't work
	//		correct for standalone flash, but I am not sure (it doesn't mean that you should believe my words with no check)
	//		it will work with AS2-based battleWindow correct.
	
	// Flash have document size, but we can move element through all the screen. You should set document size based on
	//		your elements, not target screen size.
	
	//	Python-implemented methods that should be overloaded.
	var DAAPIMethods:Array = ["py_daapiMethod"];
	
	//	This is a child object, added by Flash. We should declare this to get access to it, but we MUST NOT define it if
	//		object is not being constructed by ActionScript.
	var textField:TextField;
	
	//	This is a class constructor. Here we do additional actions we want to do on this stage. But do not forget to call
	//		parent class constructor by super() first.
	function BaseClass()
	{
		super();
		
		//	Here we enable some methods of our class to be overloaded by Python methods. This function sets Read-Write flags.
		//	Function is undocumented, however you can find its description on side resources.
		//	WARNING: This is AS2-only function, I have not found it in AS3... Here algorithm of sharing slots for Python
		//		methods will differs, I don't have enough info about it, however I think (you gotta check it, if you want
		//		to use AS3) you can just skip this step. At least, I have not seen such function in AS3 hangar flashes, but
		//		Python functions work there correct.
		//	WARNING: Python class methods MUST have the same names as ActionScript slots.
		_global.ASSetPropFlags(this.__proto__, this.DAAPIMethods, 6, 1);
		
		//	By default Scaleform scale our SWF to screen size. We can use this to prevent it. See documentation for details.
		//	Maybe, you don't need this for UI flashes.
		Stage.scaleMode = "noScale";
		
		//	We can set an align of our Flash. See documentation for details.
		//	Maybe, you don't need this for UI flashes.
		Stage.align = "TL";
		
		return;
	}
	
	//	This function is often used to debug flash elements, however you can use it on your own.
	function onLoad():Void
	{
		trace("BaseClass loaded.");
		return;
	}
	
	//	This is a Python DAAPI method placeholder.
	//	You can define it as property (variable) of function type, like
	//		var py_daapiMethod:Function;
	//	or define it as a dummy function, like
	function py_daapiMethod(number:Number, string:String, array:Array):Number
	{
		//	It is a dummy method, it will never be called if overload was success.
		//	Otherwise, we gotta log it.
		net.wargaming.utils.DebugUtils.LOG_WARNING("Python did not override net.GPCracker.DemoBattleFlash.BaseClass.py_daapiMethod flash method.");
		return;
	}
	
	//	Note, that DAAPI methods can return something or nothing. You can use it on your own.
	
	//	Note, that py_ and as_ prefixes are not strictly required, I use them to differ DAAPI methods from other class methods.
	//	This is only a comment-like trick, helping to understand code and may be used instead of comments.
	//	Nothing except your understanding based on this prefixes.
	
	//	This is an ActionScript DAAPI method. We will call it from Python, but it is still a simple ActionScript method.
	function as_daapiMethod(number:Number, string:String, array:Array):Number
	{
		//	Note, that py_daapiMethod differs from other methods only by Python implementation, nothing more.
		//	We can call it anywhere in your ActionScript code. However, you will never do this, I use it for example
		//		because I don't want to make interface in my flash, I just want to show how DAAPI works.
		//	You can write your code here, for example I will return a sum like
		net.wargaming.utils.DebugUtils.LOG_WARNING("as_daapiMethod was called");
		return number + string.length + array.length + this.py_daapiMethod(14, "abc", [1, 4]);
	}
	
	//	Note, that you are not forced to use both of this methods. You can use several ActionScript DAAPI methods
	//	with no Python DAAPI methods or vice versa as well.
}
