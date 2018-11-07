package code {
	
	import flash.display.MovieClip;
	
	/**
	 * This class is an ABSTRACT class for our
	 * GameScene FSM. All game scenes are child classes
	 * of this class.
	 */
	public class GameScene extends MovieClip {

		/**
		 * Each game scene should OVERRIDE this method
		 * and add specific implementation.
		 */
		public function update():GameScene {
			
			
			return null; // this returns the update function as null
			
		}
		
		/** place holder function for anything being added to the scene like eventlisteners or anyhting */
		public function onBegin():void {
			
		}
		
		/** place holder function for anything being removed to the scene like eventlisteners or anyhting */
		public function onEnd():void {
			
		} 

	} // end class
	
} // end package
