package com.shen.timeline.controller
{	
	import com.shen.core.logging.Log;
	import com.shen.core.util.Util;
	import com.shen.timeline.model.TimelineProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class ModelPrepCommand extends SimpleCommand  {
		
		override public function execute( note:INotification ) : void {
			var app:Timeline = note.getBody() as Timeline;
			var data:Object = app.loaderInfo.parameters;
			var timelineProxy:TimelineProxy = new TimelineProxy();
			facade.registerProxy(timelineProxy);
		
			timelineProxy.gotoUrl = data.gotoUrl + "?year={year}&month={month}&day={day}";
			timelineProxy.gotoUrl += "&eventId=" + data.id;
			timelineProxy.id = data.id;
			
			timelineProxy.requestUrl = data.url;
			timelineProxy.requestUrl += "?startYear={startYear}&startMonth={startMonth}&startDay={startDay}";
			timelineProxy.requestUrl += "&endYear={endYear}&endMonth={endMonth}&endDay={endDay}";
			timelineProxy.requestUrl += "&id=" + data.id;
			//start: 2013 4-1
			//end:   2013-5-30
			timelineProxy.startYear 	= data.year;
			timelineProxy.startMonth 	= data.month;
			timelineProxy.startDay 		= data.day;	
			
			
			
			
//			var year:int = timelineProxy.startYear;
//			var month:int = timelineProxy.startMonth;
//			var day:int = timelineProxy.startDay;
//			
//			var endYear:int = timelineProxy.endYear;
//			var endMonth:int = timelineProxy.endMonth;
//			var endDay:int = timelineProxy.endDay;
			
//			var count:int = 0;
//			while(year != endYear || month != endMonth || day != endDay) {
//				count++;
//				day++;
//				if(day > Util.monthHasDays(year, month)) {
//					day = 1;
//					month++;	
//					if(month > 12) {
//						month = 1;
//						year++;
//					}
//				}
//			}
			
			timelineProxy.count = int(data.count) - 1;
		
			
			var endYear:int 	= timelineProxy.startYear;
			var endMonth:int 	= timelineProxy.startMonth;
			var endDay:int 		= timelineProxy.startDay;
			
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
			
			timelineProxy.endYear 		= endYear;
			timelineProxy.endMonth 		= endMonth;
			timelineProxy.endDay 		= endDay;	
			
			
			if(data.debug != undefined) {
				timelineProxy.isDebug = data.debug == "1" ? true : false;	
			}
			if(timelineProxy.isDebug) {
				Log.type = Log.BROWSER_LOG;
			}
		}
	}
}



