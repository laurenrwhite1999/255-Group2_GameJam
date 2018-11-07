package code {
	
	import flash.utils.getTimer;
	
	/** this is the Time class */
	public class Time {

		/** sets up a static delta time var, which static meaning there will only ever be one */
		public static var dt:Number = 0; 
		
		/** sets up a static delta time scaled var, which static meaning there will only ever be one */
		public static var dtScaled:Number = 0; 
		
		/** sets up a static current time var, which static meaning there will only ever be one */
		public static var time:Number = 0; 
		
		/** sets up a static time scale-er var, which static meaning there will only ever be one */
		public static var scale:Number = 1; 
		
		/* sets up a static previous time var, which static meaning there will only ever be one */
		private static var timePrev:Number = 0; 
		
		
		/** update function for the time class */
		public static function update():void {
			
			time = getTimer(); // gets the current game time in millisec. and stores it in time
			dt = (time - timePrev) / 1000; // caculates sec from millisec.
			dtScaled = dt * scale; // calculates the scale of time
			timePrev = time; // cache for next frame
			
		} // end update
		
	} // end class
	
}// end package