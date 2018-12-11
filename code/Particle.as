package code {

	import flash.display.MovieClip;
	import flash.geom.Point;

	/**
	 * This class contains all the code for particles and is the parent class
	 */
	public class Particle extends MovieClip {

		/** sets the acceleration of the particle */
		protected var acceleration: Point = new Point(0, 0);
		/** sets the velocity of the particle */
		protected var velocity: Point = new Point(0, 10);
		/** sets the rotation velocity of the particle */
		protected var angularVelocity: Number = 0;
		/** sets the scale velocity of the particle */
		protected var scalarVelocity: Number = 0;
		/** sets how long the particle will live */
		protected var lifeSpan: Number;
		/** sets how long the particle has lived */
		protected var age: Number = 0;
		/** holds if the particle is dead */
		public var isDead: Boolean = false;

		/**
		 * This function spawns the particle
		 */
		public function Particle(spawnX: Number, spawnY: Number) {
			x = spawnX;
			y = spawnY;
		} // end Particle

		/**
		 * This function updates the particles
		 */
		public function update(p: Player): void {

			rotation += angularVelocity * Time.dt;
			scaleX += scalarVelocity * Time.dt;
			scaleY = scaleX;
			velocity.x += acceleration.x * Time.dt;
			velocity.y += acceleration.y * Time.dt;
			x += velocity.x * Time.dt;
			y += velocity.y * Time.dt;
			age += Time.dt;
			if (shouldDie()) isDead = true;
			if (this.y >= ScenePlay.player.y + stage.stageHeight && ScenePlay.player.x - stage.stageWidth) isDead = true;
		} // end update

		/**
		 * This class contains all the code for particles that spawn after PowerUps collision
		 */
		public function shouldDie(): Boolean {
			if (age > lifeSpan) return true;

			return false;
		} // end shouldDie
	} // end Class
} // end Package