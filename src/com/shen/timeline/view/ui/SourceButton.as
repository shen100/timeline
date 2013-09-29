package com.shen.timeline.view.ui
{
	import com.shen.uicomps.components.Label;
	import com.shen.uicomps.components.SkinnableComponent;
	import com.shen.uicomps.components.skin.Skin;
	
	import flash.display.Sprite;

	public class SourceButton extends Sprite
	{
		private var bg:SkinnableComponent;
		private var label:Label;
		
		public function SourceButton()
		{
			this.buttonMode = true;
			bg = new SkinnableComponent();
			bg.skin = new Skin(new SourceAsset());
			addChild(bg);
			
			label = new Label();
			label.text = "溯源";
			label.textColor = 0xFFFFFF;
			addChild(label);
			label.x = - label.width / 2;
			label.y = - label.height / 2;
		}
	}
}





