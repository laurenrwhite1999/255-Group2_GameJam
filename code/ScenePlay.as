package code {

	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.media.SoundChannel;


	/** this is the ScenePlay class which extends to the current gamescene, which means it gives the gamescene its code */
	public class ScenePlay extends GameScene {

		/** This array holds the platform objects. */
		static public var platforms: Array = new Array();
		/** This array holds the Trick platforms */
		static public var trickPlatforms: Array = new Array();
		/** This array holds the collectables objects. */
		static public var collectables: Array = new Array();
		/** This array is the players inventory+ */
		private var inventory: Array = new Array();
		/** This array holds all of the basic enemies. */
		private var basicEnemies: Array = new Array();
		/** This array holds all of the ranged attack enemies. */
		private var rangedEnemies: Array = new Array();
		/** This array hold all of the flying enemies. */
		private var flyingEnemies: Array = new Array();

		static public var player: Player = new Player(); // brings the player into the sceneplay
		/**	This stores the current scene using a FSM. */
		private var gameScene: GameScene;
		/** This is the level to load. */
		static public var level: MovieClip;
		/** The timer that keeps track of when to shake the camera. */
		private var shakeTimer: Number = 0;
		/** How much to multiply the shake intensity by. */
		private var shakeMultiplier: Number = 20;

		/** How much to delay the spawn of the next basic enemy. */
		private var delayBasicEnemySpawn: Number = 0;
		/** How much to delay the spawn of the next ranged enemy. */
		private var delayRangedEnemySpawn: Number = 0;
		/** How much to delay the spawn of the next flying enemy. */
		private var delayFlyingEnemySpawn: Number = 0;


		/** Stores whether item one has spawned or not. */
		public static var isItemOneSpawned: Boolean = false;
		/** Stores whether item two has spawned or not. */
		public static var isItemTwoSpawned: Boolean = false;
		/** Stores whether item three has spawned or not. */
		public static var isItemThreeSpawned: Boolean = false;
		/** stores whether the player has item one or not **/
		public var hasItemOne: Boolean = false;
		/** stores whether the player has item two or not **/
		public var hasItemTwo: Boolean = false;
		/** stores whether the player has item three or not **/
		public var hasItemThree: Boolean = false;
		/** stores whether the player has powerUp or not **/
		public var hasPowerUp: Boolean = false;

		public var hasPowerUpOne: Boolean = false;
		public var hasPowerUpTwo: Boolean = false;
		public var hasPowerUpThree: Boolean = false;

		/** this var sets up the players health */
		public var playerHealth: int = 6;

		/** this var sets up the players score */
		public var playerScore: int = 0;

		/** this var holds a HUD instance **/
		public var hud: HUD;

		/** hold the games music in a music var so that it can be accessed when game is played */
		private var music: mainBGMusic = new mainBGMusic();
		/** hold the power up SFX */
		public var pwUHeart: PwUHeart = new PwUHeart();
		/** hold the power up SFX */
		public var pwUJump: PwUJump = new PwUJump();
		/** hold the power up SFX */
		public var pwUSpeed: PwUSpeed = new PwUSpeed();

		/** this var holds a new sound channel, which is the thing that controls whether the music is playing or not */
		private var myChannel: SoundChannel = new SoundChannel();

		/** How much to delay the spawn of the next powerUp */
		private var delayPowerUpsSpawn: Number = 0;
		/** This array holds all of the powerUps */
		private var powerUpsArray: Array = new Array();
		/** This is how long a power up is active*/
		public var powerUpsActiveTimer: Number = 0;
		/** This holds each particle spawned */
		private var particles: Array = new Array();

		///////////////////////////////////////////////////////////////////////// begin scene play


		/**
		 * This is the ScenePlay function.
		 */
		public function ScenePlay() {
			loadLevel();

			myChannel = music.play();

			hud = new HUD();
			addChild(hud);

			player.x = -50; // sets players x position
			player.y = -50; // sets players y position
			level.addChild(player); // adds player to scene
		} //end the ScenePlay() function

		///////////////////////////////////////////////////////////////////////

		/**
		 * this is the update function for the ScenePlay class
		 */
		override public function update(): GameScene {

			player.update(); // updates player for current frame
			spawnPowerUps();
			spawnEnemies(); // spawns the enemies
			updatePowerUps();
			updateEnemies();

			doCollisionDetection(); // does collision detection

			hud.update(this);

			KeyboardInput.update(); // updates the keyboard for the current frame
			updateParticles();
			doCameraMove();
			updateEverything();


			if (player.y > 1000 || playerHealth == 0) {
				level.removeChild(player);
				myChannel.stop();
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

		///////////////////////////////////////////////////////////////////////

		/**
		 * This function spawns the enemies.
		 */
		public function spawnEnemies(): void {
			var spawnLocation = Math.random() * stage.width + 1000;
			if (delayBasicEnemySpawn <= 0) {
				var basicEnemy: BasicEnemy = new BasicEnemy(spawnLocation, 0);
				level.addChild(basicEnemy);
				basicEnemies.push(basicEnemy);
				delayBasicEnemySpawn = 20;
			}

			if (delayRangedEnemySpawn <= 0) {
				var rangedEnemy: RangedEnemy = new RangedEnemy(spawnLocation, 0);
				level.addChild(rangedEnemy);
				rangedEnemies.push(rangedEnemy);
				delayRangedEnemySpawn = 40;
			}

			if (delayFlyingEnemySpawn <= 0) {
				var flyingEnemy: FlyingEnemy = new FlyingEnemy(spawnLocation, -40);
				level.addChild(flyingEnemy);
				flyingEnemies.push(flyingEnemy);
				delayFlyingEnemySpawn = 50;
			}

			delayBasicEnemySpawn--;
			delayRangedEnemySpawn--;
			delayFlyingEnemySpawn--;
		} // ends the spawnEnemies() function

		///////////////////////////////////////////////////////////////////////

		/**
		 * This function updates each enemy in the array.
		 */
		public function updateEnemies(): void {
			for (var i: int = basicEnemies.length - 1; i >= 0; i--) {
				basicEnemies[i].update(this);
				if (basicEnemies[i].isDead) {
					level.removeChild(basicEnemies[i]);

					basicEnemies.splice(i, 1);
				}
			} // ends the for loop updating the basic enemies

			for (var j: int = rangedEnemies.length - 1; j >= 0; j--) {
				rangedEnemies[j].update(this);
				if (rangedEnemies[j].isDead) {
					level.removeChild(rangedEnemies[j]);
					rangedEnemies.splice(j, 1);
				}
			} // ends the for loop updating the ranged enemies

			for (var k: int = flyingEnemies.length - 1; k >= 0; k--) {
				flyingEnemies[k].update(this);
				if (flyingEnemies[k].isDead) {
					level.removeChild(flyingEnemies[k]);
					flyingEnemies.splice(k, 1);
				}
			} // ends the for loop updating the flying enemies

		} // ends the updateEnemies() function

		///////////////////////////////////////////////////////////////////////

		public function spawnPowerUps(): void {
			if (delayPowerUpsSpawn <= 0) {
				var powerUp: PowerUps = new PowerUps(player, player.x, player.y)
				level.addChild(powerUp);
				powerUpsArray.push(powerUp);
				delayPowerUpsSpawn = 500;
				hasPowerUpOne = false;
				hasPowerUpTwo = false;
				hasPowerUpThree = false;
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

		///////////////////////////////////////////////////////////////////////


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
			} // end if
		} // end powerUpTimer

		///////////////////////////////////////////////////////////////////////

		/**
		 * This function updates each of the particles on the scene
		 */
		private function updateParticles(): void {
			for (var i: int = particles.length - 1; i >= 0; i--) {
				particles[i].update(player);
				if (particles[i].isDead) {
					// remove the particle
					level.removeChild(particles[i]);
					particles.splice(i, 1);
				} // end if
			} // end for loop
		} // end updateParticles

		///////////////////////////////////////////////////////////////////////

		/** 
		 * this function  spawns an explosion of particles from particle Boom
		 */
		private function spawnExplosion(): void {

			for (var i: int = 0; i < 2; i++) {
				var p: Particle = new ParticleBoom(player.x + 100, player.y);
				level.addChild(p);
				particles.push(p);
			} // end for loop
		} // end spawnExplosion

		/** 
		 * this function  spawns an explosion of particles from particleEnemy
		 */
		private function spawnEnemyParticle(): void {
			for (var i: int = 0; i < 3; i++) {
				var p: Particle = new ParticleEnemy(player.x + 50, player.y);
				level.addChild(p);
				particles.push(p);
			} // end for loop
		} // end spawnExplosion

		/** 
		 * this function  spawns an explosion of particles from particleEnemy
		 */
		private function spawnCollectingParticle(): void {
			for (var i: int = 0; i < 10; i++) {
				var p: Particle = new ParticleCollecting(player.x + 50, player.y);
				level.addChild(p);
				particles.push(p);
			} // end for loop
		} // end spawnExplosion

		///////////////////////////////////////////////////////////////////////

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

				var enemyFix: Point;

				for (var k: int = basicEnemies.length - 1; k >= 0; k--) {

					if (basicEnemies[k].collider.checkOverlap(platforms[i].collider)) {
						// find the fix:
						enemyFix = basicEnemies[k].collider.findOverlapFix(platforms[i].collider);

						// apply the fix:
						basicEnemies[k].applyEnemyFix(enemyFix);

					}
					if (basicEnemies[k].collider.checkOverlap(player.collider)) {
						basicEnemies[k].isDead = true;
						spawnEnemyParticle();
						playerHealth -= 1;
						var enDeath1:enemyDeath1 = new enemyDeath1();
						enDeath1.play();
					}
				} // ends the for loop updating enemies

				for (var l: int = rangedEnemies.length - 1; l >= 0; l--) {
					if (rangedEnemies[l].collider.checkOverlap(platforms[i].collider)) {
						// find the fix:
						enemyFix = rangedEnemies[l].collider.findOverlapFix(platforms[i].collider);
						// apply the fix:
						rangedEnemies[l].applyEnemyFix(enemyFix);
					} //end if

					if (rangedEnemies[l].collider.checkOverlap(player.collider)) {
						rangedEnemies[l].isDead = true;
						spawnEnemyParticle();
						playerHealth -= 1;
						var enDeath2:enemyDeath2 = new enemyDeath2();
						enDeath2.play();
					}
				} // ends the for loop updating the ranged enemies

				for (var u: int = powerUpsArray.length - 1; u >= 0; u--) {
					if (powerUpsArray[u].collider.checkOverlap(platforms[i].collider)) {
						//find the fix
						var powerUpFix: Point = powerUpsArray[u].collider.findOverlapFix(platforms[i].collider);
						// apply fix
						powerUpsArray[u].applyPowerUpFix(powerUpFix);
					} // end if
				} // end powerUpsArray for (check against Platforms);

				for (var j: int = 0; j < trickPlatforms.length; j++) {

					if (player.collider.checkOverlap(trickPlatforms[j].collider)) {
						// find the fix:
						fix = player.collider.findOverlapFix(trickPlatforms[j].collider);

						// apply the fix:
						if (trickPlatforms[j].idNum == 6) {
							player.maxSpeed = 150;
							player.applyFix(fix);
						}
						if (trickPlatforms[j].idNum == 5) {
							player.applyFix(fix);
							trickPlatforms[j].update(player);
						}
						if (trickPlatforms[j].idNum == 4) {
							player.applyFix(fix);
							trickPlatforms[j].update(player);
						}
						if (trickPlatforms[j].idNum == 3) {
							player.applyFix(fix);
							trickPlatforms[j].update(player);
						}
						if (trickPlatforms[j].idNum == 2) {
							player.applyFix(fix);
							trickPlatforms[j].update(player);
						}
						if (trickPlatforms[j].idNum == 1) {
							if (trickPlatforms[j].dissPlatTimer <= 0) {
								trickPlatforms[j].isDead = true;
								trickPlatforms[j].dissPlatTimer = 20;
							}
							trickPlatforms[j].dissPlatTimer--;
							player.applyFix(fix);
						}
					}


				}


				/** this loop checks the power ups against the player collision */
				for (var w: int = 0; w < powerUpsArray.length; w++) {
					if (player.collider.checkOverlap(powerUpsArray[w].collider)) {

						if (powerUpsArray[w].idNumber == 1) {
							powerUpsArray[w].powerUp1Active = true;
							powerUpsArray[w].powerUp2Active = false;
							powerUpsArray[w].powerUp3Active = false;
							powerUpsActiveTimer = 20;
							playerScore += 1;
							hasPowerUpOne = true;
							hasPowerUpTwo = false;
							hasPowerUpThree = false;
							powerUpsArray[w].isDead = true;
							pwUJump.play();
						} // end if powerUp 1
						if (powerUpsArray[w].idNumber == 2) {
							powerUpsArray[w].powerUp1Active = false;
							powerUpsArray[w].powerUp2Active = true;
							powerUpsArray[w].powerUp3Active = false;
							powerUpsArray[w].isDead = true;
							playerScore += 1;
							hasPowerUpOne = false;
							hasPowerUpTwo = true;
							hasPowerUpThree = false;
							hasPowerUp = true;
							powerUpsActiveTimer = 20;
							pwUSpeed.play();
						} // end if powerUp 2
						if (powerUpsArray[w].idNumber == 3) {
							powerUpsArray[w].powerUp1Active = false;
							powerUpsArray[w].powerUp2Active = false;
							powerUpsArray[w].powerUp3Active = true;
							powerUpsArray[w].isDead = true;
							playerScore += 1;
							hasPowerUpOne = false;
							hasPowerUpTwo = false;
							hasPowerUpThree = true;
							hasPowerUp = true;
							powerUpsActiveTimer = 20;
							pwUHeart.play();
						} // end if powerUp 3
						spawnExplosion();

					} // end if player
				} // end for loop powerups vs player

			} // ends the for() loop

			for (var r: int = flyingEnemies.length - 1; r >= 0; r--) {
				if (flyingEnemies[r].collider.checkOverlap(player.collider)) {
					flyingEnemies[r].isDead = true;
					spawnEnemyParticle();
					playerHealth -= 1;
					var enDeath3:enemyDeath3 = new enemyDeath3();
						enDeath3.play();
				}
			} // ends the for loop updating the flying enemies

			for (var l: int = 0; l < collectables.length; l++) {

				if (player.collider.checkOverlap(collectables[l].collider)) {

					if (collectables[l].idNum == 3) {
						inventory.push(collectables[l]);
						collectables[l].isDead = true;
						playerScore += 50;
						hasItemThree = true;
						var threePickUp: itemThreePickUp = new itemThreePickUp();
						threePickUp.play();

					}
					if (collectables[l].idNum == 2) {
						inventory.push(collectables[l]);
						collectables[l].isDead = true;
						playerScore += 50;
						hasItemTwo = true;
						var twoPickUp: itemTwoPickUp = new itemTwoPickUp();
						twoPickUp.play();

					}
					if (collectables[l].idNum == 1) {
						inventory.push(collectables[l]);
						collectables[l].isDead = true;
						playerScore += 50;
						hasItemOne = true;
						var onePickUp: itemOnePickUp = new itemOnePickUp();
						onePickUp.play();
					}
					spawnCollectingParticle()


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
			hasItemOne = true;
			hasItemTwo = true;
			hasItemThree = true;
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