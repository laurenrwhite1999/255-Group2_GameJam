﻿package code {

	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.display.MovieClip;


	/** this is the ScenePlay class which extends to the current gamescene, which means it gives the gamescene its code */
	public class ScenePlay extends GameScene {

		static public var platforms: Array = new Array(); // platforms array to hold
		static public var collectables: Array = new Array(); // array to hold collectables

		public var player: Player = new Player(); // brings the player into the sceneplay
		/**	This stores the current scene using a FSM. */
		private var gameScene: GameScene;
		/** This is the level to load. */
		private var level: MovieClip;
		/** The timer that keeps track of when to shake the camera. */
		private var shakeTimer: Number = 0;
		/** How much to multiply the shake intensity by. */
		private var shakeMultiplier: Number = 20;
		
		public static var isItemOneSpawned:Boolean = false;
		public static var isItemTwoSpawned:Boolean = false;
		public static var isItemThreeSpawned:Boolean = false;




		/** this is the scene play function */
		public function ScenePlay() {
			loadLevel();
			player.x = 0; // sets players x position
			player.y = 0; // sets players y position
			level.addChild(player); // adds player to scene


		} //end scene play

		/**
		 * this is the update function for the ScenePlay class
		 */
		override public function update(): GameScene {

			player.update(); // updates player for current frame
			doCollisionDetection(); // does collision detection
			KeyboardInput.update(); // updates the keyboard for the current frame

			doCameraMove();
			updateCollect();


			if (player.y > 550) {
				level.removeChild(player);
				return new SceneLose(); // if the player falls off the stage return lose screen
			}
			/**
			if (player.x > 550) {
				level.removeChild(player);
				return new SceneWin(); // if player goes past this x position, they win!
			}
			*/




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

			for (var l: int = 0; l < collectables.length; l++) {

				if (player.collider.checkOverlap(collectables[l].collider)) {

					if (collectables[l].idNum == 3) {
						trace("item three picked up");
						collectables[l].isDead = true;
					}
					else if (collectables[l].idNum == 2) {
						trace("item two picked up");
						collectables[l].isDead = true;

					}
					else if (collectables[l].idNum == 1) {
						trace("item one picked up");
						collectables[l].isDead = true;
					}

				} // end if() statement

			} // end collectables for() loop


		} // ends the doCollisionDetection() function


		/** this function handles adding event listeners to the scene */
		override public function onBegin(): void {

		}
		/** this function handles remove event listeners to the scene */
		override public function onEnd(): void {
			
			isItemOneSpawned = false;
			isItemTwoSpawned = false;
			isItemThreeSpawned = false;

		} // end OnEnd


		/**
		 * This function loads whatever level the player is currently on.
		 */
		private function loadLevel(): void {
			level = new Level01;
			addChild(level);

			if (level.player) {
				player = level.player;
			} else {
				player = new Player();
				addChild(player);
			}
		} // ends the loadLevel() function

		/**
		 * This function controls the camera movement.
		 */
		private function doCameraMove(): void {
			/** The camera's position on the x axis. */
			var targetX: Number = -player.x + stage.stageWidth / 2;
			/** The camera's position on the y axis. */
			var targetY: Number = -player.y + stage.stageHeight / 2;

			/** How much to offset the x axis when the camera shakes. */
			var offsetX: Number = 0
			/** How much to offset the y axis when the camera shakes. */
			var offsetY: Number = 0

			if (shakeTimer > 0) {
				shakeTimer -= Time.dt;

				/** The intensity of the camera shake. */
				var shakeIntensity: Number = shakeTimer;
				if (shakeIntensity > 1) shakeIntensity = 1;

				shakeIntensity = 1 - shakeIntensity; // flip falloff curve
				shakeIntensity *= shakeIntensity; // bend curve
				shakeIntensity = 1 - shakeIntensity; // flip falloff curve

				/** How much to shake the screen. */
				var shakeAmount: Number = shakeMultiplier * shakeIntensity;

				offsetX = Math.random() * shakeAmount - shakeAmount / 2;
				offsetY = Math.random() * shakeAmount - shakeAmount / 2;
			}

			/** How fast to ease the camera toward the player. */
			var camEaseMultiplier: Number = 5;

			level.x += (targetX - level.x) * Time.dt * camEaseMultiplier + offsetX;
			level.y += (targetY - level.y) * Time.dt * camEaseMultiplier + offsetY;
		} // ends the doCameraMove() function

		/**
		 * This function determines when to shake the camera.
		 */
		private function shakeCamera(time: Number = .5, mult: Number = 20): void {
			shakeTimer += time;
			shakeMultiplier = mult;
		} // ends the shakeCamera() function

		private function updateCollect(): void {
			for (var i: int = 0; i < collectables.length; i++) {
				
				if (collectables[i].isDead) {
					
					level.removeChild(collectables[i]);
					collectables.splice(i, 1);
				}
			}
		}



	} // end class

} // end package