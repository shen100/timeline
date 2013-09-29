package com.shen.timeline.model
{
	import com.adobe.serialization.json.JSON;
	import com.shen.core.logging.Log;
	import com.shen.core.net.HttpService;
	import com.shen.core.util.Util;
	import com.shen.timeline.model.vo.TimelineVO;
	
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	public class TimelineProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "TimelineProxy";
		
		public static const TIME_LINE_DATA:String 			= "timeLineData";
		
		public static const DETAIL_DATA:String 				= "detailData";
		//public static const TIME_LINE_NO_NEW_DATA:String 	= "timeLineNoNewData";
		
		private const VERSION_NAME:String 	= "时间轴";
		private const MAJOR:int 			= 1;
		private const MINOR:int 			= 1;
		private const REVISION:int 			= 11;
		
		private var allTimelineVO:Vector.<TimelineVO> = new Vector.<TimelineVO>();
		
		public var startYear:int;
		public var startMonth:int;
		public var startDay:int;
		
		public var endYear:int;
		public var endMonth:int;
		public var endDay:int;
		
		public var count:int;
		public var requestUrl:String;
		public var gotoUrl:String;
		public var id:String;
		
		public var isDebug:Boolean;
		
		private var ifLoading:Boolean;
		
		public function TimelineProxy() {
			super(NAME);	
		}
		
		public function load(startYear:int, startMonth:int, startDay:int, endYear:int, endMonth:int, endDay:int):void {
			if(!ifLoading) {
				ifLoading = true;
				var httpService:HttpService = new HttpService();
				httpService.addResponder(onResult, onFault);
				var url:String = requestUrl;
				url = url.replace("{startYear}",  	startYear);
				url = url.replace("{startMonth}", 	startMonth);
				url = url.replace("{startDay}", 	startDay);
				url = url.replace("{endYear}",  	endYear);
				url = url.replace("{endMonth}",  	endMonth);
				url = url.replace("{endDay}",  		endDay);
				
				Log.debug(this, "load: " + url);
				httpService.send(url);
			}
		}
		
		private function onResult(data:Object):void {
			var result:Object = JSON.decode(data as String);
			var tLineVO:TimelineVO = new TimelineVO(result);
			Log.debug(this, "load success");
			Log.debug(this, "start: " + result.startYear + "-" + result.startMonth + "-" + result.startDay);
			Log.debug(this, "end: " + result.endYear + "-" + result.endMonth + "-" + result.endDay);
			
			startYear = result.endYear;
			startMonth = result.endMonth;
			startDay = int(result.endDay) + 1;
			
			if(startDay > Util.monthHasDays(startYear, startMonth)) {
				startDay = 1;
				startMonth++;	
				if(startMonth > 12) {
					startMonth = 1;
					startYear++;
				}
			}
			allTimelineVO.push(tLineVO);	
			ifLoading = false;
			sendNotification(TimelineProxy.TIME_LINE_DATA, tLineVO);
			
//			var now:Date = new Date();
//			if(startYear > now.fullYear || startYear == now.fullYear && startMonth > now.month + 1 
//				|| startYear == now.fullYear && startMonth == now.month + 1 && startDay > now.date) {
//				sendNotification(TimelineProxy.TIME_LINE_NO_NEW_DATA);
//			}
		}
		
		private function onFault(info:Object):void {
			ifLoading = false;
			Log.debug(this, "load error");
		}
		
		public function loadDetail():void {
			onDetailResult(null);	
		}
		
		private function onDetailResult(data:Object):void {
			sendNotification(TimelineProxy.DETAIL_DATA);	
		}
		
		private function onDetailFault(info:Object):void {
			
		}
		
		public function get version():String {
			return VERSION_NAME + " " + MAJOR + "." + MINOR + "." + REVISION;
		}
	}
}