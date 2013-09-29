package com.shen.timeline.view.ui
{
	import com.shen.timeline.assets.MicroBlogItemContentBgAsset;
	import com.shen.uicomps.components.Label;
	import com.shen.uicomps.components.SkinnableComponent;
	import com.shen.uicomps.components.skin.Skin;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class MicroBlogContent extends Sprite
	{
		private var titleX:Number = 15;
		private var titleY:Number = 6;
		private var gap:Number = 5;
		private var textWidth:Number = 175;
		
		private var bg:SkinnableComponent;
		private var title:Label;
		private var content:TextField;
		
		public function MicroBlogContent(data:Object)
		{
			bg = new SkinnableComponent();
			bg.skin = new Skin(new MicroBlogItemContentBgAsset());
			addChild(bg);
			bg.width = data.width;
			
			title = new Label();
			title.text = data.title;
			//title.fontFamily = "Microsoft YaHei";
			title.fontFamily = "宋体";
			title.textSize = 12;
			title.textColor = 0x006A92;
			addChild(title);
			title.x = titleX;
			title.y = titleY;
			
			var format:TextFormat = new TextFormat();
			format.leading = 8;
			format.letterSpacing = 1;
			format.size = 12;
			//format.font = "Microsoft YaHei";
		    format.font = "SimSun";
			format.color = 0x333333;
			content = new TextField();
			content.selectable = false;
			content.width = textWidth;
			content.autoSize = TextFieldAutoSize.LEFT;
			content.wordWrap = true;
			content.multiline = true;
			content.defaultTextFormat = format;
			content.text = data.content;
			addChild(content);
		
			draw();
		}
		
		private function draw():void
		{
			content.x = titleX;
			content.y = title.y + title.height + gap;
			bg.height = content.y + content.height + gap;
		}
	}
}


















