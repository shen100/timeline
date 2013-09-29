package com.shen.uicomps.components.skin
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class RadioButtonSkin extends Sprite
	{	
		private var _asset:MovieClip;
		
		public function RadioButtonSkin(asset:MovieClip = null) {
			mouseChildren = false;
			this.asset = asset;
		}
		
		public function set asset(value:MovieClip):void {
			if(value) {
				if(_asset != null) {
					removeChild(_asset);	
				}
				_asset = value;
				addChild(_asset);	
			}
		}
		
		public function get asset():MovieClip {
			return _asset;
		}
		
		public function up():void {
			_asset.gotoAndStop("up");
		}
		
		public function over():void {
			_asset.gotoAndStop("over");
		}
		
		public function select():void {
			_asset.gotoAndStop("select");	
		}
		
		public function unSelect():void {
			_asset.gotoAndStop("un_select");	
		}
	}
}








