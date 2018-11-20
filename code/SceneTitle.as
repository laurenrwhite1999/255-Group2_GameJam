package code {

	import flash.events.MouseEvent;

	
	/** this is the SceneTitle class which extends to the current gamescene, which means it gives the gamescene its code */
	public class SceneTitle extends GameScene {
		
		/** sets if the title should switch from title - play or not */
		private var shouldSwitchToPlay:Boolean = false; 
		
		/**
		  * this is the update function for the title scene
		  * @param keyboard it is holding a KeyboardInput class instance inside the variable so that any keyboard inputs will be read in this scene
		  */
		override public function update():GameScene {
			
			if(shouldSwitchToPlay) return new ScenePlay(); // if it should switch, return to GameScene and add a new ScenePlay
			
			return null; // return nothing
			
		}// end update
		
		/** this function updates the scene if there is and event listeners needed to be added */
		override public function onBegin():void {
			
			bttnPlay.addEventListener(MouseEvent.MOUSE_DOWN, handleClickPlay); // adds event listener to button and the stage

			}
		
		/** this function updates the scene if there is and event listeners needed to be removed */
		override public function onEnd():void {
			
			bttnPlay.removeEventListener(MouseEvent.MOUSE_DOWN, handleClickPlay); // removes event listener from button and the stage

			}
		
		/** 
		  * this function handles the clicking of the button
		  * @param e takes the mouse event into a variable to be used
		  */
		private function handleClickPlay(e:MouseEvent):void {
			
			shouldSwitchToPlay = true; // sets the scene switching process
			
		}
		
	} // end class 
	
} // end package