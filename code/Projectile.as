package code {

	import flash.display.MovieClip;

	/**
	 * This class contains the code for the projectile objects.
	 */
	public class Projectile extends MovieClip {

		private const SPEED: Number = 240;
		
		private var velocityX: Number = 0;
		private var velocityY: Number = 0;
		
		public var isDead: Boolean = false;

		/**
		 * This is the constructor code for the Projectile objects.
		 */
		public function Projectile(p: Player, rangedEnemy: RangedEnemy) {
			x = rangedEnemy.x;
			y = rangedEnemy.y;
			
			var tx: Number = p.x - rangedEnemy.x;
			var ty: Number = p.y - rangedEnemy.y;

			var angle: Number = Math.atan2(ty,tx);
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