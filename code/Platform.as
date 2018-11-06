package code {

	import flash.display.MovieClip;

	/**
	 * This class contains the code for each platform object.
	 */
	public class Platform extends MovieClip {

		/** The object's collider. */
		public var collider: ColliderAABB;

		/**
		 * This constructor gives the platform a collider and adds it to the
		 * platforms array.
		 */
		public function Platform() {
			collider = new ColliderAABB(width / 2, height / 2);
			collider.calcEdges(x, y);

			// add to platforms array
			Game.platforms.push(this);
		} // ends the Platform() constructor

	} // ends the Platform class

} // ends the package