package com.shen.uicomps.components
{
	import com.shen.uicomps.components.skin.RadioButtonSkin;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class RadioButton extends Sprite {
		
		public static const UP:String 			= "up";
		public static const OVER:String 		= "over";
		public static const DOWN:String 		= "down";
		public static const SELECT:String 		= "select";
		public static const UN_SELECT:String 	= "unSelect";
		
		private static var buttons:Array;
		
		private var _selected:Boolean = false;
		private var _groupName:String = "defaultRadioButtonGroup";
		
		private var _skin:RadioButtonSkin;
		private var _currentState:String;
		
		public function RadioButton(groupName:String = "defaultRadioButtonGroup", checked:Boolean = false, defaultHandler:Function = null)
		{
			RadioButton.addButton(this);
			_groupName = groupName;
			_selected = checked;
			buttonMode = true;
			
			addEventListener(MouseEvent.CLICK, onClick);
		
			if(defaultHandler != null) {
				addEventListener(MouseEvent.CLICK, defaultHandler);
			}
		}
		
		private static function addButton(rb:RadioButton):void {
			if(buttons == null)
			{
				buttons = new Array();
			}
			buttons.push(rb);
		}
		
		private static function clear(rb:RadioButton):void {
			for(var i:uint = 0; i < buttons.length; i++)
			{
				if(buttons[i] != rb && buttons[i].groupName == rb.groupName)
				{
					buttons[i].selected = false;
				}
			}
		}
		
		public function get skin():RadioButtonSkin {
			return _skin;
		}
		
		public function set skin(radioButtonSkin:RadioButtonSkin):void {
			if(_skin) {
				removeChild(_skin);	
			}
			_skin = radioButtonSkin;
			addChild(_skin);
			
			if(selected) {
				currentState = RadioButton.SELECT;
			}else {
				currentState = RadioButton.UN_SELECT;	
			}
			addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
		}
		
		
		private function onMouseOver(event:MouseEvent):void
		{
			addEventListener(MouseEvent.ROLL_OUT, onMouseOut);
			if(selected == false) {
				currentState = RadioButton.OVER;
			}
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
			if(selected == false) {
				currentState = RadioButton.UP;
			}
		}
		
		protected function onClick(event:MouseEvent):void {
			selected = true;
		}
		
		public function set selected(s:Boolean):void {
			var lastSelected:Boolean = _selected;
			_selected = s;
			if(_selected) {
				currentState = RadioButton.SELECT;
				RadioButton.clear(this);
			}else {
				if(lastSelected) {
					currentState = RadioButton.UP;
				}
			}
		}
		
		public function get selected():Boolean {
			return _selected;
		}
		
		public function get groupName():String {
			return _groupName;
		}
		
		public function get currentState():String {
			return _currentState;
		}
		
		public function set currentState(value:String):void {
			if(_currentState != value) {
				_currentState = value;
				if(_skin) {
					switch(_currentState) {
						case RadioButton.OVER:{
							_skin.over();
							break;
						}
						case RadioButton.UP:{
							_skin.up();
							break;
						}
						case RadioButton.SELECT:{
							_skin.select();
							break;
						}
						case RadioButton.UN_SELECT:{
							_skin.unSelect();
							break;
						}
					}
				}
			}
		}
	}
}








