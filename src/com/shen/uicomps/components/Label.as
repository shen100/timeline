package com.shen.uicomps.components
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class Label extends Sprite {
		
		private static var allFonts:Object;
		
		protected var _text:String = "";
		protected var _tf:TextField;
		
		public function Label() {
			mouseEnabled = false;
			mouseChildren = false;
			_tf = new TextField();
			_tf.selectable = false;
			_tf.mouseEnabled = false;
			_tf.autoSize = TextFieldAutoSize.LEFT;	
			addChild(_tf);
		}
		
		public function set textSize(value:Object):void {
			var textFormat:TextFormat = _tf.defaultTextFormat;
			textFormat.size = value;
			_tf.defaultTextFormat = textFormat;
			_tf.text = text;
		}
		
		public function set background(value:Boolean):void {
			_tf.background = value;
		}
		
		public function set bold(value:Object):void {
			var textFormat:TextFormat = _tf.defaultTextFormat;
			textFormat.bold = value;
			_tf.defaultTextFormat = textFormat;
			_tf.text = text;
		}
		
		public function set textColor(value:uint):void {
			var textFormat:TextFormat = _tf.defaultTextFormat;
			textFormat.color = value;
			_tf.defaultTextFormat = textFormat;
			_tf.text = _text;
		}
		
		public function set fontFamily(value:String):void {
			if(!allFonts) {
				allFonts = {};
				var fonts:Array = Font.enumerateFonts(true);
				for each (var font:Font in fonts) {
					//trace(font.fontName);
					allFonts[font.fontName] = font.fontName;
				}
			}
			var temP:* = allFonts;
			var textFormat:TextFormat = _tf.defaultTextFormat;
			
			var fontList:Array = value.split(",");
			for each (var fontName:String in fontList) {
				var the:*  = allFonts[fontName];
				if(allFonts[fontName]) {
					textFormat.font = allFonts[fontName];
					break;
				}
			}
			textFormat.font = value;
			_tf.defaultTextFormat = textFormat;
			_tf.text = _text;
		}
		
		public function set text(t:String):void {
			_text = t;
			if(_text == null){
				_text = "";
			}
			_tf.text = _text;
		}
		
		public function get text():String {
			return _text;
		}
	
		public function get textField():TextField {
			return _tf;
		}
	}
}


