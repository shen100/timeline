package com.shen.timeline.model.vo
{
	public class MicroBlogVO
	{
		private static var sourceRequested:Boolean;
		
		public var year:int;
		public var month:int;
		public var day:int;
		public var from:String;
		public var logo:String;
		public var fromBgColor:uint = 0x356EB3;
		public var isUp:Boolean;
		public var title:String;
		public var content:String;
		public var isSource:Boolean;
		
		public function MicroBlogVO(data:Object)
		{
			year		= data.year;
			month		= data.month;
			day			= data.day;
			from 		= data.from;
			logo		= data.logo;
			title 		= data.title;
			content 	= data.content;
			if(!sourceRequested) {
				isSource 	= data.isSource == "1" ? true : false;
			}
			if(isSource) {
				sourceRequested = true;
			}
			if(data.fromColor != undefined) {
				fromBgColor	= uint(data.fromColor);
			}
			if(isSource) {
				fromBgColor = 0xFF1025;	
			}
			if(day % 2 == 0) {
				isUp = true;
			}else{
				isUp = false;
			}
		}
	}
}