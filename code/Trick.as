package code {

	import flash.display.MovieClip;
	import flash.geom.Point;


	public class Trick extends MovieClip {
		public var spawnPicker: int;
		public var idNum: int;
		public var isDead: Boolean = false;
		public var collider: ColliderAABB;

		public var maxHeight: int = 100;
		public var minHeight: int = 300;
		public var dissPlatTimer: Number = 20;
		public var goingDown: Boolean = false;

		public function Trick() {


			spawnPicker = Math.random() * 6 + 1;

			if (spawnPicker == 6) {

				collider = new ColliderAABB(width / 2, height / 2);
				collider.calcEdges(x, y);
				gotoAndStop(6);
				idNum = 6;
				ScenePlay.trickPlatforms.push(this);

			}

			if (spawnPicker == 5) {

				collider = new ColliderAABB(width / 2, height / 2);
				collider.calcEdges(x, y);
				gotoAndStop(5);
				idNum = 5;
				ScenePlay.trickPlatforms.push(this);

			}

			if (spawnPicker == 4) {

				collider = new ColliderAABB(width / 2, height / 2);
				collider.calcEdges(x, y);
				gotoAndStop(4);
				idNum = 4;
				ScenePlay.trickPlatforms.push(this);

			}

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

		public function update(player: Player): void {

			if (idNum == 2) {
				player.y += 3;
				y += 3;
				collider.calcEdges(x, y);
			} else if (idNum == 3) {
				collider = new ColliderAABB(width / 2, height / 2);
				collider.calcEdges(x, y);
				player.x -= 5;

			} else if (idNum == 4) {


				if (goingDown == false) {
					collider = new ColliderAABB(width / 2, height / 2);
					collider.calcEdges(x, y);
					player.y -= 3;
					y -= 2;
					if (y <= maxHeight) {
						goingDown = true;
					}
				} else if (goingDown) {
					collider = new ColliderAABB(width / 2, height / 2);
					collider.calcEdges(x, y);
					player.y += 4;
					y += 2;
					if (y >= minHeight) {
						goingDown = false;
					}
				}

			} else if (idNum == 5) {
				collider = new ColliderAABB(width / 2, height / 2);
				collider.calcEdges(x, y);
				player.y += 3;
				width -= 3;
				height -= 3;

				if (height == 0) {
					isDead = true;
				}
			} else if (idNum == 6) {
				collider = new ColliderAABB(width / 2, height / 2);
				collider.calcEdges(x, y);

			}
		}
	}

}