package code {

	/**
	 * This class contains all the code for particles that spawn after Collecting collision
	 * this class is a child of the Particle Class
	 */
	public class ParticleCollecting extends Particle {

		public function ParticleCollecting(spawnX: Number, spawnY: Number) {
			/**	this holds the position of where the particles spawn */
			super(spawnX, spawnY);
			/**	sets the velocity of the particle in X */
			velocity.x = Math.random() * 200 - 300;
			/**	sets the velocity of the particle in Y */
			velocity.y = Math.random() * 150 - 250;
			/**	sets the rotation of the particle */
			rotation = Math.random() * 180;
			/**	sets the rotation velocity of the particle */
			angularVelocity = Math.random() * 180 - 90;
			/**	sets the scale of the particle */
			scaleX = Math.random() * 1.5 + .5;
			/**	keeps the scale the same in X and Y */
			scaleY = scaleX;
			/**	sets the lifespan of the particle */
			lifeSpan = Math.random() * .75 - .5
		} // end ParticleEnemy
	} // end Class
} // end Package