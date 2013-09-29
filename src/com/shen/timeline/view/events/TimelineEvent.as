package com.shen.timeline.view.events
{
	import flash.events.Event;

	public class TimelineEvent extends Event
	{
		public static const TIME_DAY_CLICK:String 		= "timeDayClick";
		public static const MICROBLOG_ITEM_CLICK:String = "microBlogItemClick";
		
		public var data:*;
		
		public function TimelineEvent(type:String, data:*=null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			this.data = data;
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event {
			return new TimelineEvent(type, data, bubbles, cancelable);	
		}
		
		override public function toString():String {
			return formatToString("TimelineEvent", "type", "data", "bubbles", "cancelable");	
		}
		
		
	}
}


