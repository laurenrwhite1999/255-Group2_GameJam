package code{

	import flash.display.MovieClip;
	import flash.geom.Point;


	public class Particle extends MovieClip {


		protected var acceleration: Point = new Point(0, 0);
		protected var velocity: Point = new Point(0, 10);

		protected var angularVelocity: Number = 0;
		protected var scalarVelocity:Number = 0;
		

		protected var lifeSpan: Number;
		protected var age: Number = 0;
		public var isDead: Boolean = false;

		public function Particle(spawnX: Number, spawnY: Number) {
			x = spawnX;
			y = spawnY;


		} // end Particle

		public function update(p:Player): void {
			
			
			rotation += angularVelocity * Time.dt;
			
			scaleX += scalarVelocity * Time.dt;
			scaleY = scaleX;
			


			velocity.x += acceleration.x * Time.dt;
			velocity.y += acceleration.y * Time.dt;
			x += velocity.x * Time.dt;
			y += velocity.y * Time.dt;

			age += Time.dt;
			if(shouldDie()) isDead= true;
			if (this.y >= ScenePlay.player.y+stage.stageHeight && ScenePlay.player.x-stage.stageWidth) isDead = true;
			
		}
		
		public function shouldDie():Boolean {
				if(age > lifeSpan)return true;
			
			return false;
		}
	}

}