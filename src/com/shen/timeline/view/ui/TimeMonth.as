package com.shen.timeline.view.ui
{
	import com.shen.uicomps.components.Label;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class TimeMonth extends Sprite
	{
		private var bgColor:uint = 0x388302;
		private var bgWidth:Number = 80;
		private var bgHeight:Number = 50;
		private var bg:Shape;
		private var label:Label;
		
		public function TimeMonth(data:Object)
		{
			bg = new Shape();
			addChild(bg);
			bg.graphics.beginFill(bgColor);
			bg.graphics.drawRect(0, 0, bgWidth, bgHeight);
			bg.graphics.endFill();
			
			label = new Label();
			label.textColor = 0xFFFFFF;
			label.textSize = 20;
			label.fontFamily = "Microsoft YaHei";
			label.text = data.month + "月";
			addChild(label);
			label.x = (width - label.width) / 2;
			label.y = (height - label.height) / 2;
		}
	}
}














