package com.shen.timeline.view.ui
{
	import caurina.transitions.Tweener;
	
	import com.shen.core.geom.ColorMatrix;
	import com.shen.timeline.assets.SourceMarkAsset;
	import com.shen.timeline.model.vo.MicroBlogVO;
	import com.shen.timeline.model.vo.SimpleDate;
	import com.shen.timeline.model.vo.TimelineVO;
	import com.shen.timeline.view.events.TimelineEvent;
	import com.shen.uicomps.components.SkinnableComponent;
	import com.shen.uicomps.components.skin.Skin;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.setTimeout;
	
	public class TimeBox extends Sprite {
		
		private var color:uint = 0x8FC320;
		private var theHeiht:Number = 50;
		private var theX:Number = 18;
		private var offset:Number = 24;
		private var maxHeight:Number = 0;
		private var childIndex:int;
		private var timeArray:Array;
		private var mbItemArray:Array;
		private var _ifDrag:Boolean;
		private var sourceMark:SkinnableComponent;
		//private var maxAnimationCount:int = 25;	//最多有多少条微博有动画效果
		private var sourceMbItem:MicroBlogItem;
		
		public function TimeBox()
		{
			graphics.beginFill(color);
			graphics.drawRect(0, -theHeiht / 2, theX, theHeiht);
			graphics.endFill();
			timeArray = [];
			mbItemArray = [];
			this.addEventListener(MouseEvent.CLICK, onMicroBlogItemClick);
		}
		
		private function onMicroBlogItemClick(event:MouseEvent):void {
			if(event.target is MicroBlogItem) {
				var e:TimelineEvent = new TimelineEvent(TimelineEvent.MICROBLOG_ITEM_CLICK);
				
				dispatchEvent(e);	
			}
		}
		
		public function addData(timelineVO:TimelineVO):void {
			var days:Vector.<TimeDay>  = new Vector.<TimeDay>();
			var mbRandX:Object = {};	//同一天的微博的随机x坐标
			var mbRandY:Object = {};	//同一天的微博的随机y坐标
			//添加时间
			for(var i:int = 0; i < timelineVO.dates.length; i++) {
				var date:SimpleDate = timelineVO.dates[i];
				var canAddMonth:Boolean = true;
				var index:int = timeArray.length - 1;
				
				if(timeArray.length <= 0 ||
					(timeArray.length && timeArray[index] is TimeDay && timeArray[index].year < date.year) ) {
					var yearData:Object = {};
					yearData.year = date.year;
					var year:TimeYear = new TimeYear(yearData);	
					addChild(year);
					timeArray.push(year);
					year.x = theX;	
					year.y = -year.height / 2;
					theX += year.width;	
					canAddMonth = false;
				}
				if( canAddMonth && timeArray.length && timeArray[index] is TimeDay && timeArray[index].month != date.month) {
					var monthData:Object = {};
					monthData.month = date.month;
					var month:TimeMonth = new TimeMonth(monthData);	
					addChild(month);
					timeArray.push(month);
					month.x = theX;	
					month.y = -month.height / 2;
					theX += month.width;		
				}
				var day:TimeDay = new TimeDay(date);	
				addChild(day);
				day.addEventListener(MouseEvent.CLICK, onDayClick);
				day.x = theX;
				day.y = -day.height / 2;
				theX += day.width;
				day.visible = false;
				setTimeout(function(m:TimeDay):void{m.visible = true;}, 50 * i, day);
				timeArray.push(day);
				days.push(day);
				var key:String = day.year + "-" + day.month + "-" + day.day;
				//mbRandX[key] = [0, 1, 2, 3, 4];
				//mbRandY[key] = [0, 1, 2, 3, 4];
				mbRandX[key] = [0, 1];//改为一个月最多显示2个微博
				mbRandY[key] = [0, 1];//改为一个月最多显示2个微博
			}	
		
			//添加微博
			for (var k:int = 0; k < timelineVO.microblogs.length; k++) {
				var microBlog:MicroBlogVO = timelineVO.microblogs[k];
				var microBlogItem:MicroBlogItem = new MicroBlogItem(microBlog);
				if(microBlogItem.isSource) {
					sourceMbItem = microBlogItem;	
				}
				addChildAt(microBlogItem, 0 );
				mbItemArray.push(microBlogItem);
				for (var j:int = 0; j < days.length; j++) {
					if(microBlogItem.year == days[j].year && microBlogItem.month == days[j].month 
							&& microBlogItem.day == days[j].day) {
						var theKey:String = days[j].year + "-" + days[j].month + "-" + days[j].day;
						
						var random:Number = int(Math.random() * mbRandX[theKey].length);
						microBlogItem.x = days[j].x + mbRandX[theKey][random] * offset;
						mbRandX[theKey].splice(random, 1);
						
						random = int(Math.random() * mbRandY[theKey].length);
	
						if(microBlogItem.isUp) {
							if(microBlogItem.isSource) {
								microBlogItem.x = days[j].x;
								microBlogItem.y = -theHeiht / 2 - microBlogItem.height;	
							}else {
								microBlogItem.y = -theHeiht / 2 - microBlogItem.height - mbRandY[theKey][random] * offset;
							}
						}else {
							if(microBlogItem.isSource) {
								microBlogItem.x = days[j].x;
								microBlogItem.y = theHeiht / 2;	
							}else {
								microBlogItem.y = theHeiht / 2 + mbRandY[theKey][random] * offset;
							}
						}
						mbRandY[theKey].splice(random, 1);
						//动画
						//if(k < maxAnimationCount) {
							var animationX:Number = days[j].x + days[j].width / 2 - microBlogItem.x;
							var animationY:Number  = days[j].y + days[j].height / 2 - microBlogItem.y;
							var delay:Number = k * 0.2;
							microBlogItem.playAnimation(animationX, animationY, delay);	
						//}
							
						if(microBlogItem.isSource) {
							sourceMark = new SkinnableComponent();
							sourceMark.skin = new Skin(new SourceMarkAsset());
							addChild(sourceMark);
							sourceMark.visible = false;
							sourceMark.x = microBlogItem.x - sourceMark.width;
							if(microBlogItem.isUp) {
								sourceMark.y = -theHeiht / 2 -sourceMark.height;	
							}else {
								sourceMark.scaleY = -1;
								sourceMark.y = theHeiht / 2 + sourceMark.height;
							}
						}
							
						microBlogItem.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
						microBlogItem.addEventListener(MouseEvent.ROLL_OUT,  onRollOut);
						break;
						
					}
				}
			}	
		}
		
		private function onDayClick(event:MouseEvent):void {
			var day:TimeDay = event.currentTarget as TimeDay;
			var e:TimelineEvent = new TimelineEvent(TimelineEvent.TIME_DAY_CLICK);
			e.data = new SimpleDate(day.year, day.month, day.day);
			dispatchEvent(e);
		}
		
		private function onRollOver(event:MouseEvent):void {
			var microBlogItem:MicroBlogItem = event.currentTarget as MicroBlogItem;
			childIndex = getChildIndex(microBlogItem);
			addChild(microBlogItem);
		}		
		
		private function onRollOut(event:MouseEvent):void {
			var microBlogItem:MicroBlogItem = event.currentTarget as MicroBlogItem;
			setChildIndex(microBlogItem, childIndex);
		}
		
		public function highlightSourceMbItem():void {
			if(sourceMbItem) {
				setTimeout(highlight, 0,   	100, 	50, 50, 50);
				setTimeout(highlight, 200, 	0, 		0, 0, 0);
				setTimeout(highlight, 400, 	100, 	50, 50, 50);
				setTimeout(highlight, 600, 	0, 		0, 0, 0);
				setTimeout(highlight, 800, 	100, 	50, 50, 50);
				setTimeout(highlight, 1000, 0, 		0, 0, 0);
			}
		}
		
		private function highlight(p_brightness:Number, p_contrast:Number, p_saturation:Number, p_hue:Number ):void {
			if(sourceMbItem) {
				var cm:ColorMatrix = new ColorMatrix();
				cm.adjustColor(p_brightness, p_contrast, p_saturation, p_hue);
				sourceMbItem.filters = [new ColorMatrixFilter(cm)];
			}	
		}
		
		public function setSize(width:Number, height:Number):void {
			maxHeight = height;
		}
	}
}










