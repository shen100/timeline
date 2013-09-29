package com.shen.uicomps.components {
	
	import com.shen.uicomps.components.skin.ButtonSkin;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Button extends Sprite {
		
		private var _label:Label;
		private var _skin:ButtonSkin;
		private var _currentState:String;
		private var _disabled:Boolean;
		
		public function Button() {
			buttonMode = true;
		}
		
		public function get skin():ButtonSkin {
			return _skin;
		}
		
		public function set skin(buttonSkin:ButtonSkin):void {
			if(_skin) {
				removeChild(_skin);	
			}
			_skin = buttonSkin;
			addChild(_skin);
			addEventListener(MouseEvent.ROLL_OVER, 	onRollOver);	
			addEventListener(MouseEvent.ROLL_OUT,  	onRollOut);	
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP,   onMouseUp);
		}
		
		private function onRollOver(event:MouseEvent):void {
			currentState = "over";
		}
		
		private function onRollOut(event:MouseEvent):void {
			currentState = "up";
		}
		
		private function onMouseDown(event:MouseEvent):void {
			currentState = "down";
		}
		
		private function onMouseUp(event:MouseEvent):void {
			currentState = "over";	
		}
		
		public function get currentState():String {
			return _currentState;
		}
		
		public function set currentState(value:String):void {
			if(_currentState != value) {
				_currentState = value;
				if(_skin) {
					switch(_currentState) {
						case "over":{
							_skin.over();
							break;
						}
						case "up":{
							_skin.up();
							break;
						}
						case "down":{
							_skin.down();
							break;
						}
						case "disabled":{
							_skin.disable();
							break;
						}
					}
				}
			}
		}
		
		public function get disabled():Boolean {
			return _disabled;
		}
		
		public function set disabled(value:Boolean):void {
			if(_disabled != value) {
				_disabled = value;	
				if(_disabled) {
					removeEventListener(MouseEvent.ROLL_OVER, 	onRollOver);	
					removeEventListener(MouseEvent.ROLL_OUT,  	onRollOut);	
					removeEventListener(MouseEvent.MOUSE_DOWN, 	onMouseDown);	
					removeEventListener(MouseEvent.MOUSE_UP,   	onMouseUp);
					currentState = "disabled";
					mouseEnabled = false;
					mouseChildren = false;
				}else {
					addEventListener(MouseEvent.ROLL_OVER, 	onRollOver);
					addEventListener(MouseEvent.ROLL_OUT,  	onRollOut);	
					addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
					addEventListener(MouseEvent.MOUSE_UP,   onMouseUp);
					mouseEnabled = true;
					mouseChildren = true;
				}
			}
		}
		
		public function set label(value:String):void {
			if(!_skin.label) {
				if(!_label) {
					_label = new Label();	
				}
				addChild(_label);
				_label.textColor = 0xFFFFFF;
				_label.textSize = 14;
				_label.text = value;
				_label.x = (_skin.width - _label.width) / 2;
				_label.y = (_skin.height - _label.height) / 2;
			}else {
				_skin.label = value;	
			}
		}
		
		public function set textSize(value:Object):void {
			_label.textSize = value;
			_label.x = (_skin.width - _label.width) / 2;
			_label.y = (_skin.height - _label.height) / 2;
		}
		
		override public function set width(value:Number):void
		{
			_skin.width = value;	
		}
		
		override public function set height(value:Number):void {
			_skin.height = value;	
		}
	}
}





