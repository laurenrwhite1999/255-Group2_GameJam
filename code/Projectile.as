package code {

	import flash.display.MovieClip;

	/**
	 * This class contains the code for the projectile objects.
	 */
	public class Projectile extends MovieClip {

		/** The speed at which the projectiles move. */
		private const SPEED: Number = 240;

		/** The velocity of the projectile on the X axis. */
		private var velocityX: Number = 0;
		/** The velocity of the projectile on the Y axis. */
		private var velocityY: Number = 0;

		/** Determines whether or not the projectile should be removed from the stage. */
		public var isDead: Boolean = false;

		/** The radius of the projectile. */
		public var radius: Number = width / 2;

		/**
		 * This is the constructor code for the Projectile objects.
		 */
		public function Projectile(rangedEnemy: RangedEnemy) {
			x = rangedEnemy.x;
			y = rangedEnemy.y;

			/** The distance between the player and the ranged enemy on the X axis. */
			var tx: Number = ScenePlay.player.x - rangedEnemy.x;
			/** The distance between the player and the ranged enemy on the Y axis. */
			var ty: Number = ScenePlay.player.y - rangedEnemy.y;

			/** The angle of the ranged enemy. */
			var angle: Number = Math.atan2(ty, tx);
			angle += (Math.random() * 20 + Math.random() * -20) * Math.PI / 180;

			velocityX = SPEED * Math.cos(angle);
			velocityY = SPEED * Math.sin(angle);
		} // ends the Projectile() function

		/**
		 * This function updates the projectile's location.
		 */
		public function update(): void {
			x += velocityX * Time.dt;
			y += velocityY * Time.dt;
		} // ends the update() function

	} // ends the Projectile class

} // ends the package