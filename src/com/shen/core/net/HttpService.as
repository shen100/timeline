package com.shen.core.net {
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class HttpService {
		
		private var _result:Function;
		private var _fault:Function;
		
		public function HttpService() {
			
		}
		
		public function send(url:String):void {
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, 		onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, 	onIOError);
			var request:URLRequest = new URLRequest();
			request.url = url;
			loader.load(request);
		}
		
		private function onComplete(event:Event):void {
			var loader:URLLoader = event.target as URLLoader;
			var data:* = loader.data;
			loader.removeEventListener(Event.COMPLETE, 			onComplete);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, 	onIOError);
			loader = null;
			_result(data);
		}
		
		private function onIOError(event:IOErrorEvent):void {
			var loader:URLLoader = event.target as URLLoader;
			loader.removeEventListener(Event.COMPLETE, 			onComplete);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, 	onIOError);
			loader = null;
			_fault(event);
		}

		public function addResponder(result:Function, fault:Function):void {
			_result = result;
			_fault = fault;
			
		}
	}
}













