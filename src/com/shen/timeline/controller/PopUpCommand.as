package com.shen.timeline.controller
{
	import com.shen.timeline.ApplicationFacade;
	import com.shen.timeline.model.TimelineProxy;
	import com.shen.timeline.view.ApplicationMediator;
	import com.shen.timeline.view.DetailMediator;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class PopUpCommand extends SimpleCommand
	{
		override public function execute( note:INotification ) : void {
			var appMediator:ApplicationMediator = facade.retrieveMediator(ApplicationMediator.NAME) as ApplicationMediator;
			switch(note.getName()) {
				case ApplicationFacade.OPEN_DETAIL: {
					appMediator.createDetailView();
					facade.registerMediator( new DetailMediator(appMediator.app.detailView));	
					var timelineProxy:TimelineProxy = facade.retrieveProxy(TimelineProxy.NAME) as TimelineProxy;
					timelineProxy.loadDetail();
					break;
				}
				case ApplicationFacade.CLOSE_DETAIL: {
					facade.removeMediator(DetailMediator.NAME);
					appMediator.destroyDetailView();
					break;
				}
			}
			
		}
	}
}