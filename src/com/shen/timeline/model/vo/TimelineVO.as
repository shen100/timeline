package com.shen.timeline.model.vo
{
	import com.shen.core.logging.Log;
	import com.shen.core.util.Util;

	public class TimelineVO
	{
		public var dates:Vector.<SimpleDate>;
		public var microblogs:Vector.<MicroBlogVO>;
		
		public function TimelineVO(data:Object)
		{
			dates = new Vector.<SimpleDate>();

			var year:int = data.startYear;
			var month:int = data.startMonth;
			var day:int = data.startDay;
			
			while(true) {
				var date:SimpleDate = new SimpleDate(year, month, day);
				dates.push(date);
				Log.debug(this, "日期: " + date.year + "-" + date.month + "-" + date.day);
				if(year == int(data.endYear) && month == int(data.endMonth) && day == int(data.endDay)) {
					break;
				}
				day++;
				if(day > Util.monthHasDays(year, month)) {
					day = 1;
					month++;	
					if(month > 12) {
						month = 1;
						year++;
					}
				}
			}
			
		
			microblogs = new Vector.<MicroBlogVO>();
			for each (var microBlogData:Object in data.data) {
				for each (var mb:Object in microBlogData.microblog) {
					mb.year = microBlogData.year;
					mb.month = microBlogData.month;
					mb.day = microBlogData.day;
					var microBlog:MicroBlogVO = new MicroBlogVO(mb);
					microblogs.push(microBlog);
				}
			}
			microblogs.sort(compareFunction);
		}
		
		private function compareFunction(x:MicroBlogVO, y:MicroBlogVO):Number {
			var date1:Date = new Date(x.year, x.month - 1, x.day);
			var date2:Date = new Date(y.year, y.month - 1, y.day);
			var time1:Number = date1.getTime();
			var time2:Number = date2.getTime();
			if(time1 > time2) {
				return 1;
			}else if(time1 == time2) {
				return 0;	
			}
			return -1;
		}
	}
}



















