package code {

	import flash.display.MovieClip;

	/**
	 * This class contains the code for the enemies with ranged attacks.
	 */
	public class RangedEnemy extends Enemy {

		/** This array holds all of the projectile objects. */
		public var projectiles: Array = new Array();
		
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
			super.doPhysics();
			
			super.collider.calcEdges(x, y);
			
			if (spawnProjectileDelay > 0) {
				spawnProjectileDelay --;
			} else {
				shootProjectiles();
				spawnProjectileDelay = Math.random() * 20 + 20;
			}
			
			var dx: Number = ScenePlay.player.x - x;
			var dy: Number = ScenePlay.player.y - y;
			var angleToPlayer: Number = Math.atan2(dy, dx);
			
			updateProjectiles();
			
			if (this.y == 550 || this.x < (ScenePlay.player.x - 500)) isDead = true;
		} // ends the update() function
		

		/**
		 * This function allows the ranged attack enemies to shoot projectiles at the player.
		 */
		private function shootProjectiles(): void {
			var proj: Projectile = new Projectile(this);
			ScenePlay.level.addChild(proj);
			projectiles.push(proj);
		} // ends the shootProjectiles() function
		
		/**
		 * This function updates the projectiles.
		 */
		private function updateProjectiles(): void {
			for(var i = projectiles.length - 1; i >= 0; i--) {
				projectiles[i].update();
				if(projectiles[i].isDead) {
					ScenePlay.level.removeChild(projectiles[i]);
					projectiles.splice(i, i);
				}
			} // ends the for loop updating the projectiles
		} // ends the updateProjectiles() function

	} // ends the RangedEnemy class

} // ends the package