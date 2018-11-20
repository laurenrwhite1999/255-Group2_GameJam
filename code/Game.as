package code {
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	
	/** this is the game class which extends to the movie clip, which means it gives the movie clip its code */
	public class Game extends MovieClip {
		
		/**	This stores the current scene using a FSM. */
		private var gameScene:GameScene;

		/** this is the game function, which really only handles scene switches due to the state machine set up */
		public function Game() {
			
			switchScene(new SceneTitle()); // sets the current scene to the title scene	
			
			addEventListener(Event.ENTER_FRAME, gameLoop); // adds gameLoop to the current game, which allows everything to keep running while game is running

		} // end game function
		
		/**
		  * this function handles the checks for if a new scene is called
		  * @param e hold the event for when the gameLoop enters the frame
		  */
		private function gameLoop(e:Event):void {
			
			if(gameScene) switchScene(gameScene.update()); // if gameScene is called, prompt switchScene(switches the scenes)
			
			Time.update(); // updates time
			
			KeyboardInput.setup(stage); // adds a keyboard to the stage
			
			
		} // ends gameLoop
		
		/**
		  * this function is to handle switching of the scenes whenever switchScene is called
		  * @param newScene holds a new gameScene variable, and when a new scene is called it puts a new game scene in a wipes the old one
		  */
		private function switchScene(newScene:GameScene):void {
			
			if(newScene){ // if newScene is called do the following
				
				//switch scenes...
				if(gameScene) gameScene.onEnd(); // if gameScene is called, prompt onEnd funtion in gameScene
				if(gameScene) removeChild(gameScene); // removes the current scene that is in play
				gameScene = newScene; // current gameScene is then set to a newScene
				addChild(gameScene); // the newScene(gameScene) is added to the scene
				gameScene.onBegin(); // the onBegin function is then called in gameScene
				stage.focus = stage;
				
			} // end if newScene statement
			
		} // ends switchScene()
		
	} // end game class
	
} // end game package