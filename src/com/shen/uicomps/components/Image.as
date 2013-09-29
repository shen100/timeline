package com.shen.uicomps.components {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	public class Image extends Sprite {
		
		public static const LOAD_RESULT:String 	= "loadResult";
		public static const LOAD_FAULT:String 	= "loadFault";
		
		private var _originalWidth:Number = 0;		//原图宽度
		private var _originalHeight:Number = 0;		//原图高度
		private var _smoothing:Boolean;
		private var loader:Loader;
		private var bitmap:Bitmap;
		private var _bitmapData:BitmapData;
		
		public function Image() {
			
		}
		
		public function set source(url:String):void {
			clear();
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);	
			var request:URLRequest = new URLRequest();
			request.url = url;
			loader.load(request);
			addChild(loader);
		}
		
		private function onComplete(event:Event):void {
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_originalWidth = loader.width;
			_originalHeight = loader.height;
			try {
				if(loader.content is Bitmap) {
					_bitmapData = Bitmap(loader.content).bitmapData;
				}	
			}catch(err:Error) {
				_bitmapData = null;	
			}
			if(_smoothing && bitmapData) {
				bitmap = new Bitmap(bitmapData, "auto", true);	
				addChild(bitmap);
			}
			dispatchEvent(new Event(Image.LOAD_RESULT));
		}
		
		private function onIOError(event:IOErrorEvent):void {
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);	
			trace("加载图片失败");
			dispatchEvent(new Event(Image.LOAD_FAULT));
		}
	
		public function set smoothing(value:Boolean):void {
			if(_smoothing != value) {
				_smoothing = value;	
				if(bitmapData) {
					if(bitmap) {
						if(contains(bitmap)) {
							removeChild(bitmap);	
						}
						bitmap = null;
					}
					if(_smoothing) {
						bitmap = new Bitmap(bitmapData, "auto", true);	
						addChild(bitmap);	
					}
				}
				
			}
		}
		
		public function clear():void {
			_originalWidth = 0;
			_originalHeight = 0;
			if(bitmap) {
				if(contains(bitmap)) {
					removeChild(bitmap);	
				}
				bitmap = null;
			}
			_bitmapData = null;
			if(loader) {
				try {
					loader.close();
				} catch (e:Error) {
					
				}
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
				if(contains(loader)) {
					removeChild(loader);	
				}
				loader = null;
			}	
		}
		
		public function get bitmapData():BitmapData {
			return _bitmapData;
		}
		
		public function cloneBitmapData():BitmapData {
			var data:BitmapData;
			if(_bitmapData) {
				data = _bitmapData.clone();		
			}
			return data;
		}
		
		public function get originalWidth():Number {
			return _originalWidth;
		}
		
		public function get originalHeight():Number {
			return _originalHeight;
		}
		
	}
}














