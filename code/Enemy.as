package code {

	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.display.Scene;

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

		/** The rate at which the enemy accelerates. */
		private const HORIZONTAL_ACCELERATION: Number = 800;
		/** The rate at which the enemy decelerates. */
		private const HORIZONTAL_DECELERATION: Number = 800;

		/** Stores whether or not the enemy is currently on the ground. */
		private var isGrounded: Boolean = false;
		/** Whether or not the enemy is moving upward in a jump. This effects gravity. */
		private var isJumping = false;

		/** This is the enemy's collider for collision detection. */
		public var collider: ColliderAABB;

		/** Stores whether or not the cureent enemy is dead. */
		public var isDead: Boolean = false;

		/** The velocity value of the enemy's jump. */
		private var jumpVelocity: Number = 400;

		/** The enemy's attack range. */
		public var attackRange: Number = 500;

		private var state: EnemyState;

		/**
		 * This is the constructor code for the enemies.
		 * @param spawnX Where to spawn the enemy on the x axis.
		 * @param spawnY Where to spawn the enemy on the y axis.
		 */
		public function Enemy(spawnX: Number, spawnY: Number) {
			x = spawnX;
			y = spawnY;

			collider = new ColliderAABB(width / 2, height / 2);
			changeState(new EnemyStateIdle());
		} // ends the Enemy() constructor

		/**
		 * This function updates the enemies when called.
		 */
		public function update(game:ScenePlay): void {
			if (state) {
				var nextState: EnemyState = state.update(this);
				changeState(nextState);
			}

			collider.calcEdges(x, y);
			isGrounded = false;

			if (this.y == 550 || this.x < (ScenePlay.player.x - 500)) isDead = true;
		} // ends the update() function

		private function changeState(nextState: EnemyState): void {
			if (nextState == null) return;

			if (state) state.onEnd();
			state = nextState;
			state.onBegin();
		}

		/**
		 * This function tells the enemy to walk toward the player if the player is within the attack range.
		 * @param dir The direction the enemy is walking in.
		 */
		public function handleWalking(dir: int): void {
			if (dir < 0) velocity.x -= HORIZONTAL_ACCELERATION * Time.dt;
			if (dir > 0) velocity.x += HORIZONTAL_ACCELERATION * Time.dt;

			if (dir == 0) {
				if (velocity.x < 0) {
					velocity.x += HORIZONTAL_DECELERATION * Time.dt;
					if (velocity.x > 0) velocity.x = 0; // clamp velocity at 0
				}
				if (velocity.x > 0) {
					velocity.x -= HORIZONTAL_DECELERATION * Time.dt;
					if (velocity.x < 0) velocity.x = 0; // clamp velocity at 0
				}
			}
		} // ends the handleWalking() function

		/**
		 * This function allows the enemy to jump.
		 */
		public function jump(): void {
			if (isGrounded) {
				velocity.y = -jumpVelocity;
				isGrounded = false;
				isJumping = true;
			}
		} // ends the handleJumping() function

		/**
		 * This function applies physics to the enemies.
		 */
		public function doPhysics(): void {
			if (velocity.y > 0) isJumping = false;

			/** The amount of gravity to apply to the object. */
			var gravityMultiplier: Number = 2;
			velocity.y += gravity.y * Time.dt * gravityMultiplier;

			if (velocity.x < -maxSpeed) velocity.x = -maxSpeed;

			x += velocity.x * Time.dt;
			y += velocity.y * Time.dt;
		} // ends the doPhysics() function

		/**
		 * This function calculates how far the enemy is from the player.
		 */
		public function getDisToPlayer(): Number {
			/** The distance between the player and enemy on the x axis. */
			var dx: Number = ScenePlay.player.x - x;
			/** The distance between the player and enemy on the y axis. */
			var dy: Number = ScenePlay.player.y - y;

			return Math.sqrt(dx * dx + dy * dy);
		} // ends the getDisToPlayer() function

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