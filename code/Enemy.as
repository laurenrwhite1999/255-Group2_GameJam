package code {

	import flash.display.MovieClip;
	import flash.geom.Point;

	/**
	 * This class contains all the code for the game's enemies.
	 */
	public class Enemy extends MovieClip {

		/** The gravity that is applied to the enemy as it falls. */
		private var gravity: Point = new Point(0, 800);
		/** The max speed that the enemy can move left or right. */
		private var maxSpeed: Number = 200;
		/** The velocity of the enemies. */
		private var velocity: Point = new Point(1, 5);

		/** The rate at which the enemy accelerates left. */
		private const HORIZONTAL_ACCELERATION: Number = 800;

		/** This is the enemy's collider for collision detection. */
		public var collider: ColliderAABB;

		/** This is the attack range of the enemy. */
		private var attackRange: Number = 200;

		/** Stores whether or not the cureent enemy is dead. */
		public var isDead: Boolean = false;

		/**
		 * This is the constructor code for the enemies.
		 * @param spawnX Where to spawn the enemy on the x axis.
		 * @param spawnY Where to spawn the enemy on the y axis.
		 */
		public function Enemy(spawnX: Number, spawnY: Number) {
			x = spawnX;
			y = spawnY;

			collider = new ColliderAABB(width / 2, height / 2);
		} // ends the Enemy() constructor

		/**
		 * This function updates the enemies when called.
		 */
		public function update(): void {
			handleWalking();

			doPhysics();

			collider.calcEdges(x, y);

			if (this.y == 550 || this.x < (ScenePlay.player.x - 500)) isDead = true;
		} // ends the update() function

		/**
		 * This function tells the enemy to walk toward the player if the player is within the attack range.
		 */
		private function handleWalking(): void {
			velocity.x -= HORIZONTAL_ACCELERATION * Time.dt;
			if (velocity.x > 0) velocity.x = 0; // clamp velocity at 0
		} // ends the handleWalking() function

		/**
		 * This function applies physics to the enemies.
		 */
		public function doPhysics(): void {
			var gravityMultiplier: Number = 2;
			velocity.y += gravity.y * Time.dt * gravityMultiplier;

			if (velocity.x < -maxSpeed) velocity.x = -maxSpeed;

			x += velocity.x * Time.dt;
			y += velocity.y * Time.dt;
		} // ends the doPhysics() function

		/**
		 * Fixes the enemy in position if it comes into contact with a platform.
		 * @param fix The position the player is fixed to.
		 */
		public function applyEnemyFix(enemyFix: Point): void {
			if (enemyFix.x != 0) {
				x += enemyFix.x;
				velocity.x = 0;
			}

			if (enemyFix.y != 0) {
				y += enemyFix.y;
				velocity.y = 0;
			}

			collider.calcEdges(x, y);
		} // ends the applyFix() function

	} // ends the Enemy class

} // ends the package