package code {

	import flash.display.MovieClip;

	/** This is the HUD class which holds anything that the HUD does inside this class  **/
	public class HUD extends MovieClip {

		/** This var holds a player instance**/
		var player: Player = new Player();


		/** this is the constructor function for the HUD class **/
		public function HUD() {
			// constructor code

		}
		
		/**   
		  * This function handles updating the HUD instance in the game
		  * @param game passes in the sceneplay class into the HUD so that it can access certain items from the actual game
		  *
		  */
		public function update(game: ScenePlay): void {

			parent.setChildIndex(this, parent.numChildren - 1);

			scoreBoard.text = "score: " + game.playerScore; // shows the players score
			bar.scaleX = .75; // if the time bar is activated, it will go down when a player gets a powerup

			// sets hud to the players x and y
			x = player.x; 
			y = player.y;

			// if the players health is a certain number, that number of hearts should be present in the HUD
			heart1.visible = (game.playerHealth >= 1);
			heart2.visible = (game.playerHealth >= 2);
			heart3.visible = (game.playerHealth >= 3);
			heart4.visible = (game.playerHealth >= 4);
			heart5.visible = (game.playerHealth >= 5);
			heart6.visible = (game.playerHealth >= 6);

			
			if (game.hasItemOne == true) { // if the player has the first item then
				itemOne.visible = true;    // make it visible in the hud
				itemOne.gotoAndStop(1);
			} else {
				itemOne.visible = false;   // if not the don't show it
			}
			if (game.hasItemTwo == true) { // if the player has the second item then
				itemTwo.visible = true;   // make it visible in the hud
				itemTwo.gotoAndStop(1);
			} else {
				itemTwo.visible = false;   // if not the don't show it
			}
			if (game.hasItemThree == true) { // if the player has the third item then
				itemThree.visible = true;   // make it visible in the hud
				itemThree.gotoAndStop(1);
			} else {
				itemThree.visible = false; // if not the don't show it
			}
			
			if(game.hasPowerUpOne == true){ // if the player has powerup one
				powerupOne.visible = true;  // the show the powerup in the hud
			}
			else{
				powerupOne.visible = false; // if not the don't show it
			}
			if(game.hasPowerUpTwo == true){ // if the player has powerup two
				powerupTwo.visible = true;  // make it visible in the hud
			}
			else{
				powerupTwo.visible = false; // if not the don't show it
			}
			if(game.hasPowerUpThree == true){ // if the player has powerup two
				powerupThree.visible = true;  // make it visible in the hud
			}
			else{
				powerupThree.visible = false; // if not the don't show it
			}
		}
	}

}