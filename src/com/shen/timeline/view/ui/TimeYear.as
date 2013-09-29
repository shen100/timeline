package com.shen.timeline.view.ui
{
	import com.shen.uicomps.components.Label;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class TimeYear extends Sprite
	{
		private var bgColor:uint = 0x388302;
		private var bgWidth:Number = 114;
		private var bgHeight:Number = 50;
		private var bg:Shape;
		private var year:Label;
		
		public function TimeYear(data:Object)
		{
			bg = new Shape();
			addChild(bg);
			bg.graphics.beginFill(bgColor);
			bg.graphics.drawRect(0, 0, bgWidth, bgHeight);
			bg.graphics.endFill();
			
			year = new Label();
			year.textColor = 0xFFFFFF;
			year.textSize = 20;
			year.fontFamily = "Microsoft YaHei";
			year.text = data.year;
			addChild(year);
			year.x = (width - year.width) / 2;
			year.y = (height - year.height) / 2;
		}
	}
}














