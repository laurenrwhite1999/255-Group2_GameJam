package code{

	public class ParticleEnemy extends Particle {

		public function ParticleEnemy(spawnX: Number, spawnY: Number) {
			super(spawnX, spawnY);
			velocity.x = Math.random() * 400 - 300;
			velocity.y = Math.random() * 400 - 250;
			rotation = Math.random() * 180;
			angularVelocity = Math.random() * 180 - 90;
			scaleX = Math.random() * .15 + .5;
			scaleY = scaleX;
			lifeSpan = Math.random() * .75 - .5
		}

	}

}