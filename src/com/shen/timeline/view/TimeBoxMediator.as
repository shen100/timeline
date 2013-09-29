package com.shen.timeline.view 
{
	
	import com.shen.timeline.ApplicationFacade;
	import com.shen.timeline.model.TimelineProxy;
	import com.shen.timeline.model.vo.TimelineVO;
	import com.shen.timeline.view.ui.TimeBox;
	
	import flash.events.Event;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	import com.shen.timeline.view.events.TimelineEvent;
	
	public class TimeBoxMediator extends Mediator implements IMediator {
		
		public static const NAME:String = "TimeBoxMediator";
		
		private var timelineProxy:TimelineProxy;
		
		public function TimeBoxMediator(viewComponent:TimeBox) {
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void {
			timelineProxy = facade.retrieveProxy(TimelineProxy.NAME) as TimelineProxy;
			timeBox.addEventListener(TimelineEvent.TIME_DAY_CLICK, onTimeDayClick);
			timeBox.addEventListener(TimelineEvent.MICROBLOG_ITEM_CLICK, onMicroBlogItemClick);
		}
		
		private function onMicroBlogItemClick(event:Event):void
		{
			sendNotification(ApplicationFacade.OPEN_DETAIL);
		}
		
		private function onTimeDayClick(event:TimelineEvent):void
		{
			sendNotification(ApplicationFacade.GOTO, event.data);
		}		
		
		override public function listNotificationInterests():Array {
			return [
				TimelineProxy.TIME_LINE_DATA
			];
		}
		
		override public function handleNotification(note:INotification):void {
			switch(note.getName()) {
				case TimelineProxy.TIME_LINE_DATA: {
					var timelineVO:TimelineVO = note.getBody() as TimelineVO;	
					if(timelineVO) {
						timeBox.addData(timelineVO);	
					}
					break;
				}
			}
		}
		
		private function get timeBox():TimeBox {
			return viewComponent as TimeBox;
		}
	}
}


