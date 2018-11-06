package code {

	import flash.events.KeyboardEvent;
	import flash.display.Stage;

	/**
	 * This class contains all the code relating to keyboard input.
	 */
	public class KeyboardInput {
		/** Keeps track of the key's current state. */
		static public var keysState: Array = new Array();
		/** Keeps track of the key's previous state. */
		static public var keysPrevState: Array = new Array();

		/**
		 * This function sets up the event listeners to tell if the key is pressed
		 * down or if the key is up.
		 * @param stage Defines the stage to setup keyboard input to.
		 */
		static public function setup(stage: Stage) {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
		} // ends the KeyboardInput() function

		/**
		 * This function's job is to cache all of the key values for the next frame.
		 */
		static public function update(): void {
			keysPrevState = keysState.slice(); // in this context, slice() gives us a copy of the array
		} // ends the update() function

		/**
		 * This function sets the key's state equal to isDown.
		 * @param keyCode Defines the key code of whatever key is pressed.
		 * @param isDown Defines whether that key is pressed or not.
		 */
		static private function updateKey(keyCode: int, isDown: Boolean): void {
			keysState[keyCode] = isDown;
		} // ends the updateKey() function

		/**
		 * This function sets isDown equal to true if the key is currently being pressed.
		 * @param e The event that triggers this event handler.
		 */
		static private function handleKeyDown(e: KeyboardEvent): void {
			updateKey(e.keyCode, true);
		} // ends the handleKeyDown() function

		/**
		 * This function sets isDown equal to false if the key is not currently being pressed.
		 * @param e The event that triggers this event handler.
		 */
		static private function handleKeyUp(e: KeyboardEvent): void {
			updateKey(e.keyCode, false);
		} // ends the handleKeyUp() function

		/**
		 * This function determines whether or not the key is currently down.
		 * @param keyCode The key code of the key being pressed.
		 * @return keysState Returns the current state of the key being pressed.
		 */
		static public function isKeyDown(keyCode: int): Boolean {
			if (keyCode < 0) return false;
			if (keyCode >= keysState.length) return false;

			return keysState[keyCode];
		} // ends the isKeyDown() function

		/**
		 * This function sets the key's state to down.
		 * @param keyCode The key code of the key being pressed.
		 * @return The key's current state and the key's previous state.
		 */
		static public function onKeyDown(keyCode: int): Boolean {
			if (keyCode < 0) return false;
			if (keyCode >= keysState.length) return false;

			return (keysState[keyCode] && ! keysPrevState[keyCode]);
		} // ends the onKeyDown() function

	} // ends the KeyboardInput class

} // ends the package