package com.shen.timeline.view 
{

	import com.shen.timeline.ApplicationFacade;
	import com.shen.timeline.model.TimelineProxy;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class ApplicationMediator extends Mediator implements IMediator {
		
		public static const NAME:String = "ApplicationMediator";
		
		private var timelineProxy:TimelineProxy;
		
		public function ApplicationMediator(viewComponent:Timeline) {
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void {
			timelineProxy = facade.retrieveProxy(TimelineProxy.NAME) as TimelineProxy;
			app.addEventListener(Timeline.LOAD_TIMELINE, 	onLoad);
			
			var menu:ContextMenu = app.contextMenu;
			if(!menu) {
				menu = new ContextMenu();
			}
			var menuItem:ContextMenuItem = new ContextMenuItem(timelineProxy.version, false, false);
			menu.customItems.push(menuItem);
			menu.hideBuiltInItems();
			app.contextMenu = menu;
		}
		
		private function onLoad(event:Event):void
		{
			sendNotification(ApplicationFacade.LOAD);
		}
		
		public function hideRightButton():void {
			app.hideRightButton();
		}
		
		public function set isEnd(value:Boolean):void {
			app.isEnd = value;
		}
		
		override public function listNotificationInterests():Array {
			return [
				//TimelineProxy.TIME_LINE_NO_NEW_DATA
			];
		}
		
		override public function handleNotification(note:INotification):void {
//			switch(note.getName()) {
//				case TimelineProxy.TIME_LINE_NO_NEW_DATA: {
//					app.hideRightButton();
//					break;
//				}
//			}
		}
		
		public function createDetailView():void {
			app.createDetailView();
		}
		
		public function destroyDetailView():void {
			app.destroyDetailView();
		}
		
		public function get app():Timeline {
			return viewComponent as Timeline;
		}
	}
}


