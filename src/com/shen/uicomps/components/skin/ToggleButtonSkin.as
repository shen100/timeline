package com.shen.uicomps.components.skin {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class ToggleButtonSkin extends Sprite {
		
		private var _asset:MovieClip;
		private var selected:MovieClip;
		
		public function ToggleButtonSkin(asset:MovieClip = null) {
			mouseChildren = false;
			this.asset = asset;
		}
	
		public function set asset(value:MovieClip):void {
			if(value) {
				if(_asset) {
					removeChild(_asset.onAsset);
					removeChild(_asset.offAsset);		
				}
				_asset = value;
				value.offAsset.y = 0;
				addChild(value.onAsset);
				addChild(value.offAsset);
				selected = value.onAsset;
				value.offAsset.visible = false;	
			}
		}
	
		public function up():void {
			selected.gotoAndStop("up");
		}
		
		public function over():void {
			selected.gotoAndStop("over");
		}
		
		public function down():void {
			selected.gotoAndStop("down");	
		}
		
		public function disable():void {
			selected.gotoAndStop("disabled");	
		}
		
		public function click():void {
			if(selected == _asset.onAsset) {
				selected = _asset.offAsset; 	
				_asset.onAsset.visible = false;
			}else {
				selected = _asset.onAsset; 	
				_asset.offAsset.visible = false;
			}
			selected.gotoAndStop("over");
			selected.visible = true;
		}
	}
}















