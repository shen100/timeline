package com.shen.timeline
{	
	import com.shen.timeline.controller.GotoCommand;
	import com.shen.timeline.controller.LoadCommand;
	import com.shen.timeline.controller.PopUpCommand;
	import com.shen.timeline.controller.StartupCommand;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	public class ApplicationFacade extends Facade implements IFacade {
		
		public static const STARTUP:String  	= "startup";
		public static const LOAD:String  		= "load";
		public static const GOTO:String  		= "goto";
		public static const OPEN_DETAIL:String  = "openDetail";
		public static const CLOSE_DETAIL:String  = "closeDetail";
		
		public function ApplicationFacade(key:String) {
			super(key);    
		}
		
		public static function getInstance(key:String):ApplicationFacade {
			if ( instanceMap[key] == null ){
				instanceMap[key] = new ApplicationFacade(key);
			}
			return instanceMap[key] as ApplicationFacade;
		}
		
		override protected function initializeController() : void {
			super.initializeController();     
			registerCommand( STARTUP, 			StartupCommand );
			registerCommand( LOAD, 				LoadCommand );
			registerCommand( GOTO, 				GotoCommand );
			registerCommand( OPEN_DETAIL, 		PopUpCommand );
			registerCommand( CLOSE_DETAIL, 		PopUpCommand );
		}
		
		public function startup( app:Timeline ):void {
			sendNotification( STARTUP, app );
		}
		
	}
}















