package code {

	import flash.display.MovieClip;
	import flash.geom.Point;

	/** this class holds everything that the trick platforms can do **/
	public class Trick extends MovieClip {
		/** this var holds the number that the item will be **/
		public var spawnPicker: int;
		/** this var holds the ID number of the different objects **/
		public var idNum: int;
		/** this var holds whether or not the object is dead or not **/
		public var isDead: Boolean = false;
		/** this var holds a colliderAABB instance **/
		public var collider: ColliderAABB;

		/** this var holds the max height that the platforms can go up to**/
		public var maxHeight: int = 100;
		/** his var holds the min height that the platforms can go down to **/
		public var minHeight: int = 300;
		/** this sets up the Timer for the dissapering platform **/
		public var dissPlatTimer: Number = 20;
		/** this bool holds whether or not the platform is going down or not **/
		public var goingDown: Boolean = false;

		/** this is the constructor function for the Trick class **/
		public function Trick() {

			// this is setting the spawnpicker to a random number
			spawnPicker = Math.random() * 6 + 1;

			if (spawnPicker == 6) { // if the number is 6

				collider = new ColliderAABB(width / 2, height / 2); // add a new collider
				collider.calcEdges(x, y); // calculate that objects edges
				gotoAndStop(6); // show the specific object on screen
				idNum = 6; // set the id number to be 6
				ScenePlay.trickPlatforms.push(this); // push this up to the trickPlatforms array in the ScenePlay

			}

			if (spawnPicker == 5) { // if the number is 5

				collider = new ColliderAABB(width / 2, height / 2); // add a new collider
				collider.calcEdges(x, y); // calculate that objects edges
				gotoAndStop(5); // show the specific object on screen
				idNum = 5; // set the id number to be 5
				ScenePlay.trickPlatforms.push(this); // push this up to the trickPlatforms array in the ScenePlay

			}

			if (spawnPicker == 4) { // if the number is 4

				collider = new ColliderAABB(width / 2, height / 2); // add a new collider
				collider.calcEdges(x, y); // calculate that objects edges
				gotoAndStop(4); // show the specific object on screen
				idNum = 4; // set the id number to be 4
				ScenePlay.trickPlatforms.push(this); // push this up to the trickPlatforms array in the ScenePlay
 
			}

			if (spawnPicker == 3) { // if the number is 3

				collider = new ColliderAABB(width / 2, height / 2); // add a new collider
				collider.calcEdges(x, y);  // calculate that objects edges
				gotoAndStop(3); // show the specific object on screen
				idNum = 3; // set the id number to be 3
				ScenePlay.trickPlatforms.push(this); // push this up to the trickPlatforms array in the ScenePlay

			}

			if (spawnPicker == 2) { // if the number is 2

				collider = new ColliderAABB(width / 2, height / 2); // add a new collider
				collider.calcEdges(x, y); // calculate that objects edges
				gotoAndStop(2); // show the specific object on screen
				idNum = 2; // set the id number to be 2
				ScenePlay.trickPlatforms.push(this); // push this up to the trickPlatforms array in the ScenePlay


			}

			if (spawnPicker == 1) { // if the number is 1

				collider = new ColliderAABB(width / 2, height / 2); // add a new collider
				collider.calcEdges(x, y); // calculate that objects edges
				gotoAndStop(1); // show the specific object on screen
				idNum = 1; // set the id number to be 1
				ScenePlay.trickPlatforms.push(this); // push this up to the trickPlatforms array in the ScenePlay

			}


		}

		/** 
		  * this is the update function of all trick platforms
		  * @param player passes in the player class so that the platforms can adjust the players speed and position
		  *
		  */
		public function update(player: Player): void {

			if (idNum == 2) {
				player.y += 3; // keep the player on the platform
				y += 3; // move the platform
				collider.calcEdges(x, y); // calculate that objects edges
				
			} else if (idNum == 3) {
				collider = new ColliderAABB(width / 2, height / 2); // add a new collider
				collider.calcEdges(x, y); // calculate that objects edges
				player.x -= 5; // move the player

			} else if (idNum == 4) {


				if (goingDown == false) {
					collider = new ColliderAABB(width / 2, height / 2); // add a new collider
					collider.calcEdges(x, y); // calculate that objects edges
					player.y -= 3; // keeps player on the platform
					y -= 2; // move the platform
					if (y <= maxHeight) { // if hits the max height
						goingDown = true; // go down
					}
				} else if (goingDown) {
					collider = new ColliderAABB(width / 2, height / 2); // add a new collider
					collider.calcEdges(x, y); // calculate that objects edges
					player.y += 4; // keeps the player on the platform
					y += 2; // move the platform
					if (y >= minHeight) { // if his the min height
						goingDown = false; // go up
					}
				}

			} else if (idNum == 5) {
				collider = new ColliderAABB(width / 2, height / 2); // add a new collider
				collider.calcEdges(x, y); // calculate that objects edges
				player.y += 3; // keep the player in the platform
				width -= 3; // shrink width
				height -= 3; // shrink height

				if (height == 0) { //if the platform no longer had any height
					isDead = true; // get rid of it
				}
			} else if (idNum == 6) {
				collider = new ColliderAABB(width / 2, height / 2); // add a new collider
				collider.calcEdges(x, y); // calculate that objects edges

			}
		} // end update function
	} // end class

} // end package