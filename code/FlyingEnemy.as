package code {

	import flash.display.MovieClip;

	/**
	 * This class contains code for the flying enemies.
	 */
	public class FlyingEnemy extends Enemy {

		/** This array holds all of the projectile objects. */
		public var projectiles: Array = new Array();

		/** The amount of time (in seconds) to wait before spawning the next projectile. */
		private var spawnProjectileDelay: Number = 0;

		/**
		 * This is the constructor code and sets up the properties for the FlyingEnemy
		 * objects.
		 * @param spawnX The location the enemy spawns on the X axis.
		 * @param spawnY The location the enemy spawns on the Y axis.
		 */
		public function FlyingEnemy(spawnX: Number, spawnY: Number) {
			super(spawnX, spawnY);
		} // ends the FlyingEnemy constructor

		/**
		 * This function overrrides the update function to spawn projectiles.
		 */
		override public function update(game:ScenePlay): void {
			super.collider.calcEdges(x, y);

			if (spawnProjectileDelay > 0) {
				spawnProjectileDelay--;
			} else {
				shootProjectiles();
				spawnProjectileDelay = Math.random() * 120 + 120;
			}

			/** The distance between the player and the enemy on the X axis. */
			var dx: Number = ScenePlay.player.x - x;
			/** The distance between the player and the enemy on the Y axis. */
			var dy: Number = ScenePlay.player.y - y;
			/** The angle that the enemy is currently facing relative to the player. */
			var angleToPlayer: Number = Math.atan2(dy, dx);

			updateProjectiles(game);

			if (this.y == 550 || this.x < (ScenePlay.player.x - 500)) isDead = true;
		} // ends the update() function

		/**
		 * This function allows the flying enemies to shoot projectiles at the player.
		 */
		private function shootProjectiles(): void {
			var proj: Projectile = new Projectile(this);
			ScenePlay.level.addChild(proj);
			projectiles.push(proj);
		} // ends the shootProjectiles() function

		/**
		 * This function updates the projectiles.
		 */
		private function updateProjectiles(game:ScenePlay): void {
			for (var i = projectiles.length - 1; i >= 0; i--) {
				projectiles[i].update();
				
				if (ScenePlay.player.collider.checkOverlap(projectiles[i].collider) || this.isDead) {
					projectiles[i].isDead = true;
					game.playerHealth -= 1;
				}
				
				if (projectiles[i].isDead) {
					ScenePlay.level.removeChild(projectiles[i]);
					projectiles.splice(i, 1);
				}
			} // ends the for loop updating the projectiles
		} // ends the updateProjectiles() function

		/**
		 * This function removes physics for the flying enemies.
		 */
		override public function doPhysics(): void {

		} // ends the doPhysics() function

	} // ends the FlyingEnemy class

} // ends the package