package code {
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	
	/** this is the game class which extends to the movie clip, which means it gives the movie clip its code */
	public class Game extends MovieClip {
		
		/**	This stores the current scene using a FSM. */
		private var gameScene:GameScene;

		/** This array holds only Platform objects. */
		static public var platforms: Array = new Array();

		/** This is the level to load. */
		private var level: MovieClip;
		/** This is the player to load with the level. */
		private var player: Player;

		/** The timer that keeps track of when to shake the camera. */
		private var shakeTimer: Number = 0;
		/** How much to multiply the shake intensity by. */
		private var shakeMultiplier: Number = 20;

		/**
		 * This function sets up the keyboard input and adds the event listener
		 * for the game loop.
		 */
		public function Game() {
			KeyboardInput.setup(stage);
			addEventListener(Event.ENTER_FRAME, gameLoop);

			loadLevel();
		} // ends the Game() function

		} // end game function
		
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
		 * This is the game loop. It runs the game.
		 */
		private function gameLoop(e: Event): void {
			Time.update();
			player.update();

			doCollisionDetection();

			doCameraMove();

			KeyboardInput.update();
		} // ends the gameLoop() function

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

		/**
		 * Prevents the player from moving through the platforms.
		 */
		private function doCollisionDetection(): void {
			for (var i: int = 0; i < platforms.length; i++) {
				if (player.collider.checkOverlap(platforms[i].collider)) {
					// find the fix:
					/** Fixes the player in position. */
					var fix: Point = player.collider.findOverlapFix(platforms[i].collider);

					// apply the fix:
					player.applyFix(fix);
				}
			} // ends the for() loop
		} // ends the doCollisionDetection() function

	} // ends Game class

} // ends package