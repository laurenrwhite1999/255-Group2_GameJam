﻿package code {

	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.display.MovieClip;


	/** this is the ScenePlay class which extends to the current gamescene, which means it gives the gamescene its code */
	public class ScenePlay extends GameScene {

		static public var platforms: Array = new Array(); // platforms array to hold
		static public var collectables: Array = new Array(); // array to hold collectables
		/** This array holds all of the basic enemies. */
		private var basicEnemies: Array = new Array();
		/** This array holds all of the ranged attack enemies. */
		private var rangedEnemies: Array = new Array();
		private var inventory: Array = new Array(); // this is the "inventory" of the player
		static public var trickPlatforms: Array = new Array(); // platforms array to hold
		
		static public var player: Player = new Player(); // brings the player into the sceneplay
		/**	This stores the current scene using a FSM. */
		private var gameScene: GameScene;
		/** This is the level to load. */
		static public var level: MovieClip;
		/** The timer that keeps track of when to shake the camera. */
		private var shakeTimer: Number = 0;
		/** How much to multiply the shake intensity by. */
		private var shakeMultiplier: Number = 20;
		/** How much to delay the spawn of the next enemy. */
		private var delayEnemySpawn: Number = 0;

		private var dissPlatTimer: Number = 20;

		public static var isItemOneSpawned: Boolean = false;
		public static var isItemTwoSpawned: Boolean = false;
		public static var isItemThreeSpawned: Boolean = false;

		/** How much to delay the spawn of the next powerUp */
		private var delayPowerUpsSpawn: Number = 0;
		/** This array holds all of the powerUps */
		private var powerUpsArray: Array = new Array();
		/** This is how long a power up is active*/
		public var powerUpsActiveTimer: Number = 0;




		/** this is the scene play function */
		public function ScenePlay() {
			loadLevel();
			var bgMusic: mainBGMusic = new mainBGMusic();
			bgMusic.play();
			player.x = 0; // sets players x position
			player.y = 0; // sets players y position
			level.addChild(player); // adds player to scene



		} //end scene play

		/**
		 * this is the update function for the ScenePlay class
		 */
		override public function update(): GameScene {

			player.update(); // updates player for current frame
			spawnPowerUps();
			spawnEnemies(); // spawns the enemies
			updatePowerUps();
			updateEnemies();
			updateEverything();
			doCollisionDetection(); // does collision detection
			KeyboardInput.update(); // updates the keyboard for the current frame

			doCameraMove();

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
		 * This function spawns the enemies.
		 */
		public function spawnEnemies(): void {
			if (delayEnemySpawn <= 0) {
				var spawnLocation = Math.random() * stage.width + 1000;
				var basicEnemy: BasicEnemy = new BasicEnemy(spawnLocation, 0);
				var rangedEnemy: RangedEnemy = new RangedEnemy(spawnLocation, 0);

				level.addChild(basicEnemy);
				basicEnemies.push(basicEnemy);

				level.addChild(rangedEnemy);
				rangedEnemies.push(rangedEnemy);

				delayEnemySpawn = 20;
			}
			delayEnemySpawn--;


		} // ends the spawnEnemies() function

		/**
		 * This function updates each enemy in the array.
		 */
		public function updateEnemies(): void {
			for (var i: int = basicEnemies.length - 1; i >= 0; i--) {
				basicEnemies[i].update();
				if (basicEnemies[i].isDead) {
					level.removeChild(basicEnemies[i]);
					basicEnemies.splice(i, 1);
				}
			} // ends the for loop updating the basic enemies

			for (var j: int = rangedEnemies.length - 1; j >= 0; j--) {
				rangedEnemies[j].update();
				if (rangedEnemies[j].isDead) {
					level.removeChild(rangedEnemies[j]);
					rangedEnemies.splice(j, 1);
				}
			} // ends the for loop updating the ranged enemies

		} // ends the updateEnemies() function

		public function spawnPowerUps(): void {
			if (delayPowerUpsSpawn <= 0) {
				var powerUp: PowerUps = new PowerUps(player, player.x, player.y)
				level.addChild(powerUp);
				powerUpsArray.push(powerUp);
				delayPowerUpsSpawn = 100;
			} // end if
			delayPowerUpsSpawn--;
		} // end spawnPowerUps

		public function updatePowerUps(): void {
			for (var u: int = powerUpsArray.length - 1; u >= 0; u--) {
				powerUpsArray[u].update();
				if (powerUpsArray[u].isDead) {
					level.removeChild(powerUpsArray[u]);
					powerUpsArray.splice(u, 1)
				} // end if
			} // end for
			updatePowerUpTimer();
		} // end updatePowerUps

		/**
		 *This function keeps track of active powerups and timer
		 */
		public function updatePowerUpTimer(): void {
			if (powerUpsActiveTimer <= 0) {
				for (var u: int = powerUpsArray.length - 1; u >= 0; u--) {
					powerUpsArray[u].powerUp1Active = false;
					powerUpsArray[u].powerUp2Active = false;
					powerUpsArray[u].powerUp3Active = false;
				}
			} else if (powerUpsActiveTimer > 0) {
				powerUpsActiveTimer--;
				trace("powerUpTimer: " + powerUpsActiveTimer);
			} // end if
		} // end powerUpTimer

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

				for (var k: int = basicEnemies.length - 1; k >= 0; k--) {

					if (basicEnemies[k].collider.checkOverlap(platforms[i].collider)) {
						// find the fix:
						var enemyFix: Point = basicEnemies[k].collider.findOverlapFix(platforms[i].collider);

						// apply the fix:
						basicEnemies[k].applyEnemyFix(enemyFix);

					}
				} // ends the for loop updating enemies

				for (var l: int = rangedEnemies.length - 1; l >= 0; l--) {
					if (rangedEnemies[l].collider.checkOverlap(platforms[i].collider)) {
						// find the fix:
						var enemyFix: Point = rangedEnemies[l].collider.findOverlapFix(platforms[i].collider);
						// apply the fix:
						rangedEnemies[l].applyEnemyFix(enemyFix);
					} //end if
				} // ends the for loop updating enemies

				for (var u: int = powerUpsArray.length - 1; u >= 0; u--) {
					if (powerUpsArray[u].collider.checkOverlap(platforms[i].collider)) {
						//find the fix
						var powerUpFix: Point = powerUpsArray[u].collider.findOverlapFix(platforms[i].collider);
						// apply fix
						powerUpsArray[u].applyPowerUpFix(powerUpFix);
					} // end if
				} // end powerUpsArray for (check against Platforms);

				for (var k: int = basicEnemies.length - 1; k >= 0; k--) {
					/** this loop checks the power ups against the player collision */
					for (var w: int = 0; w < powerUpsArray.length; w++) {
						if (player.collider.checkOverlap(powerUpsArray[w].collider)) {
							if (powerUpsArray[w].idNumber == 1) {
								powerUpsArray[w].powerUp1Active = true;
								powerUpsArray[w].powerUp2Active = false;
								powerUpsArray[w].powerUp3Active = false;
								powerUpsActiveTimer = 20;
								powerUpsArray[w].isDead = true;
							} // end if powerUp 1
							if (powerUpsArray[w].idNumber == 2) {
								powerUpsArray[w].powerUp1Active = false;
								powerUpsArray[w].powerUp2Active = true;
								powerUpsArray[w].powerUp3Active = false;
								powerUpsArray[w].isDead = true;
								powerUpsActiveTimer = 20;
							} // end if powerUp 2
							if (powerUpsArray[w].idNumber == 3) {
								powerUpsArray[w].powerUp1Active = false;
								powerUpsArray[w].powerUp2Active = false;
								powerUpsArray[w].powerUp3Active = true;
								powerUpsArray[w].isDead = true;
								powerUpsActiveTimer = 20;
							} // end if powerUp 3
						} // end if player
					} // end for loop powerups vs player
					if (basicEnemies[k].collider.checkOverlap(platforms[i].collider)) {
						// find the fix:
						var enemyFix: Point = basicEnemies[k].collider.findOverlapFix(platforms[i].collider);

						// apply the fix:
						basicEnemies[k].applyEnemyFix(enemyFix);

					}
					if (basicEnemies[k].collider.checkOverlap(player.collider)) {
						basicEnemies[k].isDead = true;
					}
				} // ends the for loop updating basic enemies

				for (var l: int = rangedEnemies.length - 1; l >= 0; l--) {
					if (rangedEnemies[l].collider.checkOverlap(platforms[i].collider)) {
						var enemyFix: Point = rangedEnemies[l].collider.findOverlapFix(platforms[i].collider);
						rangedEnemies[l].applyEnemyFix(enemyFix);
					}
				}
				/*if (rangedEnemies[l].collider.checkOverlap(player.collider)) {
					rangedEnemies[l].isDead = true;
				}*/
			} // ends the for() loop

			for (var l: int = 0; l < collectables.length; l++) {
				if (player.collider.checkOverlap(collectables[l].collider)) {
					if (collectables[l].idNum == 3) {
						trace("item three picked up");
						inventory.push(collectables[l]);
						collectables[l].isDead = true;
						trace(inventory[0]);
						trace(inventory[1]);
						trace(inventory[2]);

					} else if (collectables[l].idNum == 2) {
						trace("item two picked up");
						inventory.push(collectables[l]);
						collectables[l].isDead = true;
						trace(inventory[0]);
						trace(inventory[1]);
						trace(inventory[2]);

					} else if (collectables[l].idNum == 1) {
						trace("item one picked up");
						inventory.push(collectables[l]);
						collectables[l].isDead = true;
						trace(inventory[0]);
						trace(inventory[1]);
						trace(inventory[2]);
					}

				} // end if() statement

			} // end collectables for() loop

			for (var j: int = 0; j < trickPlatforms.length; j++) {

				if (player.collider.checkOverlap(trickPlatforms[j].collider)) {
					// find the fix:
					fix = player.collider.findOverlapFix(trickPlatforms[j].collider);

					// apply the fix:

					player.applyFix(fix);

					if (trickPlatforms[j].idNum == 3) {

						trace("works3");

					}
					if (trickPlatforms[j].idNum == 2) {


						//trickPlatforms[j].y += 5;
						trace("works2");

					}
					if (trickPlatforms[j].idNum == 1) {

						if (dissPlatTimer <= 0) {
							trickPlatforms[j].isDead = true;
							dissPlatTimer = 20;
						}
						dissPlatTimer--;

						trace("works1");
					}


				}
			}


		} // ends the doCollisionDetection() function


		/** this function handles adding event listeners to the scene */
		override public function onBegin(): void {

		}
		/** this function handles remove event listeners to the scene */
		override public function onEnd(): void {

			isItemOneSpawned = false;
			isItemTwoSpawned = false;
			isItemThreeSpawned = false;

			for (var j: int = trickPlatforms.length - 1; j >= 0; j--) {

				level.removeChild(trickPlatforms[j]);
				trickPlatforms.splice(j, 1);

			}

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

		private function updateEverything(): void {
			for (var i: int = 0; i < collectables.length; i++) {

				if (collectables[i].isDead) {

					level.removeChild(collectables[i]);
					collectables.splice(i, 1);
				}
			}
			for (var j: int = trickPlatforms.length - 1; j >= 0; j--) {
				if (trickPlatforms[j].isDead) {
					level.removeChild(trickPlatforms[j]);
					trickPlatforms.splice(j, 1);
				}
			}
		}



	} // end class

} // end package