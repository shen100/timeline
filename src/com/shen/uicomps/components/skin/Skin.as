package com.shen.uicomps.components.skin {
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Skin extends Sprite {
		
		private var _asset:DisplayObject;
		
		public function Skin(asset:DisplayObject = null) {
			mouseChildren = false;
			this.asset = asset;
		}
		
		public function get asset():DisplayObject {
			return _asset;
		}
		
		public function set asset(value:DisplayObject):void {
			if(value) {
				if(_asset != null) {
					removeChild(_asset);	
				}
				_asset = value;
				addChild(_asset);	
			}
		}
		
	}
}














