package code {

	import flash.display.MovieClip;


	public class Trick extends MovieClip {
		public var spawnPicker: int;
		public var idNum: int;
		public var isDead: Boolean = false;
		public var collider: ColliderAABB;

		public function Trick() {


			spawnPicker = Math.random() * 3 + 1;

			if (spawnPicker == 3) {

				collider = new ColliderAABB(width / 2, height / 2);
				collider.calcEdges(x, y);
				gotoAndStop(3);
				idNum = 3;
				ScenePlay.trickPlatforms.push(this);

			}

			if (spawnPicker == 2) {

				collider = new ColliderAABB(width / 2, height / 2);
				collider.calcEdges(x, y);
				gotoAndStop(2);
				idNum = 2;
				ScenePlay.trickPlatforms.push(this);


			}

			if (spawnPicker == 1) {

				collider = new ColliderAABB(width / 2, height / 2);
				collider.calcEdges(x, y);
				gotoAndStop(1);
				idNum = 1;
				ScenePlay.trickPlatforms.push(this);

			}


		}
	}

}