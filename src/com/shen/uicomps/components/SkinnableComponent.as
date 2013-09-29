package com.shen.uicomps.components {
	
	import com.shen.uicomps.components.skin.Skin;
	
	import flash.display.Sprite;
	
	public class SkinnableComponent extends Sprite {
		
		private var _skin:Skin;
		
		public function SkinnableComponent() {
			
		}
		
		public function get skin():Skin {
			return _skin;
		}
		
		public function set skin(value:Skin):void {
			if(_skin) {
				removeChild(_skin);	
			}
			_skin = value;
			addChild(_skin);
		}
	}
}












