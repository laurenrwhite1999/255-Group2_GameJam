package code {

	import flash.display.MovieClip;


	public class Collect extends MovieClip {
		public var isDead: Boolean = false;
		public var spawnPicker: int = Math.random() * 3 + 1;
		public var idNum: int;
		public var collider: ColliderAABB;
		private var itemSpawned: Boolean = false;




		public function Collect() {

			while(itemSpawned == false){
				var spawnPicker: int = Math.random() * 3 + 1;
				
				if (ScenePlay.isItemThreeSpawned == false && spawnPicker == 3) {
	
					collider = new ColliderAABB(width / 2, height / 2);
					collider.calcEdges(x, y);
					idNum = 3;
					gotoAndStop(3);
					ScenePlay.isItemThreeSpawned = true;
					ScenePlay.collectables.push(this);
					itemSpawned = true;
				} 
				
				if (ScenePlay.isItemTwoSpawned == false && spawnPicker == 2) {

					collider = new ColliderAABB(width / 2, height / 2);
					collider.calcEdges(x, y);
					idNum = 2;
					gotoAndStop(2);
					ScenePlay.isItemTwoSpawned = true;
					ScenePlay.collectables.push(this);
					itemSpawned = true;

				} 
				
				if (ScenePlay.isItemOneSpawned == false && spawnPicker == 1) {

					collider = new ColliderAABB(width / 2, height / 2);
					collider.calcEdges(x, y);
					idNum = 1;
					gotoAndStop(1);
					ScenePlay.isItemOneSpawned = true;
					ScenePlay.collectables.push(this);
					itemSpawned = true;
				} 
			
				trace(spawnPicker);
			

			}

		}


	}

}