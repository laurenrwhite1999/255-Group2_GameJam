package code {

	import flash.display.MovieClip;
	import flash.geom.Point;


	public class PowerUps extends MovieClip {
		/** The gravity that is applied to the powerUps as they fall. */
		private var gravity: Point = new Point(0, 800);
		/** The velocity of the powerUps */
		private var velocity: Point = new Point(1, 5);
		/** Stores whether the power up should be removed from the screen */
		public var isDead: Boolean = false;
		/** The max speed that the powerUp can move left or right. */
		private var maxSpeed: Number = 0;


		/** sets up for collision detection */
		public var collider: ColliderAABB;
		/** checks to make sure a powerup is spawned in the play scene */
		private var powerUpSpawned: Boolean = false;
		/** checks if powerUp 1 is still active*/
		public var powerUp1Active: Boolean = false;
		/** checks if powerUp 2 is still active*/
		public var powerUp2Active: Boolean = false;
		/** checks if powerUp 3 is still active*/
		public var powerUp3Active: Boolean = false;

		/**
		 * This is the constructor code for the PowerUps.
		 * @param spawnX Where to spawn the PowerUps on the x axis.
		 * @param spawnY Where to spawn the PowerUps on the y axis.
		 */
		public function PowerUps(spawnX: Number, spawnY: Number) {
			var spawnPowerUp: int = Math.random() * 3 + 1;
			/**
			 * Type 1.
			 * Type 2.
			 * Type 3.
			 */
			if (spawnPowerUp == 1) {
				gotoAndStop(0);
				powerUp1Active = true;
			} // end if
			if (spawnPowerUp == 2) {
				gotoAndStop(1);
				powerUp2Active = true;
			} // end if
			if (spawnPowerUp == 3) {
				gotoAndStop(2);
				powerUp3Active;
			} //end if
			x = spawnX + 200; // moves the powerup in front of the player
			y = spawnY;

			collider = new ColliderAABB(width / 2, height / 2);
		} // end PowerUps

		public function update(): void {
			isPowerUpActive();
			doPhysics();
			collider.calcEdges(x, y);

			if (this.y >= stage.stageHeight && this.x <= 0) isDead = true;
		} // ends the update() function

		/**
		 * This function applies gravity to the powerup
		 */
		private function doPhysics(): void {

			var gravityMultiplier: Number = 2;
			velocity.y += gravity.y * Time.dt * gravityMultiplier;

			if (velocity.x < -maxSpeed) velocity.x = -maxSpeed;

			x += velocity.x * Time.dt;
			y += velocity.y * Time.dt;
		} // end doPhysics

		/**
		 * Fixes the enemy powerUp position if it hits a platform.
		 * @param powerUpFix gets the point that needs to be fixed.
		 */
		public function applyPowerUpFix(powerUpFix: Point): void {
			if (powerUpFix.x != 0) {
				x += powerUpFix.x;
				velocity.x = 0;
			}

			if (powerUpFix.y != 0) {
				y += powerUpFix.y;
				velocity.y = 0;
			}

			collider.calcEdges(x, y);
		} // ends the applyFix() function

		public function isPowerUpActive(): void {
			if (powerUp1Active) {
				//power up 1
			} // end if
			if (powerUp2Active) {
				//power up 2
			} // end if
			if (powerUp3Active) {
				//power up 3
			} // end if
		} // end isPowerUpActive


	} // end class

} // end package