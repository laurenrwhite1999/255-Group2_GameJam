package code {

	import flash.display.MovieClip;

	/**
	 * This class contains the code for the enemies with ranged attacks.
	 */
	public class RangedEnemy extends Enemy {

		/** This array holds all of the projectile objects. */
		var projectiles: Array = new Array();
		
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
			
			updateProjectiles();
		} // ends the update() function

		/**
		 * This function allows the ranged attack enemies to shoot projectiles at the player.
		 */
		private function shootProjectiles(p: Player = null): void {
			var proj: Projectile = new Projectile(p, this);
			ScenePlay.level.addChild(proj);
		} // ends the shootProjectiles() function
		
		/**
		 * This function updates the projectiles.
		 */
		private function updateProjectiles(): void {
			for(var i = projectiles.length - 1; i >= 0; i--) {
				projectiles[i].update();
				if(projectiles[i].isDead) {
					ScenePlay.level.removeChild(projectiles[i]);
					projectiles.splice(i, 1);
				}
			} // ends the for loop updating the projectiles
		} // ends the updateProjectiles() function

	} // ends the RangedEnemy class

} // ends the package