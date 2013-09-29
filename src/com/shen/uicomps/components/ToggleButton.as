package com.shen.uicomps.components {
	
	import com.shen.uicomps.components.skin.ToggleButtonSkin;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	public class ToggleButton extends Sprite {
		
		public static const TOGGLE:String = "toggle";
		
		private var _skin:ToggleButtonSkin;
		private var _currentState:String;
		private var _disabled:Boolean;
		private var _isOn:Boolean = true;
		
		public function ToggleButton() {
			buttonMode = true;
		}

		public function get skin():ToggleButtonSkin {
			return _skin;
		}
		
		public function set skin(toggleButtonSkin:ToggleButtonSkin):void {
			if(_skin) {
				removeChild(_skin);	
			}
			_skin = toggleButtonSkin;
			addChild(_skin);
			addEventListener(MouseEvent.ROLL_OVER, 	onRollOver);	
			addEventListener(MouseEvent.ROLL_OUT,  	onRollOut);	
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP,   onMouseUp);
			addEventListener(MouseEvent.CLICK,   	onClick);
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
		
		private function onClick(event:MouseEvent):void {
			_isOn = !_isOn;
			currentState = "click";
			dispatchEvent(new Event(ToggleButton.TOGGLE));
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
						case "click":{
							_skin.click();
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
					removeEventListener(MouseEvent.CLICK,   	onClick);
					currentState = "disabled";
					mouseEnabled = false;
					mouseChildren = false;
				}else {
					addEventListener(MouseEvent.ROLL_OVER, 	onRollOver);	
					addEventListener(MouseEvent.ROLL_OUT,  	onRollOut);	
					addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
					addEventListener(MouseEvent.MOUSE_UP,   onMouseUp);
					addEventListener(MouseEvent.CLICK,   	onClick);
					mouseEnabled = true;
					mouseChildren = true;
				}
			}
		}
		
		public function get isOn():Boolean {
			return _isOn;
		}
		
		public function set isOn(value:Boolean):void {
			if(_isOn != value) {
				_isOn = value;
				var beforeState:String = currentState;
				_currentState = "click";
				if(_skin) {
					_skin.click();
				}
				currentState = beforeState;
			}	
		}
		
		
	}
}












