package com.shen.timeline.controller
{	
	import com.shen.core.util.Util;
	import com.shen.timeline.model.TimelineProxy;
	import com.shen.timeline.view.ApplicationMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class LoadCommand extends SimpleCommand  {

		override public function execute( note:INotification ) : void {
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
			
			var now:Date = new Date();
			if(startYear > now.fullYear || startYear == now.fullYear && startMonth > now.month + 1 
				|| startYear == now.fullYear && startMonth == now.month + 1 && startDay > now.date) {
				var appMediator:ApplicationMediator = facade.retrieveMediator(ApplicationMediator.NAME) as ApplicationMediator;
				appMediator.hideRightButton();
				appMediator.isEnd = true;
				return;
			}
			
			var endYear:int 	= startYear;
			var endMonth:int 	= startMonth;
			var endDay:int 		= startDay;
			
			var count:int = timelineProxy.count;
			for (var i:int = 0; i < count; i++) {
				endDay++;
				if(endDay > Util.monthHasDays(endYear, endMonth)) {
					endDay = 1;
					endMonth++;	
					if(endMonth > 12) {
						endMonth = 1;
						endYear++;
					}
				}
			}
			
			if(endYear > now.fullYear || endYear == now.fullYear && endMonth > now.month + 1 
				|| endYear == now.fullYear && endMonth == now.month + 1 && endDay > now.date) {
				endYear 	= now.fullYear;
				endMonth 	= now.month + 1;
				endDay 		= now.date;	
			}
			timelineProxy.load(startYear, startMonth, startDay, endYear, endMonth, endDay);
		}
	}
}




















