package com.shen.timeline.view.ui
{
	import caurina.transitions.Tweener;
	
	import com.shen.timeline.assets.DownBubbleAsset;
	import com.shen.timeline.assets.DownPointerAsset;
	import com.shen.timeline.assets.UpBubbleAsset;
	import com.shen.timeline.assets.UpPointerAsset;
	import com.shen.timeline.model.vo.MicroBlogVO;
	import com.shen.uicomps.components.SkinnableComponent;
	import com.shen.uicomps.components.skin.Skin;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;

	public class MicroBlogItem extends Sprite
	{
		private var initWidth:Number = 205;	//宽度
		private var fromHeight:Number = 18;	//来源高度
		private var pointerX:Number = 20;
		
		private var from:MicroBlogFrom;
		private var mbContent:MicroBlogContent;
		private var pointer:SkinnableComponent;
		private var bubble:SkinnableComponent;
		private var container:Sprite;
		
		private var dropFilter:DropShadowFilter;
		
		public var year:int;
		public var month:int;
		public var day:int;
		public var isUp:Boolean;
		public var isSource:Boolean;
		
		public function MicroBlogItem(data:MicroBlogVO)
		{
			this.buttonMode = true;
			this.mouseChildren = false;
			year = data.year;
			month = data.month;
			day = data.day;
			isUp = data.isUp;
			isSource = data.isSource;
			var fromData:Object = {};
			fromData.width = initWidth;
			fromData.height = fromHeight;
			fromData.color = data.fromBgColor;
			fromData.from = data.from;
			fromData.logo = data.logo;
			from = new MicroBlogFrom(fromData);
			
			var contentData:Object = new Object();
			contentData.width   = initWidth;
			contentData.title 	= data.title;
			contentData.content = data.content;
			mbContent = new MicroBlogContent(contentData);
			
			pointer = new SkinnableComponent();
			pointer.x = pointerX;

			if(isUp) {
				pointer.skin = new Skin(new UpPointerAsset());
			}else {
				pointer.skin = new Skin(new DownPointerAsset());
			}
			
			container = new Sprite();
			addChild(container);
			container.addChild(mbContent);
			container.addChild(from);
			container.addChild(pointer);
			container.alpha = 0;
		
			dropFilter = new DropShadowFilter(3, 45, 0x666666, 5, 5);
			
			this.filters = [dropFilter];
			
			draw();
		}
		
		public function playAnimation(x:Number, y:Number, delay:Number):void {
			bubble = new SkinnableComponent();
			if(isUp) {
				bubble.skin = new Skin(new UpBubbleAsset());	
			}else {
				bubble.skin = new Skin(new DownBubbleAsset());
			}
			addChild(bubble);	
			bubble.x = x;
			bubble.y = y;
			Tweener.addTween(bubble, {x:0, y:0, time:0.8, delay:delay, transition:"easeOutQuint", onComplete:onAnimationComplete, onCompleteParams:[bubble]});
		}
		
		private function onAnimationComplete(bubble:SkinnableComponent):void {
			if(this.contains(bubble)) {
				removeChild(bubble);
			}
			container.width = 30;
			container.scaleY = container.scaleX;
			Tweener.addTween(container, {alpha:1, scaleX:1, scaleY:1, time:0.3}); 
		}
		
		private function draw(event:Event=null):void
		{
			if(isUp) {
				mbContent.y = from.height - 1;
				pointer.y = mbContent.y + mbContent.height - 1;
			}else {
				mbContent.y = pointer.height - 1;
				from.y = mbContent.y + mbContent.height - 2;
			}
		}
	}
}




















