package com.shen.timeline.controller
{	
	import com.shen.core.util.Util;
	import com.shen.timeline.model.TimelineProxy;
	import com.shen.timeline.view.ApplicationMediator;
	import com.shen.timeline.view.TimeBoxMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ViewPrepCommand extends SimpleCommand {
		
		override public function execute( note:INotification ) : void {
			var app:Timeline = note.getBody() as Timeline;
			
			facade.registerMediator( new ApplicationMediator(app) );
			facade.registerMediator( new TimeBoxMediator(app.timeBox) );
			
			var timelineProxy:TimelineProxy = facade.retrieveProxy(TimelineProxy.NAME) as TimelineProxy;
			
			//时间由新到旧
//			var startYear:int = timelineProxy.startYear;
//			var startMonth:int = timelineProxy.startMonth;
//			var startDay:int = timelineProxy.startDay;
//			
//			var endYear:int = startYear;
//			var endMonth:int = startMonth;
//			var endDay:int = startDay;
//		
//			for (var i:int = 1; i <= timelineProxy.count; i++) {
//				endDay--;
//				if(endDay < 1) {
//					endMonth--;
//					if(endMonth < 1) {
//						endYear--;
//						endMonth = 12;	
//					}
//					endDay = Util.monthHasDays(endYear, endMonth);
//				}
//				
//			}

			//时间由旧到新
			var startYear:int 	= timelineProxy.startYear;
			var startMonth:int 	= timelineProxy.startMonth;
			var startDay:int 	= timelineProxy.startDay;
			
			var endYear:int 	= timelineProxy.endYear;
			var endMonth:int 	= timelineProxy.endMonth;
			var endDay:int 		= timelineProxy.endDay;
			timelineProxy.load(startYear, startMonth, startDay, endYear, endMonth, endDay);
		}
	}
}







