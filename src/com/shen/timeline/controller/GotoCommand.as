package com.shen.timeline.controller
{
	import com.shen.timeline.model.TimelineProxy;
	import com.shen.timeline.model.vo.SimpleDate;
	
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class GotoCommand extends SimpleCommand
	{
		override public function execute( note:INotification ) : void {
			var date:SimpleDate = note.getBody() as SimpleDate;
//			var request:URLRequest = new URLRequest();
			var tlineProxy:TimelineProxy = facade.retrieveProxy(TimelineProxy.NAME) as TimelineProxy;
//			var url:String = tlineProxy.gotoUrl;
//			url = url.replace("{year}", date.year);
//			url = url.replace("{month}", date.month);
//			url = url.replace("{day}", date.day);
//			request.url = url;
//			navigateToURL(request, "_blank");
			try {
				ExternalInterface.call("flashCallQuery", date.year, date.month, date.day, tlineProxy.id);	
			}catch(e:Error) {
				
			}
		}
	}
}


