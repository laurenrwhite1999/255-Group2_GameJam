package code {

	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.geom.Point;


	/** this is the ScenePlay class which extends to the current gamescene, which means it gives the gamescene its code */
	public class ScenePlay extends GameScene {

		static public var platforms: Array = new Array(); // platforms array to hold
		static public var trickPlatforms: Array = new Array();
		public var trickDelay: Number = 2;
		public var trickPlatTouched: Boolean = false;
		public var player: Player = new Player(); // brings the player into the sceneplay
		public var diss: DissPlat = new DissPlat();


		/** this is the scene play function */
		public function ScenePlay() {
			player.x = 300; // sets players x position
			player.y = 225; // sets players y position
			addChild(player); // adds player to scene
			addChild(diss);



		} //end scene play

		/**
		 * this is the update function for the ScenePlay class
		 */
		override public function update(): GameScene {

			player.update(); // updates player for current frame
			doCollisionDetection(); // does collision detection
			KeyboardInput.update(); // updates the keyboard for the current frame

			if (player.y > 450) {
				removeChild(player);
				return new SceneLose(); // if the player falls off the stage return lose screen
			}
			if (player.x > 550) {
				removeChild(player);
				return new SceneWin(); // if player goes past this x position, they win!
			}



			return null; // return with nothing
		}

		/**
		 * Prevents the player from moving through the platforms.
		 */
		private function doCollisionDetection(): void {
			for (var i: int = 0; i < platforms.length; i++) {
				if (player.collider.checkOverlap(platforms[i].collider)) {
					// find the fix:
					var fix: Point = player.collider.findOverlapFix(platforms[i].collider);

					// apply the fix:
					player.applyFix(fix);
				}
			} // ends the for() loop

			for (var j: int = 0; j < trickPlatforms.length; j++) {
				if (player.collider.checkOverlap(trickPlatforms[j].collider)) {
					// find the fix:

					var fix: Point = player.collider.findOverlapFix(trickPlatforms[j].collider);

					player.applyFix(fix);
					trickPlatTouched = true;
					trickPlatforms[j].update(this);
				}

				if (trickPlatforms[j].isDead == true) {
					trickDelay -= Time.dtScaled;
					if (trickDelay <= 0) {
						removeChild(trickPlatforms[j]);
						trickPlatforms.splice(j, 1);
						trickPlatTouched = false;
						trickDelay = 4;
					}
				}


			} // ends the for() loop
		} // ends the doCollisionDetection() function


		/** this function handles adding event listeners to the scene */
		override public function onBegin(): void {

		}
		/** this function handles remove event listeners to the scene */
		override public function onEnd(): void {

		}

	}

}