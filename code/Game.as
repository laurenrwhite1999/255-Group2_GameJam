package code {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;

	/**
	 * This is the class that runs the game.
	 */
	public class Game extends MovieClip {

		static public var platforms: Array = new Array();

		/**
		 * This function sets up the keyboard input and adds the event listener
		 * for the game loop.
		 */
		public function Game() {
			KeyboardInput.setup(stage);
			addEventListener(Event.ENTER_FRAME, gameLoop);
		} // ends the Game() function

		/**
		 * This is the game loop. It runs the game.
		 */
		private function gameLoop(e: Event): void {
			Time.update();
			player.update();

			doCollisionDetection();

			KeyboardInput.update();
		} // ends the gameLoop() function

		/**
		 * Prevents the player from moving through the platforms.
		 */
		private function doCollisionDetection(): void {
			for (var i: int = 0; i < platforms.length; i++) {
				if (player.collider.checkOverlap(platforms[i].collider)) {
					// find the fix:
					var fix: Point = player.collider.findOverlapFix(platforms[i].collider);

					// apply the fix:
					player.applyFix(fix);
				}
			} // ends the for() loop
		} // ends the doCollisionDetection() function

	} // ends Game class

} // ends package