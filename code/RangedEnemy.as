package code {

	import flash.display.MovieClip;

	/**
	 * This class contains the code for the enemies with ranged attacks.
	 */
	public class RangedEnemy extends Enemy {

		/** The amount of time (in seconds) to wait before spawning the next projectile. */
		private var spawnProjectileDelay: Number = 0;

		/**
		 * This is the constructor code and sets up the properties for the RangedEnemy
		 * objects.
		 */
		public function RangedEnemy(spawnX: Number, spawnY: Number) {
			super(spawnX, spawnY);
		} // ends the RangedEnemy() constructor

		/**
		 * This function overrrides the update function to spawn projectiles.
		 */
		override public function update(): void {
			if (spawnProjectileDelay > 0) {
				spawnProjectileDelay -= Time.dt;
			} else {
				shootProjectiles();
				spawnProjectileDelay = Math.random() * 1.5 + .5;
			}
		} // ends the update() function

		private function shootProjectiles(): void {
			
		} // ends the shootProjectiles() function

	} // ends the RangedEnemy class

} // ends the package