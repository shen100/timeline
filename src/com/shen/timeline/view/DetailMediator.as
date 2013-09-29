package com.shen.timeline.view
{
	import com.shen.timeline.ApplicationFacade;
	import com.shen.timeline.model.TimelineProxy;
	import com.shen.timeline.view.ui.DetailView;
	
	import flash.events.Event;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class DetailMediator extends Mediator implements IMediator {
	
		public static const NAME:String = "DetailMediator";

		private var timelineProxy:TimelineProxy;
		
		public function DetailMediator(viewComponent:DetailView) {
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void {
			timelineProxy = facade.retrieveProxy(TimelineProxy.NAME) as TimelineProxy;
			detailView.addEventListener(DetailView.CLOSE, onClose);
		}
		
		private function onClose(event:Event):void {
			sendNotification(ApplicationFacade.CLOSE_DETAIL);
		}
		
		override public function listNotificationInterests():Array {
			return [
				TimelineProxy.DETAIL_DATA
			];
		}
		
		override public function handleNotification(note:INotification):void {
			switch(note.getName()) {
				case TimelineProxy.DETAIL_DATA: {
					detailView.data = null;
					break;
				}
			}
		}
		
		private function get detailView():DetailView {
			return viewComponent as DetailView;
		}
	}
}