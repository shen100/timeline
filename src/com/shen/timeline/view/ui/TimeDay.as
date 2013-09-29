package  com.shen.timeline.view.ui
{
	import com.shen.timeline.assets.TimelineDayBgAsset;
	import com.shen.timeline.model.vo.SimpleDate;
	import com.shen.uicomps.components.Label;
	import com.shen.uicomps.components.SkinnableComponent;
	import com.shen.uicomps.components.skin.Skin;
	
	import flash.display.Sprite;
	
	public class TimeDay extends Sprite
	{
		private var background:SkinnableComponent;
		private var label:Label;
		public var year:int;
		public var month:int;
		public var day:int;
		
		public function TimeDay(date:SimpleDate)
		{
			this.buttonMode = true;
			background = new SkinnableComponent();
			background.skin = new Skin(new TimelineDayBgAsset());
			addChild(background);
			
			year = date.year;
			month = date.month;
			day = date.day;
			
			label = new Label();
			label.textColor = 0xFFFFFF;
			label.textSize = 18;
			label.fontFamily = "Microsoft YaHei";
			label.text = date.month + "月" + day + "日";
			addChild(label);
			label.x = (width - label.width) / 2;
			label.y = (height - label.height) / 2;
		}
	}
}














