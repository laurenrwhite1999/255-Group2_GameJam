package code {
	
	import flash.display.MovieClip;
	
	import flash.events.MouseEvent;
	
	/** this is the SceneLose class, and it is extening(giving its info) to the GameScene class so that it can use its info */
	public class SceneLose extends GameScene {
		
		/** sets if the title should switch from title - play or not */
		private var shouldSwitchToPlay:Boolean = false; 
		
		/** the sceneLose function, which holds nothing. But if we wanted to add or alter anything in this scene it would go here */
		public function SceneLose() {

		} // end SceneLose Function
		
		/**
		  * this is an overriden update function from the GameScene class, which is telling the current scene to chueck and update for 'this' in the current scene
		  * this update function is looking for when the player presses entter on the keyboard
		  * @param keyboard it is holding a KeyboardInput class instance inside the variable so that any keyboard inputs will be read in this scene
		  */
		override public function update():GameScene {
			
			if(shouldSwitchToPlay) return new SceneTitle(); // if enter is pressed on the keyboard, change back to the title screen
			
			return null; // return no info after done
			
		} // end update function
		
		/** this function updates the scene if there is and event listeners needed to be added */
		override public function onBegin():void {
			
			bttnRestart.addEventListener(MouseEvent.MOUSE_DOWN, handleClickPlay); // adds event listener to the reset button and the stage

			}

		/** this function updates the scene if there is and event listeners needed to be removed */
		override public function onEnd():void {

			bttnRestart.removeEventListener(MouseEvent.MOUSE_DOWN, handleClickPlay); // removes event listener from the reset button and the stage

			}
			
		/** 
		  * this function handles the clicking of the button
		  * @param e takes the mouse event into a variable to be used
		  */
		private function handleClickPlay(e:MouseEvent):void {
			
			shouldSwitchToPlay = true; // sets the scene switching process
			
		}
		
	} // end SceneLose class
	
} // end package