package code {

	import flash.display.MovieClip;

	/**
	 * This class holds all of the collectible objects.
	 */
	public class Collect extends MovieClip {

		/** Stores whether or not the player has picked up the collectible. */
		public var isDead: Boolean = false;
		/** Picks which collectible will be spawned. */
		public var spawnPicker: int = Math.random() * 3 + 1;
		/** The ID number of the collectible. */
		public var idNum: int;

		/** Determines when the player has collided with the collectible. */
		public var collider: ColliderAABB;
		/** Stores whether or not the collectible has been spawned. */
		private var itemSpawned: Boolean = false;

		/**
		 * This is the constructor. It picks which collectible to spawn based on its assigned ID
		 * number.
		 */
		public function Collect() {

			while (itemSpawned == false) {
				/** Picks which collectible will be spawned. */
				var spawnPicker: int = Math.random() * 3 + 1;

				if (ScenePlay.isItemThreeSpawned == false && spawnPicker == 3) {
					collider = new ColliderAABB(width / 2, height / 2);
					collider.calcEdges(x, y);
					idNum = 3;
					gotoAndStop(3);

					ScenePlay.isItemThreeSpawned = true;
					ScenePlay.collectables.push(this);
					itemSpawned = true;
				} // picks collectible 3 to be spawned

				if (ScenePlay.isItemTwoSpawned == false && spawnPicker == 2) {
					collider = new ColliderAABB(width / 2, height / 2);
					collider.calcEdges(x, y);
					idNum = 2;
					gotoAndStop(2);

					ScenePlay.isItemTwoSpawned = true;
					ScenePlay.collectables.push(this);
					itemSpawned = true;
				} // picks collectible 2 to be spawned

				if (ScenePlay.isItemOneSpawned == false && spawnPicker == 1) {
					collider = new ColliderAABB(width / 2, height / 2);
					collider.calcEdges(x, y);
					idNum = 1;
					gotoAndStop(1);

					ScenePlay.isItemOneSpawned = true;
					ScenePlay.collectables.push(this);
					itemSpawned = true;
				} // picks collectible 1 to be spawned

				trace(spawnPicker);
			} // ends the while loop

		} // ends the Collect() function

	} // ends the Collect class

} // ends the package