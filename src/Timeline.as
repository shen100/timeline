package
{
	import caurina.transitions.Tweener;
	
	import com.shen.timeline.ApplicationFacade;
	import com.shen.timeline.view.ui.DetailView;
	import com.shen.timeline.view.ui.TimeBox;
	import com.shen.uicomps.components.Button;
	import com.shen.uicomps.components.SkinnableComponent;
	import com.shen.uicomps.components.skin.ButtonSkin;
	import com.shen.uicomps.components.skin.Skin;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import com.shen.timeline.assets.BackgroundAsset;
	import com.shen.timeline.assets.PrevArrowsAsset;
	import com.shen.timeline.assets.FullButtonAsset;
	import com.shen.timeline.assets.SourceButtonAsset;
	import com.shen.timeline.assets.NextArrowsAsset;
	
	public class Timeline extends Sprite {
		
		public static const LOAD_TIMELINE:String = "loadTimeline";
		
		private const NAME:String = "TimelineFacade";
		
		private var moveDistance:Number;
		private var moveLock:Boolean;
		private var background:SkinnableComponent;
		private var left:Button;
		private var right:Button;
		
		public var timeBox:TimeBox;
		private var timeBoxStartDragX:Number;
		
		private var fullButton:Button;
		private var source:Button;	//溯源

		public var detailView:DetailView;
		private var facade:ApplicationFacade = ApplicationFacade.getInstance( NAME );
		
		private var _isEnd:Boolean;
		
		public function Timeline() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
		}
		
		public function get isEnd():Boolean
		{
			return _isEnd;
		}

		public function set isEnd(value:Boolean):void
		{
			_isEnd = value;
		}

		private function onAddedToStage(event:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.RESIZE, onResize);
			background = new SkinnableComponent();
			background.skin = new Skin(new BackgroundAsset());
			addChild(background);
			
			timeBox = new TimeBox();
			addChild(timeBox);
			
			left = new Button();
			left.skin = new ButtonSkin(new PrevArrowsAsset());
			//addChild(left);
			left.visible = false;
			
			right = new Button();
			right.skin = new ButtonSkin(new NextArrowsAsset());
			//addChild(right);
			
			fullButton = new Button();
			fullButton.skin = new ButtonSkin(new FullButtonAsset());
			fullButton.label = "全屏";
			addChild(fullButton);
			
			source = new Button();
			source.skin = new ButtonSkin(new SourceButtonAsset());
			source.label = "溯源";
			addChild(source);
			
			onResize();
			
			left.addEventListener(MouseEvent.CLICK, 	onLeftClick);
			right.addEventListener(MouseEvent.CLICK, 	onRightClick);
			fullButton.addEventListener(MouseEvent.CLICK, onFullButtonClick);
			source.addEventListener(MouseEvent.CLICK,   onSourceClick);
			background.addEventListener(MouseEvent.MOUSE_DOWN, onBgMouseDown);
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, onFullScreen);
			facade.startup(this);
		}
		
		private function onFullScreen(event:FullScreenEvent):void {
			if(stage.displayState == StageDisplayState.FULL_SCREEN) {
				fullButton.label = "退出";		
			}else if(stage.displayState == StageDisplayState.NORMAL) {
				fullButton.label = "全屏";
			}
		}
		
		private function onBgMouseDown(event:MouseEvent):void {
			timeBoxStartDragX = timeBox.x;
			var offset:Number = stage.stageWidth / 2;
			var bounds:Rectangle = new Rectangle(timeBoxStartDragX - offset, timeBox.y, 2 * offset, 0);
			timeBox.startDrag(false, bounds);
			stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
		}
		
		private function onStageMouseUp(event:MouseEvent):void {
			timeBox.stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);	
		
			if(Math.abs(timeBox.x - timeBoxStartDragX) < 30) {
				Tweener.addTween(timeBox, {x:timeBoxStartDragX, time:0.3});
				return;
			}
			
			if(timeBox.x > timeBoxStartDragX) {
				if(timeBox.x > 0) {
					Tweener.addTween(timeBox, {x:0, time:0.3});	
				}else {
					onLeftClick();	
				}
			}else {
				if(isEnd && timeBox.x + timeBox.width < stage.stageWidth) {
					var targetX:Number = stage.stageWidth - timeBox.width;
					targetX = targetX > 0 ? targetX : 0;
					Tweener.addTween(timeBox, {x:targetX, time:0.3});
				}else {
					onRightClick();	
				}
			}
			
		}
		
		private function onFullButtonClick(event:MouseEvent):void
		{
			if(stage && stage.displayState == StageDisplayState.FULL_SCREEN) {
				stage.displayState = StageDisplayState.NORMAL;
				fullButton.label = "全屏";
			}else {
				stage.displayState = StageDisplayState.FULL_SCREEN;
				fullButton.label = "退出";
			}
		}
		
		private function onSourceClick(event:MouseEvent):void
		{
			if(moveLock) {
				return;	
			}
			var complete:Function = function():void 
			{
				right.visible = true;
				moveLock = false;	
				if(timeBox.x >= 0) {
					left.visible = false;	
				}
				if(timeBox) {
					timeBox.highlightSourceMbItem();	
				}
			};
			if(timeBox.x < 0) {
				moveLock = true;
				Tweener.addTween(timeBox, {x:0, time:0.5, transition:"easeOutCubic", onComplete:complete});	
			}else {
				if(timeBox) {
					timeBox.highlightSourceMbItem();	
				}	
			}
		}
		
		private function onLeftClick(event:MouseEvent=null):void {
			if(moveLock) {
				return;	
			}
			var complete:Function = function():void 
			{
				right.visible = true;
				moveLock = false;	
				if(timeBox.x >= 0) {
					left.visible = false;	
				}
			};
			if(timeBox.x < 0) {
				moveLock = true;
				var targetX:Number = timeBox.x + moveDistance;
				if(targetX > 0) {
					targetX = 0;	
				}
				Tweener.addTween(timeBox, {x:targetX, time:0.5, transition:"easeOutCubic", onComplete:complete});	
			}
		}
		
		private function onRightClick(event:MouseEvent=null):void {
			if(moveLock) {
				return;
			}
			var complete:Function = function():void 
			{
				moveLock = false;
				if(timeBox.width  > stage.stageWidth) {
					left.visible = true;	
				}
			};
			
			if(timeBox.x + timeBox.width  < stage.stageWidth) {
				moveLock = false;
				dispatchEvent(new Event(Timeline.LOAD_TIMELINE));
			}else {
				moveLock = true;
				Tweener.addTween(timeBox, {x:timeBox.x - moveDistance, time:0.5, transition:"easeOutCubic", onComplete:complete});
				if(timeBox.x + timeBox.width - moveDistance  < stage.stageWidth) {
					dispatchEvent(new Event(Timeline.LOAD_TIMELINE));
				}
			}
		}
		
		public function hideRightButton():void {
			right.visible = false;	
		}
		
		public function createDetailView():void {
			detailView = new DetailView();
			addChild(detailView);
			addChild(fullButton);
			detailView.setSize(stage.stageWidth, stage.stageHeight);
		}
		
		public function destroyDetailView():void {
			if(detailView && contains(detailView)) {
				removeChild(detailView);	
			}
			detailView = null;
		}
	
		private function onResize(event:Event=null):void {
			source.x = fullButton.width + 1;
			moveDistance = stage.stageWidth / 2;
			background.width = stage.stageWidth;
			background.height = stage.stageHeight;

			timeBox.setSize(stage.stageWidth, stage.stageHeight);
			timeBox.y = stage.stageHeight / 2;
			left.x = left.width / 2;
			left.y = stage.stageHeight / 2;
		
			right.x = (stage.stageWidth - right.width / 2);
			right.y = stage.stageHeight / 2;
			
			if(detailView) {
				detailView.setSize(stage.stageWidth, stage.stageHeight);
			}
		}
	}
}




























