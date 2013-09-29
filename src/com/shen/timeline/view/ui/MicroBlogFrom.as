package com.shen.timeline.view.ui
{
	import com.shen.core.geom.Size;
	import com.shen.core.util.Util;
	import com.shen.uicomps.components.Image;
	import com.shen.uicomps.components.Label;
	import com.shen.uicomps.components.SkinnableComponent;
	import com.shen.uicomps.components.skin.Skin;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;

	public class MicroBlogFrom extends Sprite
	{
		private var fromX:Number = 15;
		
		private var fromBg:Shape;
		private var logo:Image;
		private var from:Label;
		
		public function MicroBlogFrom(data:Object)
		{
			fromBg = new Shape();
			fromBg.graphics.beginFill(data.color);
			fromBg.graphics.drawRect(0, 0, data.width, data.height);
			fromBg.graphics.endFill();
			addChild(fromBg);
			
			from = new Label();
			from.textColor = 0xFFFFFF;
			from.text = data.from;
			addChild(from);
			if(data.logo) {
				logo = new Image();
				addChild(logo);
				logo.addEventListener(Image.LOAD_RESULT, onImageResult);
				logo.source = data.logo;
				from.x = fromX + fromBg.height;
			}else {
				from.x = fromX;	
			}
		}
		
		private function onImageResult(event:Event):void {
			var size:Size = Util.scaleToMax(logo.originalWidth, logo.originalHeight, fromBg.height - 2, fromBg.height - 2);
			logo.width = size.width;
			logo.height = size.height;
			logo.x = fromX;
			logo.y = (fromBg.height - logo.height) / 2;
		}
	}
}