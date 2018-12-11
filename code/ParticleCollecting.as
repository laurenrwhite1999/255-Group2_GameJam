package code{

	public class ParticleCollecting extends Particle {

		public function ParticleCollecting(spawnX: Number, spawnY: Number) {
			super(spawnX, spawnY);
			velocity.x = Math.random() * 200 - 300;
			velocity.y = Math.random() * 150- 250;
			rotation = Math.random() * 180;
			angularVelocity = Math.random() * 180 - 90;
			scaleX = Math.random() * 1.5 + .5;
			scaleY = scaleX;
			lifeSpan = Math.random() * .75 - .5
		}

	}

}