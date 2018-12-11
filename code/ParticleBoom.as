package code {

	/**
	 * This class contains all the code for particles that spawn after PowerUps collision
	 * this class is a child of the Particle Class
	 */
	public class ParticleBoom extends Particle {

		public function ParticleBoom(spawnX: Number, spawnY: Number) {
			/**	this holds the position of where the particles spawn */
			super(spawnX, spawnY);
			/**	sets the velocity of the particle in X */
			velocity.x = Math.random() * 400 - 200;
			/**	sets the velocity of the particle in Y */
			velocity.y = Math.random() * 400 - 350;
			/**	sets the rotation of the particle */
			rotation = Math.random() * 360;
			/**	sets the rotation velocity of the particle */
			angularVelocity = Math.random() * 180 - 90;
			/**	sets the scale of the particle */
			scaleX = Math.random() * .5 + .5;
			/**	keeps the scale the same in X and Y */
			scaleY = scaleX;
			/**	sets the lifespan of the particle */
			lifeSpan = Math.random() * 2.5 - .5
		} // end ParticleEnemy
	} // end Class
} // end Package