package code {

	import flash.utils.getTimer;

	/**
	 * The class for handling all game time.
	 */
	public class Time {

		/** How much time has passed since the previous frame. */
		public static var dt: Number = 0;
		/** A scaled version of deltaTime. Uses Time.Scale measured in milliseconds. */
		public static var dtScaled: Number = 0;
		/** The current frame's timestamp. How many milliseconds have passed since the game started. */
		public static var time: Number = 0;
		/** The timestamp of the previous frame, measured in milliseconds. */
		private static var timePrev: Number = 0;

		/** A scalar for dtScaled. Use this to creat slowmo effects or to pause the game. */
		public static var scale: Number = 1;

		/**
		 * This method calculates deltaTime. It should be called once per frame from the game loop.
		 */
		public static function update(): void {
			time = getTimer();
			dt = (time - timePrev) / 1000;
			dtScaled = dt * scale;
			timePrev = time; // cache for next frame
		} // ends the update() function

	} // ends the Time class

} // ends the package