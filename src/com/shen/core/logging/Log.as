package com.shen.core.logging {

	import flash.external.ExternalInterface;
	import flash.utils.getQualifiedClassName;
	
	public class Log {
		
		public static const NO_LOG:uint 		= 0;
		public static const BROWSER_LOG:uint 	= 1;
		public static const CONSOLE_LOG:uint 	= 2;
		public static const BOTH_LOG:uint 		= 3;
		
		public static var type:int = NO_LOG;
		
		private static var jsTested:Boolean;
		private static var jsAvailable:Boolean;
		
		public static function debug(obj:Object, msg:String):void {
			var qualifiedClassName:String = getQualifiedClassName(obj);
			qualifiedClassName = qualifiedClassName.replace("::", ".");
			
			var str:String = "[debug] [" + qualifiedClassName + "] [* " + msg + " *]";
			if(type == BROWSER_LOG) {
				if(ExternalInterface.available) {
					if(!jsTested) {
						jsTested = true;
						try {
							jsAvailable = ExternalInterface.call("function(){return true;}");	
						}catch(e:SecurityError) {
							jsAvailable = false;	
						}	
					}
					if(jsAvailable) {
						ExternalInterface.call("console.log", str);	
					}else {
						return;	
					}
				}else {
					return;
				}
			} else if(type == CONSOLE_LOG) {
				trace(str);
			}
		}
		
		public function Log() {
			throw new TypeError("Log 不是构造函数。")
		}
		
	}
}

